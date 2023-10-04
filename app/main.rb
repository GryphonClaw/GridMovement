require "app/includes.rb"

def settings_init args  
  args.state.ease_options ||= {start_time: 10, end_time: 10, duration: (60 * 0.15), type: :identity}

  args.state.move_distance ||= 32
  args.state.rect_position ||= {x: 0, y: 0}
  args.state.rect_target_position ||= args.state.rect_position.copy
  args.state.rect_state ||= :stationary

  args.state.move_direction ||= :east
  args.state.player_sprite ||= GameSprite.new(32, 32, 32, 32)
  args.state.show_player_sprite = true
end

def tick args
  settings_init(args)

  kb = args.inputs.keyboard

  if args.state.rect_state == :stationary
    move_key_pressed = false
    if kb.key_held.right
      move_key_pressed = true
      args.state.rect_state = :moving
      args.state.move_direction = :east
      args.state.rect_target_position = args.state.rect_position.copy
      args.state.rect_target_position.x += args.state.move_distance
    end
    if kb.key_held.left
      move_key_pressed = true
      args.state.rect_state = :moving
      args.state.move_direction = :west
      args.state.rect_target_position = args.state.rect_position.copy
      args.state.rect_target_position.x -= args.state.move_distance
    end
    if kb.key_held.up
      move_key_pressed = true
      args.state.rect_state = :moving
      args.state.move_direction = :north
      args.state.rect_target_position = args.state.rect_position.copy
      args.state.rect_target_position.y += args.state.move_distance
    end
    if kb.key_held.down
      move_key_pressed = true
      args.state.rect_state = :moving
      args.state.move_direction = :south
      args.state.rect_target_position = args.state.rect_position.copy
      args.state.rect_target_position.y -= args.state.move_distance
    end
    if move_key_pressed
      args.state.ease_options.start_time = args.state.tick_count
    end
  end

  eo = args.state.ease_options
  current_progress = args.easing.ease(eo.start_time, args.tick_count, eo.duration, eo.type)
  case args.state.rect_state
  when :moving
    case args.state.move_direction
    when :east
      position_progress = args.state.rect_position.x + (args.state.move_distance * current_progress)
    when :west
      position_progress = args.state.rect_position.x - (args.state.move_distance * current_progress)
    when :north
      position_progress = args.state.rect_position.y + (args.state.move_distance * current_progress)
    when :south
      position_progress = args.state.rect_position.y - (args.state.move_distance * current_progress)
    end
    case args.state.move_direction
    when :east, :west
      args.state.player_sprite.x = position_progress
    when :north, :south
      args.state.player_sprite.y = position_progress
    end
  when :stationary
    #do stuff when stationary
  end

  if current_progress >= 1.0 && args.state.rect_state == :moving
    args.state.rect_position = args.state.rect_target_position.copy
    args.state.rect_state = :stationary

    args.state.player_sprite.x = args.state.rect_position.x
    args.state.player_sprite.y = args.state.rect_position.y
  end

  args.outputs.primitives << args.state.player_sprite

  draw_grid(args)
  process_debug_input(args)
end

def process_debug_input(args)
  $gtk.reset_next_tick if args.inputs.keyboard.key_down.r
end
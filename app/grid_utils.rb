def draw_grid(args)
  mouse = args.inputs.mouse
  tile_x = ((mouse.x) / 32)
  tile_y = ((mouse.y) / 32)

  local_mouse_coordinates = {x: mouse.x, y: mouse.y}

  tile_w = 32
  tile_h = 32

  tile_count = {x: 40, y: 23}

  grid_cell_count_w = ((32 * tile_count.x) / tile_w).to_i
  grid_cell_count_h = ((32 * tile_count.y) / tile_h).to_i

  line_color = {r: 0, g: 0, b: 0, a: 255}
  grid = []
  (1...grid_cell_count_w).each do | x_loc |
    line_hash = {x: (x_loc * tile_w), y: 0, x2: (x_loc * tile_w), y2: (32*tile_count.y), primitive_marker: :line }.merge!(line_color)
    grid << line_hash
  end

  (1...grid_cell_count_h).each do | y_loc |
    line_hash = {x: 0, y: (y_loc * tile_h), x2: (32*tile_count.x), y2: (y_loc * tile_h), primitive_marker: :line }.merge!(line_color)
    grid << line_hash
  end
  
  args.outputs.primitives << grid
end
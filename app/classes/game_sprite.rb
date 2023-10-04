class GameSprite
  def initialize(x_position = 0, y_position = 0, width, height)
    @position = {x: x_position, y: y_position}
    @size = {w: width, h: height}
    @path = "sprites/circle/green.png"
  end
  def x
    @position.x
  end
  def x=(value)
    @position.x = value
  end
  def y
    @position.y
  end
  def y=(value)
    @position.y = value
  end
  def w
    @size.w
  end
  def h
    @size.h
  end
  def primitive_marker
    :sprite
  end
  def path
    @path
  end

  def angle
    0
  end
  def angle_anchor_x
  end
  def angle_anchor_y
  end

  def source_x
    0
  end
  def source_y
    0
  end
  def source_w
    -1
  end
  def source_h
    -1
  end

  def r
    255
  end
  def g
    255
  end
  def b
    255
  end
  def a
    255
  end

  def tile_x
    0
  end
  def tile_y
    0
  end
  def tile_x
    0
  end
  def tile_y
    0
  end
  def tile_w
    -1
  end
  def tile_h
    -1
  end

  def flip_horizontally
    false
  end
  def flip_vertically
    false
  end

  def blendmode_enum
    1
  end

  def serialize
    {class: "GameSprite"}.merge(@position).merge(@size).merge(path: @path).merge(primitive_marker: primitive_marker)
  end

  def inspect
    serialize.to_s
  end

  def to_s
    serialize.to_s
  end
end
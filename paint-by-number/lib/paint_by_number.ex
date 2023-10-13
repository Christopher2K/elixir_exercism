defmodule PaintByNumber do
  def palette_bit_size(color_count)

  def palette_bit_size(color_count, index \\ 0) do
    result = Integer.pow(2, index)
    if result >= color_count, do: index, else: palette_bit_size(color_count, index + 1)
  end

  def empty_picture(), do: <<>>

  def test_picture(), do: <<0::2, 1::2, 2::2, 3::2>>

  def prepend_pixel(picture, color_count, pixel_color_index) do
    <<pixel_color_index::size(color_count |> palette_bit_size()), picture::bitstring>>
  end

  def get_first_pixel(picture, color_count) do
    size = palette_bit_size(color_count)

    case picture do
      <<first_pixel::size(size), _::bitstring>> -> first_pixel
      <<>> -> nil
    end
  end

  def drop_first_pixel(picture, color_count) do
    size = palette_bit_size(color_count)

    case picture do
      <<_::size(size), rest::bitstring>> -> rest
      empty -> empty
    end
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end

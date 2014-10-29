require 'open-uri'

class ColorsFromImage
  NUMBER_OF_COLORS=5
  def initialize(params={})
    @image_url = params.fetch(:image)
    raise "Missing image URL" if @image_url.nil?

    process_image
    process_colors
  end

  def process_image(fs_name=Time.now.to_i)
    file_name = "tmp/#{fs_name}.image"
    open(file_name, 'wb') do |file|
      file << open(@image_url).read
    end
    @image_path = file_name
  end

  def process_colors
    path = @image_path
    # output = %x(convert #{path.strip} -dither None -colors 10 -unique-colors txt:)
    # output = %x(convert #{path.strip} -format %c  -depth 8  histogram:info:-)
    output = %x(convert #{path.strip} -dither None -colors #{NUMBER_OF_COLORS+1} -unique-colors -format %c -depth 8 histogram:info:-)

    @colors = output.scan(/(\#[0-9A-F]{6})/).flatten.map do |c|
      Color::RGB.from_html(c)
    end
  end

  def to_css
    pairs = []
    contrasts = @colors.each_with_index do |c,i|
      contrast = Color::Palette::MonoContrast.new(c)
      pairs.push [".color-machine-#{i}", contrast.foreground[0].html, contrast.background[0].html]
    end

    css=""
    pairs.each do |p|
      css << "#{p.first}{ color: #{p[1]}; background-color: #{p[2]};}\n"
      css << "#{p.first}-color{ color: #{p[1]}; }\n"
      css << "#{p.first}-background{ background-color: #{p[2]}; }\n"
    end
    css
  end
end

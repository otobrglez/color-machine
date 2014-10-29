require_relative 'boot'

class ColorMachineApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    # set :show_exceptions, false
  end

  get '/' do
    "ColorMachineApp"
  end

  get '/colors' do
    headers "Content-Type" => "text/css"
    colors = ColorsFromImage.new(url: params[:url])
    colors.to_css
  end
end

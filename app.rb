require 'rack'
require_relative 'time_converter'

class App
  def call(env)
    request = Rack::Request.new(env)
    return Rack::Response.new("Empty \"format\" params\n", 400).finish if request.params["format"].nil?

    converter = TimeConverter.new(request)
    return Rack::Response.new("Unknown time format #{converter.invalid_params}\n", 400).finish unless converter.param_valid?

    Rack::Response.new("#{converter.time}\n").finish
  end
end

require 'rack'
require_relative 'time_converter'

class App
  def call(env)
    @request = Rack::Request.new(env)
    puts !@request.params['format'].nil?
    unless !@request.params['format'].nil? && @request.path_info == '/time' && @request.get?
      return response(404, "Not Found")
    end

    converter = TimeConverter.new(@request.params)
    return response(400, "Unknown time format #{converter.invalid_params}") unless converter.param_valid?

    response(200, converter.time)
  end

  def response(status, text)
    [status, { 'Content-Type' => 'text/plain' }, [text + "\n"]]
  end
end

class TimeConverter
  TIME_PARAMS = {"year" => "%Y", "month" => "%m", "day" => "%d", "hour" => "%H", "minute" => "%M", "second" => "%S"}

  def initialize(params)
    @params = params['format'].split(',')
  end

  def time
    Time.now.strftime(time_by_format)
  end

  def param_valid?
    invalid_params.empty?
  end

  def invalid_params
    @params - TIME_PARAMS.keys
  end

  private

  def time_by_format
    time = []
    @params.each { |key| time << TIME_PARAMS[key] }
    time.join('-')
  end
end

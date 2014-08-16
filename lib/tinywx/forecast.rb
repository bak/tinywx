require 'httparty'

module TinyWx
  class Forecast

    # just for testing...
    attr_reader :weather

    def initialize(state, city)
      begin
        city = URI.escape(city)
        @uri = "http://api.wunderground.com/api/#{ENV['WUNDTOKEN']}/conditions/q/#{state}/#{city}.json"
        @response = HTTParty.get(@uri)
        @weather = @response['current_observation']['icon']
      rescue
        raise TinyWx::RequestError, "Bad request: #{@uri} => #{@response}"
      end
    end

    def to_s
      TinyWx::TranslatedForecast.new(@weather).to_s
    end

  end
end

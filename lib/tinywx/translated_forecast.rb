# encoding: utf-8
module TinyWx
  class TranslatedForecast

    def initialize(forecast)
      @forecast = forecast.to_sym
      @translation = parse_forecast(@forecast)
    end

    def to_s
      @translation
    end

    private

    def parse_forecast(forecast)
      Array(wund_forecasts[forecast]).map { |token|
        emoji[token]
      }.join(' ')
    end

    def emoji
      {
        cloud: "\u2601",
        foggy: "\u0301",
        snowflake: "\u2744",
        sun_behind_cloud: "\u26C5",
        high_voltage_sign: "\u26A1",
        black_sun_with_rays: "\u2600",
        umbrella_with_rain_drops: "\u2614",
        black_question_mark_ornament: "\u2753",
        white_question_mark_ornament: "\u2754"
      }
    end

    def wund_forecasts 
      {
        chanceflurries: [:snowflake, :white_question_mark_ornament],
        chancerain:     [:umbrella_with_rain_drops, :white_question_mark_ornament],
        chancesleet:    [:snowflake, :white_question_mark_ornament],
        chancesnow:     [:snowflake, :white_question_mark_ornament],
        chancetstorms:  [:high_voltage_sign, :white_question_mark_ornament],
        clear:          :black_sun_with_rays, # make contextual
        cloudy:         :cloud, # make contextual
        flurries:       :snowflake, 
        fog:            :foggy,
        hazy:           :foggy,
        mostlycloudy:   :cloud,
        mostlysunny:    :black_sun_with_rays,
        partlycloudy:   :sun_behind_cloud, # make contextual
        partlysunny:    :sun_behind_cloud,
        rain:           :umbrella_with_rain_drops,
        sleet:          Array.new(2, :snowflake),
        snow:           Array.new(3, :snowflake),
        sunny:          Array.new(3, :black_sun_with_rays),
        tstorms:        [:cloud, :high_voltage_sign],
        unknown:        :black_question_mark_ornament
      }
    end 

  end
end

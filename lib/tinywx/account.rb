module TinyWx
  class Account

    def initialize(name,attrs)
      begin
        @name        = name           or raise
        @state       = attrs['state'] or raise
        @city        = attrs['city']  or raise
        @oauth_token = attrs['oauth_token'] or raise
        @oauth_token_secret = attrs['oauth_token_secret'] or raise
      rescue 
        raise ArgumentError, 'incorrect format'
      end

      @forecast = ''
    end

    attr_reader :name, :state, :city, :oauth_token, :oauth_token_secret
    attr_accessor :forecast

    def to_data
      { 
        name:               name,
        state:              state, 
        city:               city, 
        oauth_token:        oauth_token, 
        oauth_token_secret: oauth_token_secret, 
        forecast:           forecast
      }
    end

  end
end

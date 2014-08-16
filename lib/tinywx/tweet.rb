module TinyWx
  class Tweet

    def initialize(data)
      begin
        @try_count = 1
        @name = data[:name] or raise "name"
        @state = data[:state] or raise "state"
        @city = data[:city] or raise "city"
        @oauth_token = data[:oauth_token] or raise "oauth_token"
        @oauth_token_secret = data[:oauth_token_secret] or raise "oauth_token_secret"
        @forecast = data[:forecast] or raise "forecast"
      rescue => e
        raise ArgumentError, "incorrect format, missing: #{e}"
      end

      begin
        @client = Twitter::Client.new(oauth_token: @oauth_token, oauth_token_secret: @oauth_token_secret)
        @client.update(@forecast)
        TinyWx.logger.info "#{@name}: #{@forecast}"
      rescue Twitter::Error::Forbidden => e
        if e.wrapped_exception =~ /Status is a duplicate/ && @try_count < 5
          @try_count += 1
          @forecast = @forecast + @forecast
          sleep 5
          retry
        end
        TinyWx.logger.error e
      rescue => e
        TinyWx.logger.error e
      end
    end
  end
end

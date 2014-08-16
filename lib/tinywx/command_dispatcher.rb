module TinyWx
  class CommandDispatcher

    def initialize(args)
      config = validate(args.pop)
      @account_set = TinyWx::AccountSet.new(config)
      retrieve_forecasts
      post_tweets
    end

    private

    def retrieve_forecasts
      # consider not mutating EmojiWx::Account here?
      @account_set.each do |account|
        account.forecast = TinyWx::Forecast.new(account.state, account.city).to_s
      end
    end

    def post_tweets
      @account_set.each { |account|
        TinyWx::Tweet.new(account.to_data)
      }
    end

    def validate(input)
      raise ArgumentError, 'no config file given' unless input
      raise ArgumentError, 'config file does not exist' unless File.exists?(input)
      input
    end
  end
end

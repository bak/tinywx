require 'tinywx/version'
require 'tinywx/command_dispatcher'
require 'tinywx/account_set'
require 'tinywx/account'
require 'tinywx/forecast'
require 'tinywx/translated_forecast'
require 'twitter'
require 'tinywx/tweet'
require 'logger'

module TinyWx

  def self.logger
    @logger ||= Logger.new("#{ENV['HOME']}/tinywx/log/out.log", 'daily')
  end

  class FileFormatError < StandardError; end
  class RequestError < StandardError; end
end

Twitter.configure do |config|
  config.consumer_key = ENV['TINYWX_CONSUMER_KEY']
  config.consumer_secret = ENV['TINYWX_CONSUMER_SECRET']
end

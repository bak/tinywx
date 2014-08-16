require 'spec_helper'

describe TinyWx::CommandDispatcher do

  describe 'initialized with no arguments' do
    it 'raises an ArgumentError' do
      expect {
        TinyWx::CommandDispatcher.new([])
      }.to raise_exception(ArgumentError, 'no config file given')
    end
  end

  describe 'initialized with nonexistent file' do
    it 'raises an ArgumentError' do
      expect {
        TinyWx::CommandDispatcher.new(['monkey.yml'])
      }.to raise_exception(ArgumentError, 'config file does not exist')
    end
  end

  describe 'initialized with present file' do
    before do
    end

    it 'creates an AccountSet' do
      account = double("account")
      account_set = double("account_set")
      account_set.stub(:each)
      n = YAML.load_file(FIXTURE_FILE_ARG).keys.size

      TinyWx::AccountSet.should_receive(:new).and_return(account_set)
      TinyWx::CommandDispatcher.new([FIXTURE_FILE_ARG])
    end

    it 'retrieves forecasts and posts tweets' do
      n = YAML.load_file(FIXTURE_FILE_ARG).keys.size

      VCR.use_cassette('integration', :serialize_with => :json) do
        TinyWx::AccountSet.should_receive(:new).and_return(Array.new(n, TinyWx::Account.new(*valid_account_attrs)))
        TinyWx::Forecast.should_receive(:new).exactly(n).times
        TinyWx::Tweet.should_receive(:new).exactly(n).times
        TinyWx::CommandDispatcher.new([FIXTURE_FILE_ARG])
      end
    end

  end

end

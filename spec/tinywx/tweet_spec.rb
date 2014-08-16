require 'spec_helper'

describe TinyWx::Tweet do

  describe 'initialized' do
    let(:data) { TinyWx::Account.new(*valid_account_attrs).to_data }

    it 'creates a twitter client' do
      client = double('twitter client')
      client.stub(:update)
      Twitter::Client.should_receive(:new).with(any_args).and_return(client)
      TinyWx::Tweet.new(data)
    end

    it 'updates through the twitter client' do
      client = double('twitter client')
      client.stub(:update)
      Twitter::Client.should_receive(:new).and_return(client)
      client.should_receive(:update)

      TinyWx::Tweet.new(data)
    end
  end
end

require 'spec_helper'

describe TinyWx::Account do

  describe 'initialized with incorrect name and hash' do
    it 'raises an exception' do
      expect {
        TinyWx::Account.new(*invalid_account_attrs)
      }.to raise_exception(ArgumentError, 'incorrect format')
    end
  end

  describe 'initialized correctly' do
    let(:account) { TinyWx::Account.new(*valid_account_attrs) }

    it 'exposes its attrs' do
      expect(account.public_methods).to include(:name, :state, :city, :oauth_token, :oauth_token_secret)
    end

    it 'sets and returns forecast' do
      account.forecast = 'monkeys'
      expect(account.forecast).to eq('monkeys')
    end

    it 'represents itself as a Hash' do
      expect(account.to_data.keys).to eq([:name, :state, :city, :oauth_token, :oauth_token_secret, :forecast])
    end

  end
end

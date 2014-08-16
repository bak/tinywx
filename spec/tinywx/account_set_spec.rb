require 'spec_helper'

describe TinyWx::AccountSet do

  describe 'initialized with bad yaml' do
    it 'raises an exception' do
      expect {
        TinyWx::AccountSet.new(BADYAML_FILE_ARG)
      }.to raise_exception(TinyWx::FileFormatError)
    end
  end

  describe 'initialized with good yaml' do
    let(:account_set) { TinyWx::AccountSet.new(FIXTURE_FILE_ARG) }

    it 'returns an enumerable set' do
      expect(account_set.respond_to?(:each)).to be_true
    end

    it 'is a collection of Accounts' do
      expect(account_set.first).to be_a(TinyWx::Account)
    end

    it 'instantiates an Account for each record' do
      n = YAML.load_file(FIXTURE_FILE_ARG).keys.size

      TinyWx::Account.should_receive(:new).exactly(n).times
      TinyWx::AccountSet.new(FIXTURE_FILE_ARG)
    end
  end

end

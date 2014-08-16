require 'spec_helper'

describe TinyWx::Forecast do

  it 'retrieves the weather from the WUND API' do
    VCR.use_cassette('sf_forecast', :serialize_with => :json) do
      forecast = TinyWx::Forecast.new("CA", "San Francisco")
      expect(forecast.weather).to eq("clear")
    end
  end

  it 'throws an exception if anything goes wrong' do
    VCR.use_cassette('bogus_params', :serialize_with => :json) do
      expect {
        TinyWx::Forecast.new("666", "Monkeys")
      }.to raise_exception(TinyWx::RequestError)
    end
  end

end

require 'spec_helper'

describe TinyWx::TranslatedForecast do

  it 'urlencodes params' do
    translation = TinyWx::TranslatedForecast.new('partlysunny').to_s
    expect(translation).to eq("\u26C5")
  end

end

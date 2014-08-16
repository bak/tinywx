require 'tinywx'
require 'vcr'

FIXTURE_FILE_ARG = 'spec/fixtures/config.yml'
BADYAML_FILE_ARG = 'spec/fixtures/bad_yaml.yml'

ENV['WUNDTOKEN'] = '0000000000000000'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

def valid_account_attrs
  [
    'tinywxpdx',
    {
      'state'              => 'OR',
      'city'               => 'Portland',
      'oauth_token'        => '12345',
      'oauth_token_secret' => '12345'
    }
  ] 
end

def invalid_account_attrs
  ['foo', {}]
end

require 'yaml'
require 'forwardable'

module TinyWx
  class AccountSet
    extend Forwardable

    def initialize(file)
      contents = YAML.load_file(file)
      raise TinyWx::FileFormatError unless contents.is_a?(Hash)
      @accounts = contents.map { |k,v| TinyWx::Account.new(k,v) }
    end

    def_delegators :@accounts, :each, :first

  end
end

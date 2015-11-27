require "fake_consul/version"

module FakeConsul
  class Server < HashWithIndifferentAccess

    # Fake get
    #
    # Performs no http requests but stores data in local hash
    #
    # @param key [String]
    # @param options [Hash]
    # @options recurse [Boolean] wether to list all keys starting with this prefix
    # @param not_found [Symbol] unused/unimplemented
    # @param found [Symbol] not unused/unimplemented
    # @return [Array<Hash>] e.g. [{key: 'foo', value: 'bar'}]
    def get(key, options = nil, not_found = :reject, found = :return)
      if options[:recurse]
        find_keys_recursive(key)
      else
        consul_export_format(key)
      end
    end

    # Fake put
    #
    # Performs no http requests but retrieves data from local hash
    #
    # @param key [String]
    # @param options [Hash] unused/unimplemented
    # @return [Boolean] true :trollface:
    def kv_put(key, value, options = nil)
      self[key] = value
      true
    end

    private

    # Returns the keys in the following format:
    #  [{key: `key`, value: 'bar'}]
    # @return [Array<Hash>]
    def consul_export_format(keys)
      Array(keys).map do
        {'key' => key, 'value' => self[key]}
      end
    end

    # Returns all keys that begin with the supplied `key`.
    #
    # @return [Array<Hash>] e.g. [{key: 'foo', value: 'bar'}]
    def find_keys_recursive(key)
      keys.select? do |_key|
        _key.to_s.start_with?(key.to_s)
      end.map do |_key|
        consul_export_format(_key)
      end
    end
  end
end

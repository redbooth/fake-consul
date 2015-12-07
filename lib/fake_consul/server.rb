require "active_support/hash_with_indifferent_access"
require "tmpdir"

module FakeConsul
  class Server < HashWithIndifferentAccess

    def initialize
      restore!
    end

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
      options ||= {}

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
    def put(key, value, options = nil)
      self[key] = value
      compact
      persist!
      true
    end

    # Fake delete
    #
    # Performs no http requests but deletes data from local hash
    #
    # @param key [String]
    # @param options [Hash] unused/unimplemented
    # @return [Boolean] true :trollface:
    def delete(key, options = nil)
      super(key)
      compact
      persist!
      true
    end

    # Clear current data
    # and delete backing marshalling file
    def clear
      super
      return unless File.exist?(db_file)
      File.delete(db_file)
    end

    private

    # Persist current data to marshalled file
    def persist!
      File.open(db_file, 'w+') do |f|
        Marshal.dump(self, f)
      end
    end

    # Restore hash from marshalled data
    def restore!
      return unless File.exist?(db_file)

      File.open(db_file) do |f|
        restored_data = Marshal.load(f)
        self.clear
        self.merge!(restored_data)
      end
    end

    # Path to marshalled file
    #
    # @return [String]
    def db_file
      "#{Dir.tmpdir}#{File::SEPARATOR}.fake_consul.m"
    end

    # Returns the keys in the following format:
    #  [{key: `key`, value: 'bar'}]
    # @return [Array<Hash>]
    def consul_export_format(keys)
      Array(keys).map do |key|
        {'key' => key, 'value' => self[key]}
      end
    end

    # Returns all keys that begin with the supplied `key`.
    #
    # @return [Array<Hash>] e.g. [{key: 'foo', value: 'bar'}]
    def find_keys_recursive(key)
      self.keys.select do |_key|
        _key.to_s.start_with?(key.to_s)
      end.map do |_key|
        consul_export_format(_key)
      end.flatten
    end

    # Remove all keys that are nil
    def compact
      delete_if { |k, v| v.nil? }
    end
  end
end

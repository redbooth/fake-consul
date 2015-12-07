require_relative '../spec_helper'

describe FakeConsul::Server do
  subject { FakeConsul::Server.new }

  before { subject.clear }

  describe '#put' do
    it 'stores key into Hash' do
      subject.put('foo', 'bar')
      subject['foo'].must_equal 'bar'
    end

    it 'returns true' do
      subject.put('foo', 'bar').must_equal true
    end

    it 'compacts the hash to remove keys with nil values' do
      subject.put('foo', nil)
      subject.key?('foo').must_equal(false)
    end
  end

  describe '#delete' do
    before { subject.put('foo', 'bar') }

    it 'delete key from Hash' do
      subject.delete('foo')
      subject.key?('foo').must_equal false
    end

    it 'returns true' do
      subject.put('foo', 'bar').must_equal true
    end

    it 'compacts the hash to remove keys with nil values' do
      subject.put('foo', nil)
      subject.key?('foo').must_equal(false)
    end
  end

  describe '#get' do
    describe 'simple (no recursing)' do
      before { subject.put('foo', 'bar') }
      let(:expected_value) { [{'key' => 'foo', 'value' => 'bar'}] }

      it 'retrieves key from Hash in an array' do
        subject.get('foo').must_equal(expected_value)
      end
    end

    describe 'with recursing' do
      before do
        subject.put('foo/bar/baz', 'baz')
        subject.put('foo/bar/bif', 'bif')
        subject.put('foo/bar/boz', 'boz')
        subject.put('foo/boom/boz', 'boz')
      end

      let(:expected_value) do
        [
          {'key' => 'foo/bar/baz', 'value' => 'baz'},
          {'key' => 'foo/bar/bif', 'value' => 'bif'},
          {'key' => 'foo/bar/boz', 'value' => 'boz'},
        ]
      end

      let(:unexpected_value) { [{'key' => 'foo/boom/boz', 'value' => 'boz'}] }

      it 'retrieves all keys beginning with supplied key from Hash in an array' do
        subject.get('foo/bar/', recurse: true).must_equal(expected_value)
      end
    end
  end
end

# FakeConsul

Fakes a consul server. Usecase is for feature specs using Diplomat client.

## Installation

Add this line to your application's Gemfile:

    gem 'fake_consul'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fake_consul

## Usage

```require fake_consul```

In your specs:

```let(:fake_kv_store) { FakeConsul::Server.new }```

```before { allow(my_instance_or_class).to receive(:kv_client).and_return(fake_kv_store) }```

## Contributing

1. Fork it ( http://github.com/redbooth/fake_consul/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# FakeConsul

Fakes a consul server. Usecase is for feature specs that need to maintain state written to consul kv store.

- Adds simple consul client that fakes the consul server and provides state in an in-memory Hash.
- Client API conforms to that of [Diplomat::Kv](http://www.rubydoc.info/github/WeAreFarmGeek/diplomat/Diplomat/Kv) (See source here: [Diplomat](https://github.com/WeAreFarmGeek/diplomat) )

[![Build Status](https://circleci.com/gh/redbooth/fake_consul/tree/master.png)](https://circleci.com/gh/redbooth/fake_consul)

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

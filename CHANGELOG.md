# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [v0.0.7] - 2015-12-07
- Adds `delete` command

## [v0.0.6] - 2015-11-27
- Add persistance to disk

## [v0.0.5] - 2015-11-27
- Add missing require

## [v0.0.4] - 2015-11-27
- Compact hash on `put` to remove keys with nil values

## [v0.0.3] - 2015-11-27
- Fix double implementation of server

## [v0.0.2] - 2015-11-27
- More open dependency on activesupport

## [v0.0.1] - 2015-11-27
### Initial implementation
- Adds simple consul client that fakes the consul server and provides state in an in-memory Hash.
- Client API conforms to that of [Diplomat::Kv](http://www.rubydoc.info/github/WeAreFarmGeek/diplomat/Diplomat/Kv) (See source here: [Diplomat](https://github.com/WeAreFarmGeek/diplomat) )

[unreleased]: https://github.com/redbooth/fake_consul/compare/v0.0.7...HEAD
[v0.0.7]: https://github.com/redbooth/fake_consul/tree/v0.0.7
[v0.0.6]: https://github.com/redbooth/fake_consul/tree/v0.0.6
[v0.0.5]: https://github.com/redbooth/fake_consul/tree/v0.0.5
[v0.0.4]: https://github.com/redbooth/fake_consul/tree/v0.0.4
[v0.0.3]: https://github.com/redbooth/fake_consul/tree/v0.0.3
[v0.0.2]: https://github.com/redbooth/fake_consul/tree/v0.0.2
[v0.0.1]: https://github.com/redbooth/fake_consul/tree/v0.0.1

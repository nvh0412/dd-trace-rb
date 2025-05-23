<div class="alert alert-info">This documentation is for <code>datadog</code> gem v2.x. If you are looking for <code>ddtrace</code> gem v1.x documentation, see the legacy <a href="https://docs.datadoghq.com/tracing/trace_collection/compatibility/ruby_v1/">Ruby Compatibility Requirements
</a> documentation.</div>

## Compatibility

The Ruby Datadog Trace library is open source. See the [dd-trace-rb][1] GitHub repository for more information.

### Supported Ruby interpreters

| Type  | Documentation              | Version   | Support type              | Gem version support |
|-------|----------------------------|-----------|---------------------------|---------------------|
| MRI   | https://www.ruby-lang.org/ | 3.4       | [latest](#support-latest) | Latest              |
|       |                            | 3.3       | [latest](#support-latest) | Latest              |
|       |                            | 3.2       | [latest](#support-latest) | Latest              |
|       |                            | 3.1       | [latest](#support-latest) | Latest              |
|       |                            | 3.0       | [latest](#support-latest) | Latest              |
|       |                            | 2.7       | [latest](#support-latest) | Latest              |
|       |                            | 2.6       | [latest](#support-latest) | Latest              |
|       |                            | 2.5       | [latest](#support-latest) | Latest              |
|       |                            | 2.4       | [EOL](#support-eol)       | < 2.0.0             |
|       |                            | 2.3       | [EOL](#support-eol)       | < 2.0.0             |
|       |                            | 2.2       | [EOL](#support-eol)       | < 2.0.0             |
|       |                            | 2.1       | [EOL](#support-eol)       | < 2.0.0             |
|       |                            | 2.0       | [EOL](#support-eol)       | < 0.50.0            |
|       |                            | 1.9       | [EOL](#support-eol)       | < 0.27.0            |
| JRuby | https://www.jruby.org      | 9.4       | [latest](#support-latest) | Latest              |
|       |                            | 9.3       | [latest](#support-latest) | Latest              |
|       |                            | 9.2.21.0+ | [latest](#support-latest) | Latest              |

### Supported web servers

| Type      | Documentation                     | Version      | Support type              |
|-----------|-----------------------------------|--------------|---------------------------|
| Puma      | http://puma.io/                   | 2.16+ / 3.6+ | [latest](#support-latest) |
| Unicorn   | https://bogomips.org/unicorn/     | 4.8+ / 5.1+  | [latest](#support-latest) |
| Passenger | https://www.phusionpassenger.com/ | 5.0+         | [latest](#support-latest) |

### Supported tracing frameworks

| Type        | Documentation                                   | Version | Support type        | Gem version support |
|-------------|-------------------------------------------------|---------|---------------------|---------------------|
| OpenTelemetry | https://github.com/open-telemetry/opentelemetry-ruby | >= 1.1.0 | [latest](#support-latest) | 1.9.0+ |
| OpenTracing | https://github.com/opentracing/opentracing-ruby | 0.4.1+  | [EOL](#support-eol) | < 2.0.0             |

### Supported operating systems

| OS            | Support type                            | Package version |
|---------------|-----------------------------------------|-----------------|
| Linux x86_64  | [latest](#support-latest)               | Latest          |
| Linux aarch64 | [latest](#support-latest)               | Latest          |
| macOS         | Dev environments only                   | Latest          |
| MS Windows    | [Unimplemented](#support-unimplemented) | Latest          |

Need linux support for a CPU architecture not listed? [Contact our customer support team for special requests.][49]

### Supported Datadog agent versions

| Datadog Agent version | Support type              | Package version |
|-----------------------|---------------------------|-----------------|
| [7.x][53]             | [latest](#support-latest) | Latest          |
| [6.x][53]             | [Latest](#support-latest) | Latest          |
| [5.x][54]             | [Latest](#support-latest) | Latest          |

## Integrations

For a list of available integrations, and their configuration options, refer to the following:

| Name                       | Key                        | Versions Supported: MRI                     | Versions Supported: JRuby                   | How to configure | Gem source                                                                   |
|----------------------------|----------------------------|---------------------------------------------|---------------------------------------------|------------------|------------------------------------------------------------------------------|
| Action Cable               | `action_cable`             | `>= 5.0`                                    | `>= 5.0`                                    | [Link][2]        | [Link](https://github.com/rails/rails/tree/master/actioncable)               |
| Action Mailer              | `action_mailer`            | `>= 5.0`                                    | `>= 5.0`                                    | [Link][3]        | [Link](https://github.com/rails/rails/tree/master/actionmailer)              |
| Action Pack                | `action_pack`              | `>= 4.0`                                    | `>= 4.0`                                    | [Link][4]        | [Link](https://github.com/rails/rails/tree/master/actionpack)                |
| Action View                | `action_view`              | `>= 4.0`                                    | `>= 4.0`                                    | [Link][5]        | [Link](https://github.com/rails/rails/tree/master/actionview)                |
| Active Job                 | `active_job`               | `>= 4.2`                                    | `>= 4.2`                                    | [Link][6]        | [Link](https://github.com/rails/rails/tree/master/activejob)                 |
| Active Model Serializers   | `active_model_serializers` | `>= 0.9`                                    | `>= 0.9`                                    | [Link][7]        | [Link](https://github.com/rails-api/active_model_serializers)                |
| Active Record              | `active_record`            | `>= 4.0`                                    | `>= 4.0`                                    | [Link][8]        | [Link](https://github.com/rails/rails/tree/master/activerecord)              |
| Active Support             | `active_support`           | `>= 4.0`                                    | `>= 4.0`                                    | [Link][9]        | [Link](https://github.com/rails/rails/tree/master/activesupport)             |
| AWS                        | `aws`                      | `>= 2.0`                                    | `>= 2.0`                                    | [Link][10]       | [Link](https://github.com/aws/aws-sdk-ruby)                                  |
| Concurrent Ruby            | `concurrent_ruby`          | `>= 0.9`                                    | `>= 0.9`                                    | [Link][11]       | [Link](https://github.com/ruby-concurrency/concurrent-ruby)                  |
| Dalli                      | `dalli`                    | `>= 2.0`                                    | `>= 2.0`                                    | [Link][12]       | [Link](https://github.com/petergoldstein/dalli)                              |
| DelayedJob                 | `delayed_job`              | `>= 4.1`                                    | `>= 4.1`                                    | [Link][13]       | [Link](https://github.com/collectiveidea/delayed_job)                        |
| Elasticsearch              | `elasticsearch`            | `>= 1.0`                                    | `>= 1.0`                                    | [Link][14]       | [Link](https://github.com/elastic/elasticsearch-ruby)                        |
| Ethon                      | `ethon`                    | `>= 0.11`                                   | `>= 0.11`                                   | [Link][15]       | [Link](https://github.com/typhoeus/ethon)                                    |
| Excon                      | `excon`                    | `>= 0.50`                                   | `>= 0.50`                                   | [Link][16]       | [Link](https://github.com/excon/excon)                                       |
| Faraday                    | `faraday`                  | `>= 0.14`                                   | `>= 0.14`                                   | [Link][17]       | [Link](https://github.com/lostisland/faraday)                                |
| Grape                      | `grape`                    | `>= 1.0`                                    | `>= 1.0`                                    | [Link][18]       | [Link](https://github.com/ruby-grape/grape)                                  |
| GraphQL                    | `graphql`                  | `>= 2.2.6`, `2.1.11+`,`2.0.28+`, `1.13.21+` | `>= 2.2.6`, `2.1.11+`,`2.0.28+`, `1.13.21+` | [Link][19]       | [Link](https://github.com/rmosolgo/graphql-ruby)                             |
| gRPC                       | `grpc`                     | `>= 1.7`                                    | *gem not available*                         | [Link][20]       | [Link](https://github.com/grpc/grpc/tree/master/src/rubyc)                   |
| hanami                     | `hanami`                   | `>= 1`, `< 2`                               | `>= 1`, `< 2`                               | [Link][21]       | [Link](https://github.com/hanami/hanami)                                     |
| http.rb                    | `httprb`                   | `>= 2.0`                                    | `>= 2.0`                                    | [Link][22]       | [Link](https://github.com/httprb/http)                                       |
| httpclient                 | `httpclient`               | `>= 2.2`                                    | `>= 2.2`                                    | [Link][23]       | [Link](https://github.com/nahi/httpclient)                                   |
| httpx                      | `httpx`                    | `>= 0.11`                                   | `>= 0.11`                                   | [Link][24]       | [Link](https://gitlab.com/honeyryderchuck/httpx)                             |
| Kafka                      | `ruby-kafka`               | `>= 0.7.10`                                 | `>= 0.7.10`                                 | [Link][25]       | [Link](https://github.com/zendesk/ruby-kafka)                                |
| Karafka                    | `karafka`                  | `>= 2.3.0`                                  | `>= 2.3.0`                                  | [Link][55]       | [Link](https://karafka.io/) |
| Makara (via Active Record) | `makara`                   | `>= 0.3.5`                                  | `>= 0.3.5`                                  | [Link][8]        | [Link](https://github.com/instacart/makara)                                  |
| MongoDB                    | `mongo`                    | `>= 2.1`                                    | `>= 2.1`                                    | [Link][26]       | [Link](https://github.com/mongodb/mongo-ruby-driver)                         |
| MySQL2                     | `mysql2`                   | `>= 0.3.21`                                 | *gem not available*                         | [Link][27]       | [Link](https://github.com/brianmario/mysql2)                                 |
| Net/HTTP                   | `http`                     | *(Any supported Ruby)*                      | *(Any supported Ruby)*                      | [Link][28]       | [Link](https://ruby-doc.org/stdlib-2.4.0/libdoc/net/http/rdoc/Net/HTTP.html) |
| OpenSearch                 | `opensearch-ruby`          | `>= 1.0.0`                                  | `>= 1.0.0`                                  | [Link][29]       | [Link](https://github.com/opensearch-project/opensearch-ruby)                |
| Postgres                   | `pg`                       | `>= 0.18.4`                                 | *gem not available*                         | [Link][30]       | [Link](https://github.com/ged/ruby-pg)                                       |
| Presto                     | `presto`                   | `>= 0.5.14`                                 | `>= 0.5.14`                                 | [Link][31]       | [Link](https://github.com/treasure-data/presto-client-ruby)                  |
| Que                        | `que`                      | `>= 1.0.0.beta2`                            | `>= 1.0.0.beta2`                            | [Link][33]       | [Link](https://github.com/que-rb/que)                                        |
| Racecar                    | `racecar`                  | `>= 0.3.5`                                  | `>= 1.3.5`                                  | [Link][34]       | [Link](https://github.com/zendesk/racecar)                                   |
| Rack                       | `rack`                     | `>= 1.1`                                    | `>= 1.1`                                    | [Link][35]       | [Link](https://github.com/rack/rack)                                         |
| Rails                      | `rails`                    | `>= 4.0`                                    | `>= 4.0`                                    | [Link][36]       | [Link](https://github.com/rails/rails)                                       |
| Rake                       | `rake`                     | `>= 12.0`                                   | `>= 12.0`                                   | [Link][37]       | [Link](https://github.com/ruby/rake)                                         |
| Redis                      | `redis`                    | `>= 3.2`                                    | `>= 3.2`                                    | [Link][38]       | [Link](https://github.com/redis/redis-rb)                                    |
| Resque                     | `resque`                   | `>= 1.0`                                    | `>= 1.0`                                    | [Link][39]       | [Link](https://github.com/resque/resque)                                     |
| Rest Client                | `rest-client`              | `>= 1.8`                                    | `>= 1.8`                                    | [Link][40]       | [Link](https://github.com/rest-client/rest-client)                           |
| Roda                       | `roda`                     | `>= 2.1, <4`                                | `>= 2.1, <4`                                | [Link][41]       | [Link](https://github.com/jeremyevans/roda)                                  |
| Sequel                     | `sequel`                   | `>= 3.41`                                   | `>= 3.41`                                   | [Link][42]       | [Link](https://github.com/jeremyevans/sequel)                                |
| Shoryuken                  | `shoryuken`                | `>= 3.2`                                    | `>= 3.2`                                    | [Link][43]       | [Link](https://github.com/phstc/shoryuken)                                   |
| Sidekiq                    | `sidekiq`                  | `>= 3.5.4`                                  | `>= 3.5.4`                                  | [Link][44]       | [Link](https://github.com/mperham/sidekiq)                                   |
| Sinatra                    | `sinatra`                  | `>= 1.4`                                    | `>= 1.4`                                    | [Link][45]       | [Link](https://github.com/sinatra/sinatra)                                   |
| Sneakers                   | `sneakers`                 | `>= 2.12.0`                                 | `>= 2.12.0`                                 | [Link][46]       | [Link](https://github.com/jondot/sneakers)                                   |
| Stripe                     | `stripe`                   | `>= 5.15.0`                                 | `>= 5.15.0`                                 | [Link][47]       | [Link](https://github.com/stripe/stripe-ruby)                                |
| Sucker Punch               | `sucker_punch`             | `>= 2.0`                                    | `>= 2.0`                                    | [Link][48]       | [Link](https://github.com/brandonhilkert/sucker_punch)                       |

### Support Policy

Datadog for Ruby is built upon dependencies defined in specific versions of the host operating system, Ruby
runtime, certain Ruby libraries, and the Datadog Agent/API. When these versions are no longer supported by their
maintainers, Datadog for Ruby limits its support for these as well.

#### Levels of Support

| **Level**                                             | **Support provided**                                                                                                                      |
|-------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------|
| <span id="support-unsupported">Unsupported</span>     | Possibly functional, but not tested or supported. [Contact our customer support team for special requests.][49]                           |
| <span id="support-unimplemented">Unimplemented</span> | No implementation. [Contact our customer support team for special requests.][49]                                                          |
| <span id="support-prerelease">Pre-release</span>      | Initial implementation. May not yet contain all features. Support for new features, bug & security fixes provided on a best-effort basis. |
| <span id="support-latest">Latest</span>               | Full implementation of all features. Full support for new features, bug & security fixes.                                                 |
| <span id="support-maintenance">Maintenance</span>     | Full implementation of existing features. Does not receive new features. Support for critical bug & security fixes only.                  |
| <span id="support-eol">End-of-life (EOL)</span>       | No support. The version can still be used but no bugfixes will be provided.                                                               |

#### Package Versioning

Datadog for Ruby practices [semantic versioning][50].

As this relates to downgrading runtime support, it implies:

- **Major version updates** (e.g. `1.0.0` to `2.0.0`) may change support for any runtime
  from [Beta](#support-prerelease)/[Latest](#support-latest)
  to [Maintenance](#support-maintenance)/[EOL](#support-eol).
- **Minor version updates** (e.g. `1.0.0` to `1.1.0`) may change support for any runtime
  from [Beta](#support-prerelease)/[Latest](#support-latest) to [Maintenance](#support-maintenance).
- **Patch version updates** (e.g. `1.0.0` to `1.0.1`) will not change support for any runtime.

#### Library version support

Datadog for Ruby will provide GA support for the latest major version and maintenance support for the previous major
version of the library. This support will be provided through the latest minor or patch version of the major version.
For example, if 1.21.0 is the latest version of the library with maintenance support, bug fixes will be provided via a
new release of 1.21.0 (or 1.20.1). Those bugfixes will not be backported as patches to previous minor versions of 1.x.

| Gem Major Version | Support type                        |
|-------------------|-------------------------------------|
| 2.x               | [Latest](#support-latest)           |
| 1.x               | [Maintenance](#support-maintenance) |
| 0.x               | [EOL](#support-eol)                 |

#### Additional support resources

- [Datadog Customer support][49]
- [Datadog for Ruby Setup Documentation][51]
- [Datadog for Ruby GitHub repository][52]

[1]: https://github.com/DataDog/dd-trace-rb

[2]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#action-cable

[3]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#action-mailer

[4]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#action-pack

[5]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#action-view

[6]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#active-job

[7]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#active-model-serializers

[8]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#active-record

[9]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#active-support

[10]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#aws

[11]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#concurrent-ruby

[12]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#dalli

[13]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#delayedjob

[14]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#elasticsearch

[15]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#ethon

[16]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#excon

[17]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#faraday

[18]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#grape

[19]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#graphql

[20]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#grpc

[21]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#hanami

[22]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#httprb

[23]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#httpclient

[24]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#httpx

[25]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#kafka

[26]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#mongodb

[27]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#mysql2

[28]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#nethttp

[29]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#opensearch

[30]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#postgres

[31]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#presto

[33]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#que

[34]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#racecar

[35]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#rack

[36]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#rails

[37]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#rake

[38]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#redis

[39]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#resque

[40]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#rest-client

[41]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#roda

[42]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#sequel

[43]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#shoryuken

[44]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#sidekiq

[45]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#sinatra

[46]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#sneakers

[47]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#stripe

[48]: https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/ruby#sucker-punch

[49]: https://www.datadoghq.com/support

[50]: https://semver.org

[51]: https://docs.datadoghq.com/tracing/setup_overview/setup/ruby

[52]: https://github.com/DataDog/dd-trace-rb

[53]: https://docs.datadoghq.com/agent/basic_agent_usage/?tab=agentv6v7

[54]: https://docs.datadoghq.com/agent/basic_agent_usage/?tab=agentv5

[55]: https://docs.datadoghq.com/tracing/trace_collection/automatic_instrumentation/dd_libraries/ruby/#karafka

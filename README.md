# CloudConnect
Simple Ruby wrapper for the CloudConnect v3 API.

## Installation

```bash
gem install cloud_connect
```

## Documentation

http://rdoc.info/gems/cloud_connect

## Authenticated Requests

### Setup a client with your token

```ruby
cc = CloudConnect::Client.new(:account => "demo", :token => "token")
cc.asset("imei")
```

## Examples

### Show an asset

```ruby
cc.asset("imei")
=> #<Hashie::Mash imei="imei" name=nil serial=nil url="http://url.cloudconnect.io/api/v3/assets/imei">
```

### Show last messages for an asset

```ruby
cc.messages(asset:"imei")
```

### Channels

```
cc.channels
```

require 'spec_helper'

RSpec.describe 'CloudConnect Faraday stack' do
  def build_client(stubs)
    CloudConnect::Client.new(
      account: 'demo',
      token: 'token',
      api_url: 'example.com',
      api_path: '',
      adapter: [:test, stubs],
    )
  end

  it 'parses JSON and returns a Hashie::Mash (including nested hashes)' do
    stubs = Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get('/test') do
        [
          200,
          { 'Content-Type' => 'application/json' },
          '{"foo":{"bar":1},"list":[{"x":2}]}'
        ]
      end
    end

    client = build_client(stubs)
    result = client.get('/test')

    expect(result).to be_a(Hashie::Mash)
    expect(result.foo).to be_a(Hashie::Mash)
    expect(result.foo.bar).to eq(1)
    expect(result.list.first).to be_a(Hashie::Mash)
    expect(result.list.first.x).to eq(2)

    stubs.verify_stubbed_calls
  end

  it 'raises CloudConnect errors on non-2xx responses' do
    stubs = Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get('/missing') do
        [
          404,
          { 'Content-Type' => 'application/json' },
          '{"title":"NotFound","message":"missing","errors":["nope"]}'
        ]
      end
    end

    client = build_client(stubs)

    expect { client.get('/missing') }
      .to raise_error(CloudConnect::NotFound, /GET .*: 404/)

    stubs.verify_stubbed_calls
  end
end

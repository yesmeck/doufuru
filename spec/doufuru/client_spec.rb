require 'spec_helper'

describe Doufuru::Client do

  describe 'module configuration' do

    before do
      Doufuru.reset!
      Doufuru.configure do |config|
        Doufuru::Configurable.keys.each do |key|
          config.send("#{key}=", "Some #{key}")
        end
      end
    end

    after do
      Doufuru.reset!
    end

    it 'inherits the module configuration' do
      client = Doufuru::Client.new
      Doufuru::Configurable.keys.each do |key|
        expect(client.instance_variable_get(:"@#{key}")).to eq "Some #{key}"
      end
    end

    describe "with class level copnfiguration" do

      let(:opts)  do
        {
          connection_options: { ssl: { verify: false } },
          per_page: 40,
          login: 'coolzi'
        }
      end

      it 'overrides module configuration' do
        client = Doufuru::Client.new(opts)
        expect(client.per_page).to eq 40
        expect(client.login).to eq 'coolzi'
        expect(client.auto_paginate).to eq Doufuru.auto_paginate
        expect(client.client_id).to eq Doufuru.client_id
      end

      it 'can set configuration after initialization' do
        client = Doufuru::Client.new
        client.configure do |config|
          opts.each do |key, value|
            config.send("#{key}=", value)
          end
        end
        expect(client.per_page).to eq 40
        expect(client.login).to eq 'coolzi'
        expect(client.auto_paginate).to eq Doufuru.auto_paginate
        expect(client.client_id).to eq Doufuru.client_id
      end

      it 'masks token on inspect' do
        client = Doufuru::Client.new(access_token: '87614b09dd141c22800f96f11737ade5226d7ba8' )
        expect(client.inspect).to_not match '87614b09dd141c22800f96f11737ade5226d7ba8'
      end

    end

  end

  describe 'authentication' do

    let(:client) { Doufuru.client }

    before do
      Doufuru.reset!
    end

    describe 'with module level config' do
      it 'sets oauth token with .configure' do
        Doufuru.configure do |config|
          config.access_token = '87614b09dd141c22800f96f11737ade5226d7ba8'
        end
        expect(Doufuru.client).to be_token_authenticated
      end

      it 'sets oauth token with module methods' do
        Doufuru.access_token = '87614b09dd141c22800f96f11737ade5226d7ba8'
        expect(Doufuru.client).to be_token_authenticated
      end
    end

    describe 'with class level config' do
      it 'sets oauth token with .configure' do
        client.configure do |config|
          config.access_token = '87614b09dd141c22800f96f11737ade5226d7ba8'
        end
        expect(client).to be_token_authenticated
      end

      it 'sets oauth token with instance methods' do
        client.access_token = '87614b09dd141c22800f96f11737ade5226d7ba8'
        expect(client).to be_token_authenticated
      end
    end
  end

  describe '.agent' do
    before do
      Doufuru.reset!
    end

    it 'acts like a Sawyer agent' do
      expect(Doufuru.client.agent).to respond_to :start
    end

    it 'caches the agent' do
      agent = Doufuru.client.agent
      expect(agent.object_id).to eq Doufuru.client.agent.object_id
    end
  end

  describe '.last_response', :vcr do
    it 'caches the last agent response' do
      Doufuru.reset!
      client = Doufuru.client
      expect(client.last_response).to be_nil
      client.get 'book/1220562'
      expect(client.last_response.status).to eq 200
    end
  end

  describe '.get', :vcr do
    it 'handles query params' do
      Doufuru.reset!
      Doufuru.get '', foo: 'bar'
      expect(a_get('https://api.douban.com/v2?foo=bar')).to have_been_made
    end
  end

  describe '.head', :vcr do
    it 'handles query params' do
      Doufuru.reset!
      Doufuru.head '', foo: 'bar'
      expect(a_head('https://api.douban.com/v2?foo=bar')).to have_been_made
    end
  end

  describe 'when making requests' do
    before(:each) do
      Doufuru.reset!
    end

    let(:client) { Doufuru.client }

    it 'sets a default user agent' do
      stub = stub_get('book/1220562').
        with(headers: { user_agent: Doufuru::Default.user_agent })
      client.get 'book/1220562'
      expect(stub).to have_been_requested
      expect(client.last_response.status).to eq 200
    end

    it 'sets a custom user agent' do
      user_agent = 'Mozilla/5.0 I am Spartacus!'
      stub = stub_get('book/1220562').
        with(headers: { user_agent: user_agent })
      client = Doufuru::Client.new user_agent: user_agent
      client.get 'book/1220562'
      expect(stub).to have_been_requested
      expect(client.last_response.status).to eq 200
    end

    it 'sets a proxy server' do
      client = Doufuru::Client.new proxy: 'http://proxy.example.com'
      conn = client.send(:agent).instance_variable_get(:"@conn")
      expect(conn.proxy[:uri].to_s).to eq 'http://proxy.example.com'
    end
  end

end

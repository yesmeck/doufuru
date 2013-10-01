require 'spec_helper'

describe Doufuru do
  around do
    Doufuru.reset!
  end

  it 'sets defaults' do
    Doufuru::Configurable.keys.each do |key|
      expect(Doufuru.instance_variable_get(:"@#{key}")).to eq Doufuru::Default.send(key)
    end
  end

  describe '.client' do
    it 'create a Doufuru::Client' do
      expect(Doufuru.client).to be_kind_of Doufuru::Client
    end

    it 'cache the client when the same options are passed' do
      expect(Doufuru.client.object_id).to eq Doufuru.client.object_id
    end

    it 'return a fresh client when options are not the same' do
      client_one = Doufuru.client
      Doufuru.access_token = '87614b09dd141c22800f96f11737ade5226d7ba8'
      client_two = Doufuru.client
      client_three = Doufuru.client
      expect(client_one).to_not eq client_two
      expect(client_three).to_not eq client_two
    end

    describe '.configure' do
      Doufuru::Configurable.keys.each do |key|
        it "sets the #{key.to_s.gsub('_', ' ')}" do
          Doufuru.configure do |config|
            config.send("#{key}=", key)
          end
          expect(Doufuru.instance_variable_get(:"@#{key}")).to eq key
        end
      end
    end
  end
end

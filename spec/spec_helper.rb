require 'dotenv'
Dotenv.load

require 'doufuru'
require 'json'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |c|
  c.configure_rspec_metadata!
  c.filter_sensitive_data('<DOUBAN_TOKEN>') do
    ENV['DOUBAN_TOKEN']
  end
  c.default_cassette_options = {
    serialize_with: :json,
    preserve_exact_body_bytes: true,
    decode_compressed_response: true,
    record: ENV['TRAVIS'] ? :none : :once
  }
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
end

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/{support,shared}/**/*.rb"].each { |f| require f }

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.include SpecHelper
  config.include WebMockHelper
end

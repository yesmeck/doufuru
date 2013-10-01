module SpecHelper

  def test_douban_token
    ENV.fetch 'DOUFURU_TEST_DOUBAN_TOKEN'
  end

  def test_douban_client_id
    ENV.fetch 'DOUFURU_TEST_DOUBAN_CLIENT_ID'
  end

  def test_douban_client_secret
    ENV.fetch 'DOUFURU_TEST_DOUBAN_CLIENT_SECRET'
  end

  def fixture_path
    File.expand_path('../../fixtures', __FILE__)
  end

  def fixture(file)
    File.new(File.join(fixture_path, file))
  end

  def json_response(file)
    {
      body: fixture(file),
      headers: {
        content_type: 'application/json; charset=utf-8'
      }
    }
  end

  def oauth_client
    Doufuru::Client.new(access_token: ENV.fetch('DOUFURU_TEST_DOUBAN_TOKEN'))
  end

end

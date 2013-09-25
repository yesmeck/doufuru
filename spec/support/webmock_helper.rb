module WebmockHelper
  def stub_get(path)
    stub_request(:get, douban_url(path))
  end

  def stub_post(path)
    stub_request(:post, douban_url(path))
  end

  def stub_put(path)
    stub_request(:put, douban_url(path))
  end

  def stub_delete(path)
    stub_request(:delete, douban_url(path))
  end

  def a_get(path)
    a_request(:get, douban_url(path))
  end

  def a_post(path)
    a_request(:post, douban_url(path))
  end

  def a_put(path)
    a_request(:put, douban_url(path))
  end

  def a_delete(path)
    a_request(:delete, douban_url(path))
  end
end

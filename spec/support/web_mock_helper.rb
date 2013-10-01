module WebMockHelper
  def douban_url(url)
    url =~ /^http/ ? url : "https://api.douban.com/v2/#{url}"
  end

  def stub_delete(url)
    stub_request(:delete, douban_url(url))
  end

  def stub_get(url)
    stub_request(:get, douban_url(url))
  end

  def stub_head(url)
    stub_request(:head, douban_url(url))
  end

  def stub_patch(url)
    stub_request(:patch, douban_url(url))
  end

  def stub_post(url)
    stub_request(:post, douban_url(url))
  end

  def stub_put(url)
    stub_request(:put, douban_url(url))
  end

  def a_delete(url)
    a_request(:delete, douban_url(url))
  end

  def a_get(url)
    a_request(:get, douban_url(url))
  end

  def a_head(url)
    a_request(:head, douban_url(url))
  end

  def a_patch(url)
    a_request(:patch, douban_url(url))
  end

  def a_post(url)
    a_request(:post, douban_url(url))
  end

  def a_put(url)
    a_request(:put, douban_url(url))
  end

end

module DoubanHelper
  def douban_url(path)
    path.sub!(/^\//, "")
    if path =~ /^shuo/
      path.sub!(/^shuo/, "shuo/v2")
    else
      path = "v2/#{path}"
    end
    "https://api.douban.com/#{path}"
  end

  def reset_authentication_for(object)
    %w{ oauth_token }.each do |item|
      Doufuru.send("#{item}=", nil)
      object.send("#{item}=", nil)
    end
  end
end

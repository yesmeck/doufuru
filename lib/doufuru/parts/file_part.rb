# encoding: utf-8
#
# MultiParts 计算的 Content-Lenght 跟豆瓣服务器的计算结果不一至，导致请求失败，
# 所以没办法只能在这里打个 monkey patch。
module Parts
  class FilePart
    alias origin_initialize initialize
    def initialize(boundary, name, io)
      origin_initialize(boundary, name, io)
      @length -= @foot.length
    end
  end
end



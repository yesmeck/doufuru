# Doufuru
=======

Simple Ruby wrapper for the Douban v2 API

## 使用

* [图书](#doufuru-book)
* 电影
* 音乐
* 同城
* 广播
* [用户](#doufuru-user)
* 豆邮
* 日记
* 相册
* 线上活动
* 论坛
* 回复


### <a name="doufuru-book">图书</a>

#### 获取图书信息

```ruby
Doufuru.book(1084336)
```

#### 根据isbn获取图书信息

```ruby
Doufuru.book_by_isbn(9787020042494)
```

#### 搜索图书

```ruby
Doufuru.search_books(:q => "小王子", :start => 0, :count => 10)
# 或
Doufuru.search_books(:tag => "小王子", :start => 0, :count => 10)
```

#### 某个图书中标记最多的标签

```ruby
Doufuru.book_tags(1084336)
=> [#<Hashie::Mash alt="http://book.douban.com/tag/小王子" count=29139 title="小王子">, #<Hashie::Mash alt="http://book.douban.com/tag/童话" count=22404 title="童话">, #<Hashie::Mash alt="http://book.douban.com/tag/圣埃克苏佩里" count=11456 title="圣埃克苏佩里">, #<Hashie::Mash alt="http://book.douban.com/tag/法国" count=9753 title=" 法国">, #<Hashie::Mash alt="http://book.douban.com/tag/经典" count=8052 title="经典">, #<Hashie::Mash alt="http://book.douban.com/tag/外国文学" count=6731 title="外国文学">, #<Hashie::Mash alt="http://book.douban.com/tag/哲学" count=4870 title="哲学">, #<Hashie::Mash alt="http://book.douban.com/tag/小说" count=3342 title="小说">, #<Hashie::Mash alt="http://book.douban.com/tag/文学" count=2475 title="文学">, #<Hashie::Mash alt="http://book.douban.com/tag/小說" count=813 title="小說">, #<Hashie::Mash alt="http://book.douban.com/tag/法国文学" count=359 title="法国文学">, #<Hashie::Mash alt="http://book.douban.com/tag/儿童文学" count=352 title="儿童文学">, #<Hashie::Mash alt="http://book.douban.com/tag/绘本" count=282 title="绘本">, #<Hashie::Mash alt="http://book.douban.com/tag/成长" count=187 title="成长">, #<Hashie::Mash alt="http://book.douban.com/tag/名著" count=147 title="名著">, #<Hashie::Mash alt="http://book.douban.com/tag/外国" count=136 title="外国">, #<Hashie::Mash alt="http://book.douban.com/tag/爱情" count=133 title="爱情">, #<Hashie::Mash alt="http://book.douban.com/tag/外国名著" count=123 title="外国名著">, #<Hashie::Mash alt="http://book.douban.com/tag/外国小说" count=121 title="外国小说">, #<Hashie::Mash alt="http://book.douban.com/tag/爱" count=121 title="爱">]
```

#### 发表新评论

```ruby
client = Doufuru::Client.new(:access_token => ACCESS_TOKEN)
client.create_book_review({
  :book => 1084336,
  :title => "很好",
  :content => "正文必须150个字符以上",
  :rating => 5
})
```

#### 修改评论

```ruby
client = Doufuru::Client.new(:access_token => ACCESS_TOKEN)
client.update_book_review(5591773, {
  :title => "非常好",
  :content => "正文必须150个字符以上",
  :rating => 5
})

```

#### 删除评论

```ruby
client = Doufuru::Client.new(:access_token => ACCESS_TOKEN)
client.delete_book_review(5591773)
=> ok
```

#### 用户对图书的所有标签

```ruby
# 未实现
client = Doufuru::Client.new(:access_token => ACCESS_TOKEN)
client.book_user_tags(5591773)
```


### <a name="doufuru-user">用户</a>

#### 获取用户信息

```ruby
Doufuru.user("coolzi")
=> #<Hashie::Mash alt="http://www.douban.com/people/coolzi/" avatar="http://img3.douban.com/icon/u1407404-33.jpg" created="2007-01-30 18:58:26" desc="                 \n\n           野生无证程序猿\n\n           前后左右端攻城湿\n\n           初级滑板爱好者\n\n           初级摇滚乐迷\n\n\n\n" id="1407404" loc_id="118159" loc_name="江苏南京" name="彼得潘" uid="coolzi">
```

#### 获取当前授权用户信息

```ruby
client = Doufuru::Client.new(:access_token => ACCESS_TOKEN)
client.user
=> #<Hashie::Mash alt="http://www.douban.com/people/coolzi/" avatar="http://img3.douban.com/icon/u1407404-33.jpg" created="2007-01-30 18:58:26" desc="                 \n\n           野生无证程序猿\n\n           前后左右端攻城湿\n\n           初级滑板爱好者\n\n           初级摇滚乐迷\n\n\n\n" id="1407404" loc_id="118159" loc_name="江苏南京" name="彼得潘" uid="coolzi">
```

#### 搜索用户

```ruby
Doufuru.search_users(:q => 'coolzi', :start => 0, :count => 10)
=> [#<Hashie::Mash alt="http://www.douban.com/people/coolzi/" avatar="http://img3.douban.com/icon/u1407404-33.jpg" id="1407404" name="彼得潘" uid="coolzi">, #<Hashie::Mash alt="http://www.douban.com/people/63371703/" avatar="http://img3.douban.com/icon/u63371703-2.jpg" id="63371703" name="Coolzi" uid="63371703">, #<Hashie::Mash alt="http://www.douban.com/people/36451250/" avatar="http://img3.douban.com/icon/u36451250-2.jpg" id="36451250" name="Coolzi" uid="36451250">]
```


# Doufuru
=======

Simple Ruby wrapper for the Douban v2 API

## 使用

* [图书](#doufuru-book)
* [电影](#doufuru-movie)
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
### <a name="doufuru-movie">电影</a>

#### 获取电影信息

```ruby
Doufuru.movie(1307931)
```

#### 根据imdb获取电影信息

```ruby
Doufuru.movie_by_imdb("tt0316396")
```

#### 搜索电影

```ruby
Doufuru.search_movies(:q => "Peter Pan", :start => 0, :count => 10);
# 或
Doufuru.search_movies(:tag => "Peter Pan", :start => 0, :count => 10);
```

#### 某够电影中标记最对的标签

```ruby
Doufuru.movie_tags(1307931)
```

#### 发表新评论

```ruby
client = Doufuru::Client.new(:access_token => ACCESS_TOKEN)
client.create_movie_review({
  :movie => 1307931,
  :title => "很好",
  :content => "正文必须150个字符以上",
  :rating => 5
})
```

#### 修改评论

```ruby
client = Doufuru::Client.new(:access_token => ACCESS_TOKEN)
client.update_movie_review(1307931, {
  :title => "非常好",
  :content => "正文必须150个字符以上",
  :rating => 5
})
```

#### 删除评论

```ruby
client = Doufuru::Client.new(:access_token => ACCESS_TOKEN)
client.delete_movie_review(5592246)
=> ok
```

### 用户对电影的所有标签

```ruby
# 未实现
client = Doufuru::Client.new(:access_token => ACCESS_TOKEN)
client.movie_user_tags(1307931)
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


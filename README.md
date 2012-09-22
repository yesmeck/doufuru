# Doufuru [![Build Status](https://secure.travis-ci.org/yesmeck/doufuru.png)](http://travis-ci.org/yesmeck/doufuru) [![Dependency Status](https://gemnasium.com/yesmeck/doufuru.png)](https://gemnasium.com/yesmeck/doufuru)

Simple Ruby wrapper for the Douban v2 API

## 使用

* [图书](#doufuru-book)
* [电影](#doufuru-movie)
* [音乐](#doufuru-music)
* [同城](#doufuru-event)
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

#### 某够电影中标记最多的标签

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

### <a name="doufuru-music">音乐</a>

#### 获取音乐信息

```ruby
Doufuru.music(1899400)
```

#### 搜索音乐

```ruby
Doufuru.search_musics(:q => "The Black Parade", :start => 0, :count => 10);
# 或
Doufuru.search_musics(:tag => "The Black Parade", :start => 0, :count => 10);
```

#### 某够音乐中标记最多的标签

```ruby
Doufuru.musci_tags(1899400)
```

#### 发表新评论

```ruby
client = Doufuru::Client.new(:access_token => ACCESS_TOKEN)
client.create_music_review({
  :movie => 1899400,
  :title => "很好",
  :content => "正文必须150个字符以上",
  :rating => 5
})
```

#### 修改评论

```ruby
client = Doufuru::Client.new(:access_token => ACCESS_TOKEN)
client.update_music_review(5592559, {
  :title => "非常好",
  :content => "正文必须150个字符以上",
  :rating => 5
})
```

#### 删除评论

```ruby
client = Doufuru::Client.new(:access_token => ACCESS_TOKEN)
client.delete_music_review(5592559)
=> ok
```

### 用户对音乐的所有标签

```ruby
# 未实现
client = Doufuru::Client.new(:access_token => ACCESS_TOKEN)
client.music_user_tags(1899400)
```

### <a name="doufuru-event">同城</a>

#### 获取活动

```ruby
Doufuru.event(10055446)
=> #<Hashie::Mash adapt_url="http://www.douban.com/location/adapt/event/10055446/" address="杭州 旅行者酒吧" album="10297784" alt="http://www.douban.com/event/10055446/" begin_time="2008-04-20 15:00:00" can_invite="no" category="music" content="乐队：后海大鲨鱼\r\n时间：4月20日下午15:00\r\n地点：旅行者酒吧 曙光路176号\r\n票价：30 " end_time="2008-04-20 17:00:00" geo="0.0 0.0" id="10055446" image="http://img3.douban.com/pview/event_poster/median/public/cefba6f32fd1285.jpg" image_hlarge="http://img3.douban.com/pics/event/hlarge_event_dft.jpg" image_lmobile="http://img3.douban.com/pics/event/lmobile_event_dft.jpg" location="hangzhou" owner=#<Hashie::Mash alt="http://www.douban.com/people/wingoffire/" avatar="http://img3.douban.com/icon/u1173623-2.jpg" id="1173623" name="南瓜" uid="wingoffire"> participant_count=108 title="后海大鲨鱼全国巡演杭州站" wisher_count=39>
```

#### 获取参加活动的用户

```ruby
Doufuru.event_participants(10055446)
```

#### 获取活动感兴趣的用户

```ruby
Doufuru.event_wishers(10055446)
```

#### 获取用户创建的活动

```ruby
Doufuru.event_user_created("coolzi")
```

#### 获取用户参加的活动

```ruby
Doufuru.event_user_participated("coolzi")
```

#### 获取用户感兴趣的活动

```ruby
Doufuru.event_user_wished("coolzi")
```

#### 获取活动列表

```ruby
Doufuru.event_list(:loc => 118159, :day_type => "today", :type => "music")
```

#### 获取城市

```ruby
Doufuru.loc(118159)
=> #<Hashie::Mash habitable="yes" id="118159" name="南京" parent="jiangsu" uid="nanjing">
```

#### 获取城市列表

```ruby
Doufuru.loc_list
```

#### 参加活动

```ruby
client = Doufuru::Client.new(:access_token => ACCESS_TOKEN)
client.participate_event(17238776)
=> "ok"
```

#### 取消参加活动

```ruby
client = Doufuru::Client.new(:access_token => ACCESS_TOKEN)
client.delete_participated_event(17238776)
=> "ok"
```

#### 对活动感兴趣

```ruby
client = Doufuru::Client.new(:access_token => ACCESS_TOKEN)
client.wish_event(17238776)
=> "ok"
```

### 取消对活动感兴趣

```ruby
client = Doufuru::Client.new(:access_token => ACCESS_TOKEN)
client.delte_wish_event(17238776)
=> "ok"
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


# Doufuru
=======

Simple Ruby wrapper for the Douban v2 API

## 使用

* 图书
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

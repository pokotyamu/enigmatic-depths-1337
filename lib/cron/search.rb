# -*- coding: utf-8 -*-
require "#{Rails.root}/app/models/counter"
require 'twitter'
require 'json'

TW_CONSUMER_KEY1        = "KUiYihhvVYMdi7kQeQvaU3nfP"
TW_CONSUMER_SECRET1     = "AFuAlJYT5KVSTJ3D1o1LpzYa6qiWy9Df8mbkRibYikfUfbk0ed"
TW_ACCESS_TOKEN1        = "303790740-qmdQrpgqw77k1goz1BHBBptmlmgdpvrjLJDu4D2I"
TW_ACCESS_TOKEN_SECRET1 = "PgLmK7iTf5LXE7UMBjm5Eyl5JiNORTTt6CPRiNdGlWIsY"

class Cron::Search
  def self.execute
    now = Time.now


    count_data = Counter.new
    
    # ログイン
    # ログイン不要な操作もありますがこれやっとけば大抵問題ない（適当
    twClient = Twitter::REST::Client.new do |config|
      config.consumer_key        = TW_CONSUMER_KEY1
      config.consumer_secret     = TW_CONSUMER_SECRET1
      config.access_token        = TW_ACCESS_TOKEN1
      config.access_token_secret = TW_ACCESS_TOKEN_SECRET1
    end
    
    word = "眠たい" # 検索したいワード
    
    
    # word を含む tweet を 10 件取得する
    
    #urls = []
    cur_id = 0
    count = 0
    now = Time.now
    now_min = Time.now.min - 1
    if now_min < 0
      now_min = 59
      day = Time.local("#{now.year}","#{now.month}","#{now.day}","#{now.hour} - 1","#{now_min}","#{now.sec}","#{now.wday}")      
    else
      day = Time.local("#{now.year}","#{now.month}","#{now.day}","#{now.hour}","#{now_min}","#{now.sec}","#{now.wday}")
    end
    
    
    results = twClient.search(word,:count =>100,:result_type => "recent")
    results.attrs[:statuses].each do |tweet|
      tw_at = DateTime.parse(tweet[:created_at]).min
      count = count + 1 if tw_at.to_i == now_min
    end
    count_data.sleepcount = count
    count_data.twitime = day
    count_data.save

  end

end

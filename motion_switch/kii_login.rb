require 'rubygems'
require 'json'
require 'curb'

#APP_ID、APP_KEY
  app_id = "0c5a7416"
  app_key = "6f56ee86c60e2141bb9e280fb3d7ad7f"

  #入力したいデータ(-dにあたる部分)
  payload = '{"username":"sanabagun", "password":"11111111"}'

  base_url = "https://api.kii.com/api/oauth2/token"

  c = Curl::Easy.http_post(base_url, payload) do |curl|
    curl.headers['content-type']= "application/json"
    curl.headers["x-kii-appid"] = app_id
    curl.headers["x-kii-appkey"] = app_key
  end

  puts c.body
require 'rubygems'
require 'json'
require 'curb'

#APP_ID、APP_KEY
  token = "Q_0e15BTWYS41FzG8KV9Mb9xBRYgd2HD022ZezHJJCs"
  app_id = "0c5a7416"
  app_key = "6f56ee86c60e2141bb9e280fb3d7ad7f"

  #入力したいデータ(-dにあたる部分)
  payload = '{"score":5000"}'

  base_url = "https://api.kii.com//api/apps/#{app_id}/users/me/buckets/#{bucket_name}/objects/#{object_id}"

  c = Curl::Easy.http_post(base_url, payload) do |curl|
    curl.headers["X-HTTP-Method-Override"]= PATCH
    curl.headers["If-Match"]= 2
    curl.headers["Authorization"]= "Bearer "+token
    curl.headers["x-kii-appid"] = app_id
    curl.headers["x-kii-appkey"] = app_key
  end

  puts c.body
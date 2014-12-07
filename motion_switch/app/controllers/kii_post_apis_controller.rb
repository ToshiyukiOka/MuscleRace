# -*- encoding: utf-8 -*-
class KiiPostApisController < ApplicationController
require 'rubygems'
require 'json'
require 'curb'

#curl -v -X POST \
 # -H "content-type:application/vnd.kii.RegistrationRequest+json" \
  #-H "x-kii-appid:{APP_ID}" \
  #-H "x-kii-appkey:{APP_KEY}" \
  #{}"https://api-jp.kii.com/api/apps/{APP_ID}/users" \
  #-d '{"loginName":"user_123456", "displayName":"person test000", "country":"JP", "password":"123ABC"}'

def new_user
  #APP_ID、APP_KEY
  app_id = "0c5a7416"
  app_key = "6f56ee86c60e2141bb9e280fb3d7ad7f"

  #入力したいデータ(-dにあたる部分)
  payload = '{"loginName":"user_123456", 
  "displayName":"person test000",
  "country":"JP",
  "password":"123ABC"}'

  c =Curl::Easy.new
  base_url = "https://api.kii.com//api/apps/#{app_id}/users"
  headers={}
  headers['Content-Type']='application/vnd.kii.RegistrationRequest+json'
  headers["Authorization"] = "Bearer "+token
  headers["x-kii-appid"] = app_id
  headers["x-kii-appkey"] = app_key
  payload = "{\"key\":\"value\"}"

  c.url = base_url
  c.headers=headers
  c.verbose=true
  c.http_post(payload)
end
end

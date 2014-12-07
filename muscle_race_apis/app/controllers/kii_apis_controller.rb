# -*- encoding: utf-8 -*-
class KiiApisController < ApplicationController
require 'net/https'
require 'uri'
require 'rubygems'
require 'json'
require 'curb'
  
#--------------get------------------------
  #apiテスト用
  def hello
    render :text => 'Hello!'
  end
  
  #ユーザーの情報をゲット
  def user_info
  	#アクセストークン
    token = "Q_0e15BTWYS41FzG8KV9Mb9xBRYgd2HD022ZezHJJCs"
    #APP_ID、APP_KEY
    app_id = "0c5a7416"
    app_key = "6f56ee86c60e2141bb9e280fb3d7ad7f"
    login_name = "okappy"
    admin_id = "85f5d6d26b0515bcf5287d0ca687ee08"
    #アクセスするためのURLを作成
    base_url = "https://api.kii.com/api/apps/#{app_id}/users/me"
    uri = URI.parse(base_url)

    # HTTPSを使うための設定
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    https.verify_mode = OpenSSL::SSL::VERIFY_NONE
    #リクエスト送信
    res = https.start do |x|
      req = Net::HTTP::Get.new(base_url)
      req["Authorization"] = "Bearer "+token
      req["x-kii-appid"] = app_id
      req["x-kii-appkey"] = app_key
      x.request(req)
   end
    @user_info = res.body.to_json
  end
　
　#オブジェクトデータを取得
  def object_data
  	#アクセストークン
    token = "Q_0e15BTWYS41FzG8KV9Mb9xBRYgd2HD022ZezHJJCs"
    #APP_ID、APP_KEY
    app_id = "0c5a7416"
    app_key = "6f56ee86c60e2141bb9e280fb3d7ad7f"
    #BUCKET_NAME、OBJECT_ID
    bucket_name = "Group"
    object_id = params[:object_id]
    binding.pry
    #アクセスするためのURLを作成
    base_url = "https://api.kii.com/api/apps/#{app_id}/users/me/buckets/#{bucket_name}/objects/#{object_id}"
    uri = URI.parse(base_url)

    # HTTPSを使うための設定
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    https.verify_mode = OpenSSL::SSL::VERIFY_NONE
    #リクエスト送信
    res = https.start do |x|
      req = Net::HTTP::Get.new(base_url)
      req["Authorization"] = "Bearer "+token
      req["x-kii-appid"] = app_id
      req["x-kii-appkey"] = app_key
      x.request(req)
    end
    @object_data = res.body.to_json
  end
  
#--------------post----------------------------  
  #新規ユーザー作成
  def new_user
    #APP_ID、APP_KEY
    app_id = "0c5a7416"
    app_key = "6f56ee86c60e2141bb9e280fb3d7ad7f"

    #入力したいデータ(-dにあたる部分)
    payload = '{"loginName":"sanabagun", 
      "displayName":"sanabagun3785",
      "country":"US",
      "password":"11111111"}'
    base_url = "https://api.kii.com//api/apps/#{app_id}/users"
    c = Curl::Easy.http_post(base_url, payload) do |curl|
      curl.headers['Content-Type']='application/vnd.kii.RegistrationRequest+json'
      curl.headers["x-kii-appid"] = app_id
      curl.headers["x-kii-appkey"] = app_key
    end
    @new_user_info = c.body
  end
  
  #ユーザーログイン(tokenゲット)
  def login
  	#アクセストークン
    token = "Q_0e15BTWYS41FzG8KV9Mb9xBRYgd2HD022ZezHJJCs"
  	#APP_ID、APP_KEY
    app_id = "0c5a7416"
    app_key = "6f56ee86c60e2141bb9e280fb3d7ad7f"
    user_name = params[:user_name]
    password = params[:password]

    #入力したいデータ(-dにあたる部分)
    payload = '{"username":"sanabagun", "password":"11111111"}'

    base_url = "https://api.kii.com/api/oauth2/token"

    c = Curl::Easy.http_post(base_url, payload) do |curl|
      curl.headers['content-type']= "application/json"
      curl.headers["x-kii-appid"] = app_id
      curl.headers["x-kii-appkey"] = app_key
    end
    @login_info = c.body
  end

  #objectを作成
  def object
  	#token
  	token = "twneED7s6TcOmRMqAhrNKYP63xStU9yeMgm7EMWL6a"
  	#APP_ID、APP_KEY
    app_id = "0c5a7416"
    app_key = "6f56ee86c60e2141bb9e280fb3d7ad7f"
    user_name = params[:user_name]
    password = params[:password]
    bucket_name = "test2"

    #入力したいデータ(-dにあたる部分)
    payload = '{"score":"1800", "name":"game1"}'

    base_url = "https://api.kii.com/api/apps/#{app_id}/users/me/buckets/#{bucket_name}/objects"

    c = Curl::Easy.http_post(base_url, payload) do |curl|
      curl.headers["Authorization"] = "Bearer "+token
      curl.headers["If-Match"] = "1"
      curl.headers["content-type"] = "application/vnd.#{app_id}.mydata+json"
      curl.headers["x-HTTP-Method-Override"] = "PATCH"
      curl.headers["x-kii-appid"] = app_id
      curl.headers["x-kii-appkey"] = app_key
    end
    @object = c.body
  end

  #object部分更新
  def group_points
  	token = "twneED7s6TcOmRMqAhrNKYP63xStU9yeMgm7EMWL6a"
  	#APP_ID、APP_KEY
    app_id = "0c5a7416"
    app_key = "6f56ee86c60e2141bb9e280fb3d7ad7f"
    user_name = params[:user_name]
    password = params[:password]

    #入力したいデータ(-dにあたる部分)
    payload = '{"score":"3"}'

    base_url = "https://api.kii.com/api/apps/#{app_id}/users/me/buckets/#{bucket_name}/objects/#{object_id}"

    c = Curl::Easy.http_post(base_url, payload) do |curl|
      curl.headers["Authorization"] = "Bearer "+token
      curl.headers["If-Match"] = "2"
      curl.headers["x-HTTP-Method-Override"] = PATCH
      curl.headers["x-kii-appid"] = app_id
      curl.headers["x-kii-appkey"] = app_key
    end
    @group_points = c.body
  end
end

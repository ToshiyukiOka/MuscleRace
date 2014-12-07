# coding: utf-8
require 'net/https'
require 'uri'

#アクセストークン
token = "Q_0e15BTWYS41FzG8KV9Mb9xBRYgd2HD022ZezHJJCs"

#APP_ID、APP_KEY
app_id = "0c5a7416"
app_key = "6f56ee86c60e2141bb9e280fb3d7ad7f"
user_id = "c805dfa00022-035a-4e11-a785-024ac422"
#アクセスするためのURLを作成
base_url = "https://api.kii.com/api/apps/#{app_id}/groups?is_member=#{user_id}"
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

puts res.body

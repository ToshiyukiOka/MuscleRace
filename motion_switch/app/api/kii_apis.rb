class API < Grape::API
  # APIアクセスに接頭語を不可
  # ex) http://localhost:3000/api
  prefix "api"

  # APIアクセスにバージョン情報を付加
  # ex) http://localhost:3000/api/vl/
  version 'v1', :using => :path

  # 未指定の場合にJSONで返すように変更（URLで指定可能）
  format :json

   mount Books_API
end

# アプリケーションのルーティング定義
Rails.application.routes.draw do

  # トップページのルート設定（GET /）
  root "poker#index"

  # フォーム送信用のPOSTルート
  post "/" => "poker#index"

  # Grape APIのマウント（/api/v1/...）
  mount V1::PokerApi => '/api'

end

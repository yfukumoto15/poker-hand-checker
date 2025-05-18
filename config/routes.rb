Rails.application.routes.draw do
  # ポーカー役判定アプリのルート
  root "poker#index"
  post "/" => "poker#index"

  # Grape APIをマウント
  mount V1::PokerApi => '/api'
end

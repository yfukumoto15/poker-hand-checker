# Railsアプリケーションでルーティングを定義するためのメソッド
# "routes.draw do ... end" のブロック内にルート情報を記述します
Rails.application.routes.draw do

  # "root" はアプリケーションのトップページを設定するためのものです
  # 例えば、ブラウザで http://localhost:3000/ にアクセスしたときに表示されるページを指定します
  # "poker#index" は "PokerController" クラスの "index" アクション（メソッド）を呼び出すことを意味します
  # "poker" はコントローラー名、"index" はアクション名です
  root "poker#index"

  # "post" はHTTPリクエストのメソッド（POST）を指定するためのものです
  # POSTリクエストはデータをサーバーに送信するときに使われます（例：フォーム送信）
  # "/" はURLパスを指定しています（ルートURLの場合はスラッシュのみ）
  # "poker#index" で、ルートURLに対するPOSTリクエストを "PokerController" の "index" アクションで処理します
  post "/" => "poker#index"

  # GrapeというRuby用のAPIマイクロフレームワークを使っている場合のマウント設定
  # "mount" は特定のパス（ここでは '/api'）に対してAPIエンドポイントを登録します
  # "V1::PokerApi" は、バージョン1のPokerApiクラスを指定しています
  # 例えば、http://localhost:3000/api/v1/poker_api でアクセスできるようになります
  mount V1::PokerApi => '/api'

# ルーティング設定の終了
end

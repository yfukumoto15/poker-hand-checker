# このファイルは「ポーカーの役判定API」のエンドポイント（入り口）を定義しています。
# --- 用語解説 ---
# ・API（エーピーアイ）: アプリ同士がやりとりするための「窓口」や「受付」のこと。
#   例：スマホアプリやWebアプリがサーバーにデータを送ったり、受け取ったりするための仕組み。
# ・エンドポイント: APIの「入り口」となるURL（例: /api/v1/check）。
#   どこにアクセスすれば何ができるかを示す「住所」のようなもの。
# ・Grape: RubyでAPIを簡単に作るためのライブラリ。
#   ルーティングやバリデーション、レスポンスの整形などを手軽に実装できる。
# ・モジュール: 関連する機能をまとめる箱。ここではV1という名前空間でAPIのバージョン管理をしている。
# ・クラス: 機能やデータをまとめた設計図。PokerApiはAPIの動きをまとめている。
# ・format :json: APIの返すデータ形式をJSON（よく使われるデータ交換フォーマット）に指定。
#   例：{"result": "ロイヤルストレートフラッシュ"} のような形で返す。
# ・resource: APIの機能ごとに「入り口」を作る。ここでは/check。
#   例：/api/v1/check というURLでアクセスできるようになる。
# ・params: APIに送るデータ（パラメータ）の定義。
#   例：cards という名前で手札の配列を送る。
# ・requires: 必須パラメータの指定。ここではcardsが必須。
# ・post: POSTリクエスト（データを送る操作）を受け付ける。
#   例：curlやJavaScriptからデータを送るときに使う。
# ・PokerHandChecker: 手札の役を判定するクラス。
#   役判定のロジックやバリデーション（入力チェック）を担当。

# --- ここから実際のAPI定義 ---
module V1
  # PokerApiクラスはGrape::APIを継承（APIの機能を引き継ぐ）
  class PokerApi < Grape::API
    format :json  # レスポンス（返すデータ）の形式をJSONに指定

    # resource :check で「/api/v1/check」というAPIの入り口を作る
    resource :check do  # 例: http://localhost:3000/api/v1/check
      desc 'Check poker hand'  # APIの説明（ドキュメント用）

      # paramsブロックで「cards」というパラメータ（入力データ）を必須にする
      params do
        # requires :cards ... で「cardsは必ず必要、型は文字列の配列」と指定
        # 例: ["S10", "SJ", "SQ", "SK", "SA"]
        requires :cards, type: Array[String], desc: 'Card list'
      end

      # post do ... で「POSTリクエスト（データを送る）」を受け付ける
      post do
        # 送られてきたcards（手札の配列）を使ってPokerHandChecker（役判定クラス）を作成
        # 例: params[:cards] = ["S10", "SJ", "SQ", "SK", "SA"]
        checker = PokerHandChecker.new(params[:cards])
        # 役判定を実行し、結果をresultに格納
        # resultは { result: "役名" } または { errors: [エラーメッセージ] } の形
        result = checker.check_hand
        # エラーがあればエラー内容を返し、なければ判定結果を返す
        if result[:errors]
          # エラーがある場合は { errors: [エラーメッセージ] } の形で返す
          # 例: { errors: ["カードが5枚ではありません"] }
          { errors: result[:errors] }
        else
          # 正常な場合は { result: "役名" } の形で返す
          # 例: { result: "ロイヤルストレートフラッシュ" }
          { result: result[:result] }
        end
      end
    end
  end
end

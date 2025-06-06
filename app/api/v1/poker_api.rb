# =============================
# ポーカー役判定API（バージョン1）
# GrapeというGemを使ってAPIを定義しています
# =============================

# APIのバージョン管理用の名前空間V1
module V1
  # Grape::APIを継承してAPIクラスを作成
  class PokerApi < Grape::API
    format :json  # レスポンス（返り値）はJSON形式

    # /api/v1/check というエンドポイント（URL）を定義
    resource :check do
      desc 'Check poker hand'  # APIの説明（ドキュメント用）

      # 必須パラメータcards（カードの配列）を定義
      params do
        requires :cards, type: Array[String], desc: 'Card list' # cardsは必須、配列で受け取る
      end

      # POSTリクエスト（データを送る）時の処理
      post do
        # PokerHandCheckerクラスで役判定を実施
        checker = PokerHandChecker.new(params[:cards])
        result = checker.check_hand
        # エラーがあればエラー内容を返す
        if result[:errors]
          { errors: result[:errors] }
        else
          # 役の判定結果を返す
          { result: result[:result] }
        end
      end
    end
  end
end

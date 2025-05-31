# 名前空間V1を定義（バージョン管理などに利用）
module V1
  # Grapeを使ったAPI定義
  class PokerApi < Grape::API
    format :json  # レスポンス形式をJSONに指定

    resource :check do  # /api/v1/check に相当
      desc 'Check poker hand'

      # 必須パラメータcards（文字列の配列）を定義
      params do
        requires :cards, type: Array[String], desc: 'Card list'
      end

      post do
        checker = PokerHandChecker.new(params[:cards])
        result = checker.check_hand
        if result[:errors]
          { errors: result[:errors] }
        else
          { result: result[:result] }
        end
      end
    end
  end
end

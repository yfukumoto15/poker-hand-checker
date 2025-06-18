# 名前空間V1を定義（バージョン管理などに利用）
module V1
  # Grapeを使ったAPI定義
  class PokerApi < Grape::API
    format :json  # レスポンス形式をJSONに指定

    resource :check do  # /api/v1/check に相当
      desc 'Check poker hand'

      # 必須パラメータcards（スペース区切り5枚カードの文字列配列）を定義
      params do
        requires :cards, type: Array[String], desc: 'Card list (each element: 5 cards separated by space)'
      end

      post do
        hands = params[:cards]
        if hands.nil? || hands.empty?
          status 200
          return { errors: [{ card: nil, errors: ["入力がありません。手札5枚を入力してください"] }] }
        end
        results = []
        errors = []
        # 各手札ごとに判定
        hands.each do |hand_str|
          card_arr = hand_str.strip.split(' ')
          checker = PokerHandChecker.new(card_arr)
          res = checker.check_hand
          if res[:errors]
            errors << { card: hand_str, errors: res[:errors] }
          else
            results << { card: hand_str, hand: res[:result], best: false }
          end
        end
        # best判定（役の強さで一番強いものにbest: true、同じ役なら全てbest: true）
        if errors.empty? && results.any?
          hand_rank = [
            'ロイヤルストレートフラッシュ', 'ストレートフラッシュ', 'フォーカード', 'フルハウス',
            'フラッシュ', 'ストレート', 'スリーカード', 'ツーペア', 'ワンペア', 'ハイカード'
          ]
          min_rank = results.map { |r| hand_rank.index(r[:hand]) }.min
          results.each_with_index do |r, i|
            results[i][:best] = (hand_rank.index(r[:hand]) == min_rank)
          end
        end
        status 200
        if errors.any?
          { errors: errors }
        else
          { result: results }
        end
      end
    end
  end
end

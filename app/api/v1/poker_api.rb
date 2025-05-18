module V1
    class PokerApi < Grape::API
      format :json
  
      resource :check do
        desc 'Check poker hand'
        params do
          requires :cards, type: Array[String], desc: 'Card list'
        end
        post do
          # 受け取ったカード情報を表示
          puts "Received cards: #{params[:cards].inspect}"
  
          # 役判定の実行
          checker = PokerHandChecker.new(params[:cards])
          { result: checker.check_hand }
        end
      end
    end
  end
  
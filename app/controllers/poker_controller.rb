class PokerController < ApplicationController
    protect_from_forgery with: :null_session
  
    def index
      if params[:cards].present?
        # 入力を分割し、空白を除去
        @cards = params[:cards].split(',').map(&:strip)
  
        # バリデーションチェック
        if valid_cards?(@cards)
          # 正常な場合、役判定
          checker = PokerHandChecker.new(@cards)
          @result = checker.check_hand
        else
          # エラーメッセージを表示
          @result = "入力が不正です。カードは5枚、形式は 'AS, KS, QS, JS, 10S' のように入力してください。"
        end
      else
        # デフォルトの手札（ロイヤルストレートフラッシュ）
        @cards = ['AS', 'KS', 'QS', 'JS', '10S']
        checker = PokerHandChecker.new(@cards)
        @result = checker.check_hand
      end
    end
  
    private
  
    # 手札が正しいかチェックするメソッド
    def valid_cards?(cards)
      return false unless cards.size == 5
      pattern = /\A(10|[2-9AKQJ])[SHDC]\z/
      cards.all? { |card| card.match?(pattern) }
    end
  end
  
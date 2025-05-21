class PokerController < ApplicationController
  # CSRF対策を無効化（API用途など）
  protect_from_forgery with: :null_session

  # "/" にアクセスがあったときに実行される
  def index
    if params[:cards].present?
      # カード入力を整形
      @cards = params[:cards].split(',').map(&:strip)

      if valid_cards?(@cards)
        # 役判定
        checker = PokerHandChecker.new(@cards)
        @result = checker.check_hand
      else
        # エラーメッセージ
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

  # 入力チェック（5枚かつ正しい形式か）
  def valid_cards?(cards)
    return false unless cards.size == 5
    pattern = /\A(10|[2-9AKQJ])[SHDC]\z/
    cards.all? { |card| card.match?(pattern) }
  end
end

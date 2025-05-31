class PokerController < ApplicationController
  # CSRF対策を無効化（API用途など）
  protect_from_forgery with: :null_session

  # "/" にアクセスがあったときに実行される
  def index
    if params[:cards].present?
      # スペース区切りでカードを分割
      @cards = params[:cards].split(' ').map(&:strip)
      checker = PokerHandChecker.new(@cards)
      @result = checker.check_hand
    else
      @cards = []
      @result = nil
    end
  end
end

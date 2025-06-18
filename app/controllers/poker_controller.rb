class PokerController < ApplicationController
  # CSRF対策を無効化（API用途など）
  protect_from_forgery with: :null_session

  # "/" にアクセスがあったときに実行される
  def index
    input = params[:cards].to_s
    @cards = input.split(' ').map(&:strip)
    checker = PokerHandChecker.new(@cards)
    @result = checker.check_hand
  end
end

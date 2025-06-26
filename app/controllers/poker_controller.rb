class PokerController < ApplicationController
  # CSRF対策を無効化（API用途など）
  protect_from_forgery with: :null_session

  # GET "/" - フォーム表示
  def index
    @cards = []
    @result = nil
  end

  # POST "/" - 判定処理
  def create
    input = params[:cards].to_s
    @cards = input.split(' ').map(&:strip)
    checker = PokerHandChecker.new(@cards)
    @result = checker.check_hand
    render :index
  end
end

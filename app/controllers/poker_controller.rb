# =============================
# ポーカー役判定Web画面用コントローラー
# ユーザーがフォームで手札を入力したときの処理を担当
# =============================

class PokerController < ApplicationController
  # CSRF対策を無効化（API用途やフォーム送信のため）
  protect_from_forgery with: :null_session

  # "/"（トップページ）にアクセスがあったときの処理
  def index
    if params[:cards].present?
      # 入力されたカードをスペースで分割し、前後の空白を除去
      @cards = params[:cards].split(' ').map(&:strip)
      # PokerHandCheckerで役判定
      checker = PokerHandChecker.new(@cards)
      @result = checker.check_hand
    else
      # 入力がなければ空配列・結果なし
      @cards = []
      @result = nil
    end
  end
end

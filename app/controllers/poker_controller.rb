# ポーカーの役判定Webアプリのコントローラー
# --- 用語解説 ---
# ・コントローラー: ユーザーのリクエスト（画面操作やAPIアクセス）を受け取り、処理を振り分ける役割。
#   例：画面のボタンが押されたときや、URLにアクセスがあったときに呼ばれる。
# ・ApplicationController: すべてのコントローラーの親クラス。共通の機能をまとめている。
# ・protect_from_forgery: CSRF（クロスサイトリクエストフォージェリ）という攻撃を防ぐ仕組み。
#   ここではAPI用途のため「with: :null_session」で無効化している。
# ・params: ユーザーがフォームやURLで送ってきたデータが入るハッシュ（連想配列）。
#   例：params[:cards] でフォームの入力値を取得できる。
# ・@cards, @result: ビュー（画面）で使うためのインスタンス変数。
#   例：@cardsは入力されたカードの配列、@resultは判定結果やエラー内容。
# ・PokerHandChecker: 手札の役を判定するサービスクラス。
#   役判定のロジックやバリデーションを担当。

class PokerController < ApplicationController
  # CSRF対策を無効化（API用途や外部連携のため）
  # 通常はフォーム送信時のセキュリティ対策だが、APIや外部連携では不要な場合が多い
  protect_from_forgery with: :null_session

  # indexアクション: "/"（トップページ）にアクセスがあったときに実行される
  # 画面を表示したり、フォーム送信を受け取る役割
  def index
    # フォームから「cards」パラメータが送られてきた場合の処理
    # 例：画面の入力欄に「S10 S11 S12 S13 SA」と入力して送信された場合
    if params[:cards].present?
      # 入力された文字列を半角スペースで分割し、前後の空白も除去
      # 例: "S10 S11 S12 S13 SA" → ["S10", "S11", "S12", "S13", "SA"]
      @cards = params[:cards].split(' ').map(&:strip)
      # PokerHandCheckerクラスを使って役判定を実行
      # ここでバリデーション（入力チェック）や役の判定が行われる
      checker = PokerHandChecker.new(@cards)
      @result = checker.check_hand  # 判定結果（役名やエラー）を@resultに格納
    else
      # 入力がなかった場合は空配列とnilをセット
      # 画面初期表示や未入力時のための処理
      @cards = []
      @result = nil
    end
  end
end

# PokerControllerクラスは、Pokerゲームに関するリクエストを処理するコントローラーです。
# コントローラーは、Webアプリケーションの中でリクエストを受け取り、適切なレスポンスを返す役割を持ちます。
# このクラスはApplicationControllerを継承しており、Railsアプリケーションの基本機能を利用できます。
class PokerController < ApplicationController

    # CSRF（クロスサイトリクエストフォージェリ）対策を無効化する設定
    # CSRFとは？：外部サイトから悪意あるリクエストを送られる攻撃手法のこと。
    # protect_from_forgery: CSRF対策としてRailsが自動で付与するトークンをチェックします。
    # with: :null_session オプションは、API用途などでCSRFトークンを無効化し、セッションをクリアします。
    protect_from_forgery with: :null_session
  
    # indexアクション（メソッド）は、ブラウザからアクセスがあった際に呼ばれる処理です。
    # Railsでは「/」などのURLにアクセスがあったときに、このアクションが実行されます。
    def index
      # リクエストパラメータ（params[:cards]）が存在しているかチェックします。
      # paramsとは？：ユーザーが送信したデータを格納するオブジェクトです。
      # .present?は、値が存在する（空ではない）かどうかを判定するメソッドです。
      if params[:cards].present?
  
        # ユーザーから受け取ったカード情報をカンマで区切り、配列として格納します。
        # split(',')：カンマ区切りで文字列を分割し、配列に変換
        # map(&:strip)：各要素の前後に含まれる空白を削除
        @cards = params[:cards].split(',').map(&:strip)
  
        # valid_cards?メソッドを使ってカードの形式が正しいかをチェックします。
        if valid_cards?(@cards)
          # 正しいカードの場合、役判定処理を行います。
          # PokerHandCheckerクラスを使って役をチェックし、その結果を@resultに格納します。
          checker = PokerHandChecker.new(@cards)
          @result = checker.check_hand
        else
          # 入力されたカードが不正な場合、エラーメッセージを設定します。
          @result = "入力が不正です。カードは5枚、形式は 'AS, KS, QS, JS, 10S' のように入力してください。"
        end
      else
        # パラメータがない場合、デフォルトのカード（ロイヤルストレートフラッシュ）を設定します。
        # AS, KS, QS, JS, 10Sは、ポーカーの中で最強の役「ロイヤルストレートフラッシュ」です。
        @cards = ['AS', 'KS', 'QS', 'JS', '10S']
        
        # デフォルトのカードを使って役判定を実施します。
        checker = PokerHandChecker.new(@cards)
        @result = checker.check_hand
      end
    end
  
    # private以下のメソッドはクラス内部でしか使えないため、
    # 他のコントローラーや外部からは直接呼び出せません。
    private
  
    # valid_cards?メソッドは、受け取ったカードが正しい形式かどうかをチェックします。
    # 役割：カードが5枚であり、形式が「数値+スート（マーク）」の形かを判定
    def valid_cards?(cards)
      # カードが5枚でない場合、falseを返します。
      return false unless cards.size == 5
  
      # 正規表現パターンを定義します。
      # \A：文字列の先頭
      # (10|[2-9AKQJ])：10、2〜9、A、K、Q、Jのいずれか
      # [SHDC]：スペード(S)、ハート(H)、ダイヤ(D)、クラブ(C)のいずれか
      # \z：文字列の末尾
      pattern = /\A(10|[2-9AKQJ])[SHDC]\z/
  
      # すべてのカードが正しい形式に一致するかチェックします。
      # all?：すべての要素がtrueを返す場合にtrueを返す
      # match?：正規表現と一致するかを確認
      cards.all? { |card| card.match?(pattern) }
    end
  end
  
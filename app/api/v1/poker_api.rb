# モジュールとは、関連するメソッドやクラスをまとめるための仕組みです。
# モジュールを使うことで、名前空間（他のクラスやモジュールとの名前の衝突を避ける空間）を分けることができます。
# V1 という名前のモジュールを定義しています。
module V1
    # PokerApiクラスを定義しています。Grape::API を継承しています。
    # Grape は Ruby の API 専用フレームワークで、APIを簡単に作成できるライブラリです。
    # API とは、他のアプリケーションやサービスがデータをやり取りするための仕組みのことです。
    class PokerApi < Grape::API
      # APIのレスポンス（返されるデータ）の形式を JSON に指定しています。
      # JSON（JavaScript Object Notation）はデータをシンプルに表現するためのフォーマットです。
      format :json
  
      # 'resource' はエンドポイントをグループ化するためのブロックです。
      # 'check' というリソースを定義しています。URLとしては /api/v1/check となります。
      resource :check do
        # APIの説明を追加しています。APIドキュメントに表示される内容です。
        desc 'Check poker hand'
  
        # リクエストのパラメータを定義するブロックです。
        params do
          # 'cards' というパラメータが必須であることを示しています。
          # 配列形式（Array）の中に文字列（String）を含むデータ型である必要があります。
          # desc は、パラメータの説明として表示される内容です。
          requires :cards, type: Array[String], desc: 'Card list'
        end
  
        # POSTリクエスト（データを送信するリクエスト）を受け取ったときに実行されるブロックです。
        post do
          # 受け取ったカード情報をコンソールに表示します。
          # 'params' はリクエストで送信されたデータを含むハッシュ（連想配列）です。
          # 'puts' はコンソールにデータを表示するメソッドです。
          # 'inspect' メソッドは、オブジェクトの内容を見やすい形式に変換します。
          puts "Received cards: #{params[:cards].inspect}"
  
          # PokerHandChecker クラスのインスタンスを作成しています。
          # 引数として、受け取ったカードの配列を渡しています。
          checker = PokerHandChecker.new(params[:cards])
  
          # 'check_hand' メソッドを呼び出して、役の判定結果を取得します。
          # 取得した結果をハッシュ形式で返しています。
          # { result: "役の名前" } のような形式でレスポンスとして返されます。
          { result: checker.check_hand }
        end
      end
    end
  end
  
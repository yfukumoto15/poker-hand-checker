require 'rails_helper'

RSpec.describe "PokerController", type: :request do
  describe "GET /" do
    it "トップページが表示される" do
      get "/"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("ポーカー役判定")
    end
  end

  describe "POST /" do
    it "正しい手札を送信すると判定結果が表示される" do
      post "/", params: { cards: "S10 SJ SQ SK SA" }
      expect(response.body).to include("ロイヤルストレートフラッシュ")
    end

    it "不正な手札を送信するとエラーメッセージが表示される" do
      post "/", params: { cards: "S10 S10 SQ SK SA" }
      expect(response.body).to include("エラー")
      expect(response.body).to include("重複しているカードがあります")
    end

    it "入力なしの場合は何も表示されない" do
      post "/", params: { cards: "" }
      expect(response.body).not_to include("判定結果:")
      expect(response.body).not_to include("エラー:")
    end
  end
end 
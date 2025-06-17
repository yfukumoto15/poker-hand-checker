require 'rails_helper'

RSpec.describe "V1::PokerApi", type: :request do
  describe "POST /api/v1/check" do
    let(:headers) { { "CONTENT_TYPE" => "application/json" } }

    it "正しい手札を送信すると役が返る" do
      post "/api/v1/check", params: { cards: ["S10", "SJ", "SQ", "SK", "SA"] }.to_json, headers: headers
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["result"]).to eq("ロイヤルストレートフラッシュ")
    end

    it "不正な手札を送信するとエラーが返る" do
      post "/api/v1/check", params: { cards: ["S10", "S10", "SQ", "SK", "SA"] }.to_json, headers: headers
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["errors"]).to be_present
      expect(json["errors"].join).to include("重複しているカードがあります")
    end

    it "cardsが空の場合はエラーが返る" do
      post "/api/v1/check", params: { cards: [] }.to_json, headers: headers
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["errors"]).to be_present
      expect(json["errors"].join).to include("入力がありません。手札5枚を入力してください")
    end
  end
end 
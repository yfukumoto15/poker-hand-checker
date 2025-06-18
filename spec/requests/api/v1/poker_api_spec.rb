require 'rails_helper'

RSpec.describe "V1::PokerApi", type: :request do
  describe "POST /api/v1/check" do
    let(:headers) { { "CONTENT_TYPE" => "application/json" } }

    it "複数手札を送信すると役とbestが返る" do
      post "/api/v1/check", params: { cards: ["S10 SJ SQ SK SA", "H9 H10 HJ HQ HK"] }.to_json, headers: headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["result"]).to be_an(Array)
      expect(json["result"][0]["hand"]).to eq("ロイヤルストレートフラッシュ")
      expect(json["result"][0]["best"]).to eq(true)
      expect(json["result"][1]["hand"]).to eq("ストレートフラッシュ")
      expect(json["result"][1]["best"]).to eq(false)
    end

    it "不正な手札が含まれるとエラーが返る" do
      post "/api/v1/check", params: { cards: ["S10 S10 SQ SK SA", "H9 H10 HJ HQ HK"] }.to_json, headers: headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["errors"]).to be_an(Array)
      expect(json["errors"][0]["card"]).to eq("S10 S10 SQ SK SA")
      expect(json["errors"][0]["errors"].join).to include("重複しているカードがあります")
    end

    it "cardsが空の場合はエラーが返る" do
      post "/api/v1/check", params: { cards: [] }.to_json, headers: headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["errors"]).to be_an(Array)
    end
  end
end 
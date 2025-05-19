# RSpecのテストコードを実行するために必要な設定を読み込む
require 'rails_helper'

# PokerHandCheckerクラスのテストを定義するブロック
RSpec.describe PokerHandChecker do
  
  # PokerHandCheckerクラスのインスタンスメソッド #check_hand をテスト
  describe '#check_hand' do

    # ロイヤルストレートフラッシュの場合のテストケース
    context 'when the hand is a Royal Straight Flush' do
      # 正しい役名が返ってくるかを確認する
      it 'returns ロイヤルストレートフラッシュ' do
        # ロイヤルストレートフラッシュのカード配列
        cards = ['10S', 'JS', 'QS', 'KS', 'AS']
        # PokerHandCheckerクラスを初期化（カードを渡す）
        checker = PokerHandChecker.new(cards)
        # check_handメソッドの戻り値が「ロイヤルストレートフラッシュ」であることを期待
        expect(checker.check_hand).to eq("ロイヤルストレートフラッシュ")
      end
    end

    # ストレートフラッシュの場合のテストケース
    context 'when the hand is a Straight Flush' do
      it 'returns ストレートフラッシュ' do
        cards = ['9H', '10H', 'JH', 'QH', 'KH']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand).to eq("ストレートフラッシュ")
      end
    end

    # フォーカードの場合のテストケース
    context 'when the hand is Four of a Kind' do
      it 'returns フォーカード' do
        cards = ['10D', '10S', '10H', '10C', '3D']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand).to eq("フォーカード")
      end
    end

    # フルハウスの場合のテストケース
    context 'when the hand is Full House' do
      it 'returns フルハウス' do
        cards = ['5D', '5S', '5H', '3C', '3D']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand).to eq("フルハウス")
      end
    end

    # フラッシュの場合のテストケース
    context 'when the hand is a Flush' do
      it 'returns フラッシュ' do
        cards = ['2S', '6S', '9S', 'QS', 'KS']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand).to eq("フラッシュ")
      end
    end

    # ストレートの場合のテストケース
    context 'when the hand is a Straight' do
      it 'returns ストレート' do
        cards = ['4D', '5S', '6H', '7C', '8D']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand).to eq("ストレート")
      end
    end

    # スリーカードの場合のテストケース
    context 'when the hand is Three of a Kind' do
      it 'returns スリーカード' do
        cards = ['7D', '7S', '7H', '2C', '4D']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand).to eq("スリーカード")
      end
    end

    # ツーペアの場合のテストケース
    context 'when the hand is Two Pair' do
      it 'returns ツーペア' do
        cards = ['8D', '8S', '4H', '4C', '5D']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand).to eq("ツーペア")
      end
    end

    # ワンペアの場合のテストケース
    context 'when the hand is One Pair' do
      it 'returns ワンペア' do
        cards = ['3D', '3S', '7H', '9C', 'KD']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand).to eq("ワンペア")
      end
    end

    # ハイカードの場合のテストケース
    context 'when the hand is High Card' do
      it 'returns ハイカード' do
        cards = ['2D', '5S', '8H', '9C', 'KD']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand).to eq("ハイカード")
      end
    end
  end
end

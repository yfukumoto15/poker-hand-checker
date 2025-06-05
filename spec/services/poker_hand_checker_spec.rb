# テスト用設定を読み込む
require 'rails_helper'

# PokerHandChecker のテスト
RSpec.describe PokerHandChecker do
  describe '#check_hand' do

    context 'ロイヤルストレートフラッシュ' do
      it '正しく判定される' do
        cards = ['S10', 'SJ', 'SQ', 'SK', 'SA']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand[:result]).to eq('ロイヤルストレートフラッシュ')
      end
    end

    context 'ストレートフラッシュ' do
      it '正しく判定される' do
        cards = ['H9', 'H10', 'HJ', 'HQ', 'HK']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand[:result]).to eq('ストレートフラッシュ')
      end
    end

    context 'フォーカード' do
      it '正しく判定される' do
        cards = ['D10', 'S10', 'H10', 'C10', 'D3']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand[:result]).to eq('フォーカード')
      end
    end

    context 'フルハウス' do
      it '正しく判定される' do
        cards = ['SQ', 'DQ', 'HQ', 'C4', 'H4']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand[:result]).to eq('フルハウス')
      end
    end

    context 'フラッシュ' do
      it '正しく判定される' do
        cards = ['C2', 'C5', 'C6', 'CQ', 'CK']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand[:result]).to eq('フラッシュ')
      end
    end

    context 'ストレート' do
      it '正しく判定される' do
        cards = ['D4', 'S5', 'H6', 'C7', 'D8']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand[:result]).to eq('ストレート')
      end
    end

    context 'スリーカード' do
      it '正しく判定される' do
        cards = ['CQ', 'DQ', 'HQ', 'S3', 'C4']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand[:result]).to eq('スリーカード')
      end
    end

    context 'ツーペア' do
      it '正しく判定される' do
        cards = ['SK', 'DK', 'C4', 'S4', 'H3']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand[:result]).to eq('ツーペア')
      end
    end

    context 'ワンペア' do
      it '正しく判定される' do
        cards = ['D3', 'S3', 'H7', 'C9', 'DK']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand[:result]).to eq('ワンペア')
      end
    end

    context 'ハイカード' do
      it '正しく判定される' do
        cards = ['S4', 'H5', 'D8', 'H10', 'C2']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand[:result]).to eq('ハイカード')
      end
    end

    context '不正な入力（5枚未満）' do
      it 'エラーが返る' do
        cards = ['S10', 'SJ', 'SQ', 'SK']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand[:errors]).to include('カードが5枚ではありません')
      end
    end

    context '不正なカード（存在しないスート/数字）' do
      it 'エラーが返る' do
        cards = ['P1', 'H3', 'H4', 'D9', 'C13']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand[:errors].join).to include('不正なカードがあります: P1')
      end
    end

    context '重複カード' do
      it 'エラーが返る' do
        cards = ['S10', 'S10', 'SQ', 'SK', 'SA']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand[:errors].join).to include('重複しているカードがあります: S10')
      end
    end

    context '入力なし' do
      it 'エラーが返る' do
        cards = []
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand[:errors]).to include('入力がありません。手札5枚を入力してください')
      end
    end

    describe '追加バリデーション・判定テスト' do
      it 'カンマ区切りはエラーになる' do
        cards = ['S10', 'SJ', 'SQ', 'SK,', 'SA']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand[:errors].join).to include('カードの区切りは半角スペースのみ対応しています')
      end

      it '全角スペース区切りはエラーになる' do
        cards = ['S10', 'SJ', 'SQ', 'SK　', 'SA']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand[:errors].join).to include('カードの区切りは半角スペースのみ対応しています')
      end

      it '前後に余計な空白があるとエラーになる' do
        cards = [' S10', 'SJ', 'SQ', 'SK', 'SA ']
        checker = PokerHandChecker.new(cards)
        # 変換後も余計な空白が残る場合はバリデーションエラーになる
        expect(checker.check_hand[:errors] || []).to include('カードの区切りは半角スペースのみ対応しています')
      end

      it '数字＋スート形式はエラーになる' do
        cards = ['10S', 'JH', 'QS', 'KD', 'AC']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand[:errors].join).to include('不正なカードがあります')
      end

      it '不正なカードが複数ある場合すべて表示される' do
        cards = ['P1', 'P3', 'H4', 'D9', 'C13']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand[:errors].join).to include('不正なカードがあります: P1, P3')
      end

      it 'A2345はストレートと判定される' do
        cards = ['S5', 'H4', 'D3', 'C2', 'SA']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand[:result]).to eq('ストレート')
      end

      it '11,12,13,1,10の表記も許容される' do
        cards = ['S11', 'S12', 'S13', 'S1', 'S10']
        checker = PokerHandChecker.new(cards)
        # すべて変換されて正しいカードになるので、エラーは出ない
        expect(checker.check_hand[:result]).to eq('ロイヤルストレートフラッシュ')
      end
    end

    context '数字表記でもロイヤルストレートフラッシュ' do
      it '1H,13H,12H,11H,10H でロイヤルストレートフラッシュと判定される' do
        cards = ['H1', 'H13', 'H12', 'H11', 'H10']
        checker = PokerHandChecker.new(cards)
        expect(checker.check_hand[:result]).to eq('ロイヤルストレートフラッシュ')
      end
    end
  end
end

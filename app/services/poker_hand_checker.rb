# ポーカーの手札を判定するクラス
class PokerHandChecker
    # 初期化メソッド（インスタンス生成時に自動的に呼ばれる）
    # cards という引数を受け取り、それをインスタンス変数 @cards に格納する
    def initialize(cards)
      @cards = cards  # @cards というインスタンス変数にカード配列を保存
    end

    # 手札の役（ハンド）を判定して、その名称を返すメソッド
    def check_hand
      # 各役を上から順にチェックし、最初に該当する役を返す
      # 役の強さが上から順に並んでいるため、この順序が大切
      if royal_straight_flush?   # ロイヤルストレートフラッシュ判定
        "ロイヤルストレートフラッシュ"
      elsif straight_flush?      # ストレートフラッシュ判定
        "ストレートフラッシュ"
      elsif four_of_a_kind?      # フォーカード判定（同じ数字が4枚）
        "フォーカード"
      elsif full_house?          # フルハウス判定（3枚と2枚の組み合わせ）
        "フルハウス"
      elsif flush?               # フラッシュ判定（同じスートが5枚）
        "フラッシュ"
      elsif straight?            # ストレート判定（連続した数字が5枚）
        "ストレート"
      elsif three_of_a_kind?     # スリーカード判定（同じ数字が3枚）
        "スリーカード"
      elsif two_pair?            # ツーペア判定（2枚+2枚の組み合わせ）
        "ツーペア"
      elsif one_pair?            # ワンペア判定（同じ数字が2枚）
        "ワンペア"
      else
        # どの役にも該当しない場合（最も弱い手）
        "ハイカード"
      end
    end

    # private メソッド以下は、このクラス内部でのみ使用するメソッド
    private

    # ロイヤルストレートフラッシュの判定メソッド
    def royal_straight_flush?
      # フラッシュかつ、A, K, Q, J, 10 の組み合わせであるかを判定
      flush? && @cards.map { |card| convert_to_number(card.chop) }.sort == [10, 11, 12, 13, 14]
    end

    # ストレートフラッシュの判定メソッド
    def straight_flush?
      # フラッシュかつ、ストレートであればストレートフラッシュ
      flush? && straight?
    end

    # フォーカードの判定メソッド
    def four_of_a_kind?
      # 同じランクのカードが4枚あるかチェック
      card_counts.values.include?(4)
    end

    # フルハウスの判定メソッド
    def full_house?
      # カードの出現数が「3枚と2枚」の組み合わせであるかをチェック
      card_counts.values.sort == [2, 3]
    end

    # フラッシュの判定メソッド
    def flush?
      # 各カードのスート（マーク）を抽出し、すべて同じであるかをチェック
      suits = @cards.map { |card| card[-1] }  # 末尾の文字がスートを示す
      suits.uniq.size == 1  # すべて同じなら1種類しかない
    end

    # ストレートの判定メソッド
    def straight?
      # 各カードのランクを数値に変換し、昇順に並べて連続しているかをチェック
      numbers = @cards.map { |card| convert_to_number(card.chop) }.sort
      numbers == (numbers.first..numbers.first + 4).to_a
    end

    # スリーカードの判定メソッド
    def three_of_a_kind?
      # 同じランクのカードが3枚あるかチェック
      card_counts.values.include?(3)
    end

    # ツーペアの判定メソッド
    def two_pair?
      # 同じランクが2枚のペアが2つあるかをチェック
      card_counts.values.count(2) == 2
    end

    # ワンペアの判定メソッド
    def one_pair?
      # 同じランクが2枚のペアが1つだけあるかをチェック
      card_counts.values.count(2) == 1
    end

    # カードのランクごとに出現回数をカウントするメソッド
    def card_counts
      counts = Hash.new(0)  # 出現回数を記録するハッシュを初期化
      @cards.each { |card| counts[card.chop] += 1 }  # chopでスート部分を削除してランクのみカウント
      counts  # カードの出現回数が格納されたハッシュを返す
    end

    # カードのランクを数値に変換するメソッド
    def convert_to_number(num)
      # ポーカーで使われるランクを数値に変換
      case num
      when "A" then 14  # A（エース）は最も強いので14
      when "K" then 13  # K（キング）は13
      when "Q" then 12  # Q（クイーン）は12
      when "J" then 11  # J（ジャック）は11
      when "10" then 10 # 10はそのまま10
      else num.to_i  # 他の数字（2〜9）は整数に変換
      end
    end
end

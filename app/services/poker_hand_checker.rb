# =============================
# ポーカーの役を判定するサービスクラス
# 入力バリデーションや役判定ロジックを担当
# =============================

class PokerHandChecker
  # スート（マーク）の一覧
  SUITS = %w[S H D C].freeze
  # 数字や絵札の一覧
  RANKS = %w[A K Q J 10 9 8 7 6 5 4 3 2].freeze
  # 絵札やAを数字に変換するためのハッシュ
  RANK_TO_NUM = {"A"=>14, "K"=>13, "Q"=>12, "J"=>11, "10"=>10, "9"=>9, "8"=>8, "7"=>7, "6"=>6, "5"=>5, "4"=>4, "3"=>3, "2"=>2}

  attr_reader :errors  # エラー内容を外部から参照できる

  def initialize(cards)
    @raw_cards = cards # 入力されたカード（空白含む）
    @errors = []
    # バリデーション（入力チェック）を実施
    validate_cards
    # 問題なければカード表記を変換
    @cards = @raw_cards.map { |c| convert_number_card(c.strip) } if @errors.empty?
  end

  # 数字表記を英字表記に変換（例: 1H→AH, 13H→KH）
  def convert_number_card(card)
    card = card.strip
    # スート＋数字表記（1,11,12,13もOK）を判定
    if card =~ /^(S|H|D|C)(1[0-3]|[1-9])$/
      suit = card[0]
      num = card[1..-1]
      case num
      when '1' then "#{suit}A"
      when '11' then "#{suit}J"
      when '12' then "#{suit}Q"
      when '13' then "#{suit}K"
      else
        "#{suit}#{num}"
      end
    else
      card
    end
  end

  # エラーがなければtrue
  def valid?
    @errors.empty?
  end

  # 役判定のメイン処理
  def check_hand
    return { errors: @errors } unless valid?
    # 役ごとに判定
    if royal_straight_flush?
      { result: "ロイヤルストレートフラッシュ" }
    elsif straight_flush?
      { result: "ストレートフラッシュ" }
    elsif four_of_a_kind?
      { result: "フォーカード" }
    elsif full_house?
      { result: "フルハウス" }
    elsif flush?
      { result: "フラッシュ" }
    elsif straight?
      { result: "ストレート" }
    elsif three_of_a_kind?
      { result: "スリーカード" }
    elsif two_pair?
      { result: "ツーペア" }
    elsif one_pair?
      { result: "ワンペア" }
    else
      { result: "ハイカード" }
    end
  end

  private

  # 入力バリデーション
  def validate_cards
    # 入力が空や全て空白ならエラー
    if @raw_cards.nil? || @raw_cards.empty? || @raw_cards.all? { |c| c.strip.empty? }
      @errors << "入力がありません。手札5枚を入力してください"
      return
    end
    # 5枚でなければエラー
    if @raw_cards.size != 5
      @errors << "カードが5枚ではありません"
    end
    # カンマや全角スペース、前後の空白があればエラー
    if @raw_cards.any? { |c| c.match?(/,|　/) || c != c.strip }
      @errors << "カードの区切りは半角スペースのみ対応しています"
    end
    # スート＋数字表記のみ許容（1,11,12,13もOK）
    invalid_format = @raw_cards.select { |c| c.strip !~ /\A[S|H|D|C](A|K|Q|J|10|[2-9]|1[0-3]|[1-9])\z/ }
    unless invalid_format.empty?
      @errors << "不正なカードがあります: #{invalid_format.map(&:strip).join(', ')}"
    end
    # 重複カード（変換後でチェック）
    if @errors.empty?
      converted = @raw_cards.map { |c| convert_number_card(c.strip) }
      dups = converted.group_by(&:itself).select { |_, v| v.size > 1 }.keys
      unless dups.empty?
        @errors << "重複しているカードがあります: #{dups.join(', ')}"
      end
    end
  end

  # 以下、役判定のための補助メソッド
  # カードのスート（マーク）を取得
  def suit(card)
    card[0]
  end

  # カードのランク（数字や絵札）を取得
  def rank(card)
    card[1..-1]
  end

  # カードの数字部分を数値化して配列で返す
  def numbers
    nums = @cards.map { |card| RANK_TO_NUM[rank(card)] }.sort
    # A2345のストレートも考慮
    if nums == [2,3,4,5,14]
      [1,2,3,4,5]
    else
      nums
    end
  end

  # カードのスート一覧を配列で返す
  def suits
    @cards.map { |card| suit(card) }
  end

  # 役ごとの判定メソッド
  def royal_straight_flush?
    flush? && numbers == [10,11,12,13,14]
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    rank_counts.values.include?(4)
  end

  def full_house?
    vals = rank_counts.values.sort
    vals == [2,3]
  end

  def flush?
    suits.uniq.size == 1
  end

  def straight?
    ns = numbers
    ns.uniq.size == 5 && ns.max - ns.min == 4
  end

  def three_of_a_kind?
    rank_counts.values.count(3) == 1 && rank_counts.values.count(2) == 0
  end

  def two_pair?
    rank_counts.values.count(2) == 2
  end

  def one_pair?
    rank_counts.values.count(2) == 1
  end

  # 各ランク（数字や絵札）の出現回数をハッシュで返す
  def rank_counts
    counts = Hash.new(0)
    @cards.each { |card| counts[rank(card)] += 1 }
    counts
  end
end

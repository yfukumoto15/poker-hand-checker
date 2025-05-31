# ポーカー役を判定するクラス
class PokerHandChecker
  SUITS = %w[S H D C].freeze
  RANKS = %w[A K Q J 10 9 8 7 6 5 4 3 2].freeze
  RANK_TO_NUM = {"A"=>14, "K"=>13, "Q"=>12, "J"=>11, "10"=>10, "9"=>9, "8"=>8, "7"=>7, "6"=>6, "5"=>5, "4"=>4, "3"=>3, "2"=>2}

  attr_reader :errors

  def initialize(cards)
    @cards = cards
    @errors = []
    validate_cards
  end

  def valid?
    @errors.empty?
  end

  def check_hand
    return { errors: @errors } unless valid?
    # 役判定
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

  def validate_cards
    if @cards.nil? || @cards.empty? || @cards.all? { |c| c.strip.empty? }
      @errors << "入力がありません。手札5枚を入力してください"
      return
    end
    if @cards.size != 5
      @errors << "カードが5枚ではありません"
    end
    # スペース区切り以外や余計な空白の検出
    if @cards.any? { |c| c.match?(/,|　/) || c.strip != c }
      @errors << "カードの区切りは半角スペースのみ対応しています"
    end
    # スート＋数字順のみ許容（A,K,Q,J,10,9,...,2 のみ）
    invalid_format = @cards.select { |c| c !~ /\A[S|H|D|C](A|K|Q|J|10|[2-9])\z/ }
    unless invalid_format.empty?
      @errors << "不正なカードがあります: #{invalid_format.join(', ')}"
    end
    # 重複カード
    dups = @cards.group_by(&:itself).select { |_, v| v.size > 1 }.keys
    unless dups.empty?
      @errors << "重複しているカードがあります: #{dups.join(', ')}"
    end
  end

  def suit(card)
    card[0]
  end

  def rank(card)
    card[1..-1]
  end

  def numbers
    nums = @cards.map { |card| RANK_TO_NUM[rank(card)] }.sort
    # ストレート判定用: A2345も考慮
    if nums == [2,3,4,5,14]
      [1,2,3,4,5]
    else
      nums
    end
  end

  def suits
    @cards.map { |card| suit(card) }
  end

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

  def rank_counts
    counts = Hash.new(0)
    @cards.each { |card| counts[rank(card)] += 1 }
    counts
  end
end

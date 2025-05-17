class PokerHandChecker
    def initialize(cards)
      @cards = cards
    end
  
    def check_hand
      if royal_straight_flush?
        "ロイヤルストレートフラッシュ"
      elsif straight_flush?
        "ストレートフラッシュ"
      elsif four_of_a_kind?
        "フォーカード"
      elsif full_house?
        "フルハウス"
      elsif flush?
        "フラッシュ"
      elsif straight?
        "ストレート"
      elsif three_of_a_kind?
        "スリーカード"
      elsif two_pair?
        "ツーペア"
      elsif one_pair?
        "ワンペア"
      else
        "ハイカード"
      end
    end
  
    private
  
    def royal_straight_flush?
      flush? && @cards.map { |card| convert_to_number(card.chop) }.sort == [10, 11, 12, 13, 14]
    end
  
    def straight_flush?
      flush? && straight?
    end
  
    def four_of_a_kind?
      card_counts.values.include?(4)
    end
  
    def full_house?
      card_counts.values.sort == [2, 3]
    end
  
    def flush?
      suits = @cards.map { |card| card[-1] }
      suits.uniq.size == 1
    end
  
    def straight?
      numbers = @cards.map { |card| convert_to_number(card.chop) }.sort
      numbers == (numbers.first..numbers.first + 4).to_a
    end
  
    def three_of_a_kind?
      card_counts.values.include?(3)
    end
  
    def two_pair?
      card_counts.values.count(2) == 2
    end
  
    def one_pair?
      card_counts.values.count(2) == 1
    end
  
    def card_counts
      counts = Hash.new(0)
      @cards.each { |card| counts[card.chop] += 1 }
      counts
    end
  
    def convert_to_number(num)
      case num
      when "A" then 14
      when "K" then 13
      when "Q" then 12
      when "J" then 11
      when "10" then 10
      else num.to_i
      end
    end
  end
  
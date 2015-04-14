class Blackjack
  attr_accessor :player1, :dealer, :deck
  
  def initialize()
    puts "Welcome to blackjack"
    display_cards
    @player = []
    @dealer = []
    @deck = display_cards
    pass_cards
  end

  def display_cards
    full_deck = []
    cards_array = (1..10).to_a
    4.times do 
      cards_array.each do |number|
        if number == 10
          4.times do 
            full_deck << number
          end
        else
          full_deck << number
        end
      end
    end
    full_deck.shuffle
  end

  def pass_cards
    2.times do
      @player << @deck.shift
      @dealer << @deck.shift
    end
    hit_or_stay
  end

  def win_or_loss
    player_total = @player.inject(:+)
    dealer_total = @dealer.inject(:+)

    if player_total > 21
      puts "player loses"
    elsif dealer_total > 21
      puts "dealer loses"
    elsif player_total > dealer_total
      puts "player wins"
    elsif player_total == dealer_total
      puts "tie game"
    else
      puts "dealer wins"
    end
  end

  def hit_or_stay
    player_total = @player.inject(:+)
    dealer_total = @dealer.inject(:+)
    while player_total < 16
      @player << @deck.shift
    end
    if player_total > 16 && player_total <= 21
      @dealer << deck.shift until (dealer_total > 16)
    end
    win_or_loss
  end
end
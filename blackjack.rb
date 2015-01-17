# blackjack.rb

# Tealeaf Course 1 -- Lesson 1 Assignment
# 07/01/2015

# 1. ask player's name
# 2. annouce "game start"
# 3. "♠︎","♥︎","♣︎","♦︎"
# 4. print the board
# 5. let player choose: 1. hit  2. stay
# 6. 

require 'pry'
# printout a message to console
def say(message)
  puts "#{message}"
end

# the data validation method
def data_validation(options = ['Y', 'N'], choose)
  choose = choose.upcase
  options.include?(choose)
end

# return if user wanna continue
def continue_next(choose)
  choose = choose.upcase
  choose == 'Y'
end

def init_deck
  suits = ['♠︎','♥︎','♣︎','♦︎']
  rank = ['A','2','3','4','5','6','7','8','9','10','J','Q','K']
  deck = []
  suits.each do |suit_value|
    rank.each do |rank_value|
     deck.push({suit: suit_value, rank: rank_value})
    end
  end
  return deck
end

def has_result(points, who)
  if points > 21
    say "Sorry, #{who} scores #{points}, busted."
    return true
  elsif points == 21
    say "Aha, blackjack, #{who} win!!"
    return true
  end  
  return false  
end

# draw a card from the playing deck
def draw_card_from(decks)
  decks.sample
end

def count_score(deck)
  result = 0
  has_A = false
  count_A = 0

  deck.each do |card|
    case card[:rank]
    when '2'
      result += 2
    when '3'
      result += 3
    when '4'
      result += 4
    when '5'
      result += 5
    when '6'
      result += 6
    when '7'
      result += 7
    when '8'
      result += 8
    when '9'
      result += 9
    when '10'
      result += 10
    when 'J'
      result += 10
    when 'Q'
      result += 10
    when 'K'
      result += 10
    when 'A'
      has_A = true
      count_A = count_A + 1
    end
  end

  if has_A
    begin
      case 
      when result <= 10
        result = result + 11
      when result >10
        result = result + 1  
      end
      count_A -= 1
    end while count_A == 0

  end

  result
end

def draw_board(player_name,dealer_deck,player_deck)
  system 'clear'
  say "#{player_name}, Welcome to Blackjack Game."
  say "==============="
  say "Dealer's cards:"
  puts dealer_deck.count
  say "==============="
  say "Player's cards:"
  player_deck.each do |card|
    print card[:suit]
    print card[:rank]
    print "  "
  end
  puts
  say "==============="
  
end

# main process
system 'clear'
say "Please input your name:"
player_name = gets.chomp

begin
  decks = init_deck
  player_deck = []
  dealer_deck = []
  player_score = 0
  dealer_score = 0

  player_deck.push(draw_card_from(decks))
  player_deck.push(draw_card_from(decks))

  dealer_deck.push(draw_card_from(decks))
  dealer_deck.push(draw_card_from(decks)) 

  draw_board(player_name,dealer_deck,player_deck)

  has_result = false
  # Player's turn
  begin
    say "Please choose: 1) hit  2) stay"
    decision = gets.chomp.to_i
    if decision == 1
      player_deck.push(draw_card_from(decks))
      
      draw_board(player_name,dealer_deck,player_deck)

      player_score = count_score(player_deck)
    end
    has_result = has_result(player_score,"you")
  end while !has_result and decision == 1

  # Dealer's turn
  if decision == 2
    begin
      dealer_deck.push(draw_card_from(decks))
      
      draw_board(player_name,dealer_deck,player_deck)

      dealer_score = count_score(dealer_deck)
    end while dealer_score < 17
    has_result = has_result(dealer_score,"dealer")
  end

  if !has_result
    player_score = count_score(player_deck)
    dealer_score = count_score(dealer_deck)
    if player_score >= dealer_score
      say "Player scores #{player_score}, dealer scores #{dealer_score}, You win!"
    else
      say "Dealer scores #{dealer_score}, player scores #{player_score}, Dealer wins!"     
    end    
  end

  # validate input
  begin 
    say "Play again? (Y/N)"
    continue = gets.chomp
  end while !data_validation(choose = continue)

end while continue_next(continue)
say "Bye bye!"
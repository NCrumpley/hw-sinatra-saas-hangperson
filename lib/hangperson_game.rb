class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  
  def guess(my_guess)
    if my_guess == '' or /[a-zA-Z]/.match(my_guess) == nil or my_guess == nil
      raise HangpersonGame::ArgumentError, "Wrong format for guess"
    end
    my_guess.downcase!
    if @word.include?(my_guess) and @guesses.include?(my_guess) == false
      @guesses << my_guess
    elsif @word.include?(my_guess) == false and @wrong_guesses.include?(my_guess) == false
      @wrong_guesses << my_guess
    else
      return false
    end
  end

  
  def word_with_guesses()
    showWord = ""
    @word.each_char do |letter|
      if @guesses.include?(letter)
        showWord << letter
      else
        showWord << '-'
      end
    end
    return showWord
  end
  
  def check_win_or_lose()
   status = nil
    if @wrong_guesses.length >= 7
      status= :lose
    elsif word_with_guesses == @word
      status = :win
    else
      status = :play
    end
    return status
  end
end

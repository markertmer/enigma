require './helper.rb'

class Crack < Crypt
  attr_reader :ciphertext, :clue, :last_four

  def initialize(ciphertext, date = nil)
    @ciphertext = ciphertext.downcase
    super(nil, date)
    align_last_four
  end

  def align_last_four
    @last_four = @ciphertext[-4..-1].split("")
    length = @ciphertext.length
    @last_four.rotate!(4 - length % 4)
    @clue= " end".split("").rotate!(4 - length %4)
  end

  def find_shifts
    @shifts = {}
    @key_letters = [:A, :B, :C, :D]
    @last_four.each_with_index do |char, index|
      shift = @characters.index(char) - @characters.index(@clue[index])
      shift += 27 if shift < 0
      @shifts[@key_letters[index]] = shift
    end
  end
end

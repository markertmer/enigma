require './helper.rb'

class Crack < Crypt
  attr_reader :ciphertext, :clue, :last_four

  def initialize(ciphertext, date = nil)
    @ciphertext = ciphertext.downcase
    align_last_four
    super(nil, date)
  end

  def align_last_four
    @last_four = @ciphertext[-4..-1].split("")
    length = @ciphertext.length
    @last_four.rotate!(4 - length % 4)
    @clue= " end".split("").rotate!(4 - length %4)
  end
end

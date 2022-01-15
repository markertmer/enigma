require './helper.rb'

class Crack < Crypt
  attr_reader :ciphertext, :clue, :last_four, :shift_key_candidates

  def initialize(ciphertext, date = nil)
    @ciphertext = ciphertext.downcase
    super(nil, date)
    #align_last_four
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

  def find_candidates
    # find_shifts
    # generate_offsets
    factors = (0..3).to_a
    @shift_key_candidates = {A: [], B: [], C: [], D: []}

    @shift_key_candidates.each do |key, canditates|
      factors.each do |number|
        candidate = (@shifts[key] + 27*number - @offsets[key]).to_s.rjust(2, "0")
        @shift_key_candidates[key] << candidate unless candidate.length > 2
      end
    end
    # until @shift_keys[:A].to_s[1] = @shift_keys[:B].to_s[0] && @shift_keys[:B].to_s[1] = @shift_keys[:C].to_s[0] && @shift_keys[:C].to_s[1] = @shift_keys[:D].to_s[0] do
    # end
  end
end

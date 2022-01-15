require './helper.rb'

class Crack < Crypt
  attr_reader :ciphertext, :clue, :last_four, :shift_key_candidates

  def initialize(ciphertext, date = nil)
    @ciphertext = ciphertext.downcase
    super(nil, date)
    #align_last_four
  end

  def output
    {
      decryption: decrypt,
      key: @key,
      date: @date
    }
  end

  def decrypt
    align_last_four
    find_shifts
    generate_offsets
    find_shift_key_candidates
    find_shift_keys
    find_key
    transform_text("decrypt")
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

  def find_shift_key_candidates
    @shift_key_candidates = {A: [], B: [], C: [], D: []}
    factors = (0..3).to_a

    @shift_key_candidates.each do |key, canditates|
      factors.each do |number|
        candidate = (@shifts[key] + 27*number - @offsets[key]).to_s.rjust(2, "0")
        @shift_key_candidates[key] << candidate unless candidate.length > 2
      end
    end
  end

  def find_shift_keys
    @shift_key_candidates[:A].each do |a_candidate|
      break if @shift_keys != nil
      b_possibles = @shift_key_candidates[:B].select do |b_candidate|
        b_candidate[0] == a_candidate[1]
      end
      next if b_possibles == []
      b_possibles.each do |b_possible|
        break if @shift_keys != nil
        c_possibles = @shift_key_candidates[:C].select do |c_candidate|
          c_candidate[0] == b_possible[1]
        end
        next if c_possibles == []
        c_possibles.each do |c_possible|
          break if @shift_keys != nil
          d_winner = @shift_key_candidates[:D].find do |d_candidate|
            d_candidate[0] == c_possible[1]
          end
          next if d_winner == nil
          @shift_keys = {A: a_candidate, B: b_possible, C: c_possible, D: d_winner}
        end
      end
    end
  end

  def find_key
    @key = @shift_keys[:A][0] + @shift_keys[:B] + @shift_keys[:D]
  end

end

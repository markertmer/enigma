class Crack < Crypt

  def initialize(ciphertext, date = nil)
    @ciphertext = ciphertext.downcase
    super(nil, date)
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
    @input_array = @ciphertext.split("")
    @output_array = []
    @shifts.transform_values! { |shift| shift * -1 }
    transform_text
    @output_array.join
  end

  def align_last_four
    @last_four = @ciphertext[-4..-1].split("")
    special_chars = @ciphertext.split("").count { |char| !@characters.include?(char) }
    length = @ciphertext.length - special_chars
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
    factors = (0..4).to_a

    @shift_key_candidates.each do |key, canditates|
      factors.each do |number|
        candidate = (@shifts[key] + 27*number - @offsets[key]).to_s.rjust(2, "0")
        @shift_key_candidates[key] << candidate unless candidate.length > 2
      end
    end
  end

  def find_shift_keys
    keys = ["420", "69", "13", "666"]
    until keys[0][1] == keys[1][0] && keys[1][1] == keys[2][0] && keys[2][1] == keys[3][0]
      keys = []
      keys << @shift_key_candidates[:A].sample
      keys << @shift_key_candidates[:B].sample
      keys << @shift_key_candidates[:C].sample
      keys << @shift_key_candidates[:D].sample
    end
    @shift_keys = {A: keys[0], B: keys[1], C: keys[2], D: keys[3]}
  end

  def find_key
    @key = @shift_keys[:A][0] + @shift_keys[:B] + @shift_keys[:D]
  end
end

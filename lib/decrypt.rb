class Decrypt < Crypt
  attr_reader :ciphertext

  def initialize(ciphertext, key = nil, date = nil)
    @ciphertext = ciphertext.downcase
    super(key, date)
  end

  def output
    {
      encryption: decrypt_message,
      key: @key,
      date: @date
    }
  end

  def decrypt_message
    cipher_array = @ciphertext.split("")
    decrypted_array = []
    correction = 0
    @shifts.transform_values! { |shift| shift * -1 }
    cipher_array.each_with_index do |char, index|
      if !@characters.include?(char)
        decrypted_array << char
        correction += 1
      elsif (index - correction) % 4 == 0
        index_of_char = @characters.index(char)
        decrypted_array << @characters.rotate(@shifts[:A])[index_of_char]
      elsif (index - correction) % 4 == 1
        index_of_char = @characters.index(char)
        decrypted_array << @characters.rotate(@shifts[:B])[index_of_char]
      elsif (index - correction) % 4 == 2
        index_of_char = @characters.index(char)
        decrypted_array << @characters.rotate(@shifts[:C])[index_of_char]
      elsif (index - correction) % 4 == 3
        index_of_char = @characters.index(char)
        decrypted_array << @characters.rotate(@shifts[:D])[index_of_char]
      end
    end
    decrypted_array.join
  end
end

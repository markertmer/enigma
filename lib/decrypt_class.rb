class Decrypt < Crypt
  attr_reader :ciphertext, :input_array

  def initialize(ciphertext, key = nil, date = nil)
    @ciphertext = ciphertext.downcase
    super(key, date)
  end

  def output
    {
      decryption: decrypt_ciphertext,
      key: @key,
      date: @date
    }
  end

  def decrypt_ciphertext
    @input_array = @ciphertext.split("")
    @output_array = []
    @shifts.transform_values! { |shift| shift * -1 }
    transform_text
    @output_array.join
  end
end

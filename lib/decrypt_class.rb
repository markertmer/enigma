class Decrypt < Crypt
  attr_reader :ciphertext

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
    transform_text("decrypt")
  end
end

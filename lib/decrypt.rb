class Decrypt < Crypt
  attr_reader :name, :characters, :ciphertext

  def initialize(ciphertext, key, date)
    @ciphertext = ciphertext
    super(key, date)
  end

  def decrypt
  end

end

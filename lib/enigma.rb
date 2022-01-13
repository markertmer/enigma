class Enigma
  attr_reader :name

  def initialize
  end

  def encrypt(message, key, date)
    Encrypt.new(message, key, date).encrypt
  end

  def decrypt(ciphertext, key, date)
    Decrypt.new(ciphertext, key, date).decrypt
  end
end

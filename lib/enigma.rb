class Enigma
  attr_reader :name

  def initialize
  end

  def encrypt(message, key = nil, date = nil)
    Encrypt.new(message, key, date).output
  end

  def decrypt(ciphertext, key = nil, date = nil)
    Decrypt.new(ciphertext, key, date).output
  end

  def crack(ciphertext, date = nil)
    Crack.new(ciphertext, date).output
  end
end

require './helper.rb'

class Crack < Crypt
  attr_reader :ciphertext

  def initialize(ciphertext, date = nil)
    @ciphertext = ciphertext.downcase
    super(nil, date)
  end
end

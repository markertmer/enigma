class Encrypt < Crypt
  attr_reader :name, :characters, :message

  def initialize(message, key, date = nil)
    @message = message
    super(key, date)
  end

  def encrypt
  end

end

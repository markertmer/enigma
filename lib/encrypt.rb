class Encrypt < Crypt
  attr_reader :name, :characters, :message

  def initialize(message, key, date)
    @message = message
    super(key, date)
  end

  def encrypt
  end

end

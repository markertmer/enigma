class Encrypt < Crypt
  attr_reader :message

  def initialize(message, key = nil, date = nil)
    @message = message.downcase
    super(key, date)
  end

  def output
    {
      encryption: encrypt_message,
      key: @key,
      date: @date
    }
  end

  def encrypt_message
    @input_array = @message.split("")
    transform_text#("encrypt")
  end

end

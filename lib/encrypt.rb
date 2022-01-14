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
    transform_text("encrypt")
    # message_array = @message.split("")
    # encrypted_array = []
    # correction = 0
    # message_array.each_with_index do |char, index|
    #   if !@characters.include?(char)
    #     encrypted_array << char
    #     correction += 1
    #   elsif (index - correction) % 4 == 0
    #     index_of_char = @characters.index(char)
    #     encrypted_array << @characters.rotate(@shifts[:A])[index_of_char]
    #   elsif (index - correction) % 4 == 1
    #     index_of_char = @characters.index(char)
    #     encrypted_array << @characters.rotate(@shifts[:B])[index_of_char]
    #   elsif (index - correction) % 4 == 2
    #     index_of_char = @characters.index(char)
    #     encrypted_array << @characters.rotate(@shifts[:C])[index_of_char]
    #   elsif (index - correction) % 4 == 3
    #     index_of_char = @characters.index(char)
    #     encrypted_array << @characters.rotate(@shifts[:D])[index_of_char]
    #   end
    # end
    # encrypted_array.join
  end

end

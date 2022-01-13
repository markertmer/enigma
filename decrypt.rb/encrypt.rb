class Crypt
  attr_reader :name, :characters

  def initialize(name = "noname")
    @name = name
    @characters = chars
  end

  def chars
    @characters = ("a".."z").to_a << " "
  end
end

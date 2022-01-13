class Crypt
  attr_reader :name, :characters, :key, :date

  def initialize(key, date)
    @key = key
    date == nil ? : @date = todays_date : @date = date
    generate_chars
  end

  def generate_chars
    @characters = ("a".."z").to_a << " "
  end
end

class Crypt
  attr_reader :name, :characters, :key, :date

  def initialize(key, date)
    key == nil ? @key = random_key : @key = key
    date == nil ? @date = todays_date : @date = date
    generate_chars
  end

  def generate_chars
    @characters = ("a".."z").to_a << " "
  end

  def todays_date
    date_string = Date::today.strftime.delete("-")
    date_string[-2..-1] + date_string[-4..-3] + date_string[-6..-5]
  end

  def random_key
    numbers = 
  end
end

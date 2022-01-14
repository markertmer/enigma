class Crypt
  attr_reader :name, :characters, :key, :date

  def initialize(key, date)
    # key == nil ? @key = random_key : @key = key
    # date == nil ? @date = todays_date : @date = date
    assign_date(date)
    assign_key(key)
    generate_characters
  end

  def generate_characters
    @characters = ("a".."z").to_a << " "
  end

  def assign_date(date)
    date == nil ? @date = todays_date : @date = date
  end

  def assign_key(key)
    key == nil ? @key = random_key : @key = key
  end

  def todays_date
    date_string = Date::today.strftime.delete("-")
    date_string[-2..-1] + date_string[-4..-3] + date_string[-6..-5]
  end

  def random_key
    numbers = [0,1,2,3,4,5,6,7,8,9]
    key = ""
    5.times do
      key += numbers.sample.to_s
    end
    key
  end
end

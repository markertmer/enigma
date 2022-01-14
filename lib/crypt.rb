class Crypt
  attr_reader :name, :characters, :key, :date

  def initialize(key, date)
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
    numbers = (0..9).to_a
    key = ""
    5.times do
      key += numbers.sample.to_s
    end
    key
  end

  def shift_keys
    {A: @key[0..1].to_i, B: @key[1..2].to_i, C: @key[2..3].to_i, D: @key[3..4].to_i}
  end

  def offsets
    last_4 = (@date.to_i**2).to_s[-4..-1]
    {A: last_4[0].to_i, B: last_4[1].to_i, C: last_4[2].to_i, D: last_4[3].to_i}
  end

  def shifts
    {
      A: shift_keys[:A] + offsets[:A],
      B: shift_keys[:B] + offsets[:B],
      C: shift_keys[:C] + offsets[:C],
      D: shift_keys[:D] + offsets[:D]
    }
  end
end

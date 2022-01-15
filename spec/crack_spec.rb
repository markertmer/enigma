require './helper.rb'

describe Crack do
  before(:each) do
    @crack = Crack.new("vjqtbeaweqihssi", "291018")
  end

  it '1. exists' do
    expect(@crack).to be_instance_of Crack
  end

  it '2. has a collection of characters' do
    expect(@crack.characters).to eq ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"," "]
  end

  it '3. accepts ciphertext and date' do
    expect(@crack.ciphertext).to eq "vjqtbeaweqihssi"
    expect(@crack.date).to eq "291018"
  end

  it '4. uses todays date by default' do
    crack = Crack.new("vjqtbeaweqihssi")

    date_string = Date::today.strftime.delete("-")
    expected = date_string[-2..-1] + date_string[-4..-3] + date_string[-6..-5]

    expect(crack.date).to eq expected
    # expect(crack.date).to eq "140122"
  end

  it '5. does not perform unneccessary functions' do
    expect(@crack.key).to be nil
    expect(@crack.shift_keys).to be nil
    expect(@crack.offsets).to be nil
    expect(@crack.shifts).to be nil
  end

  it '6. aligns last four digits to A-B-C-D order' do
    @crack.align_last_four
    expect(@crack.clue.join("")).to eq "end "
    expect(@crack.last_four.join("")).to eq "ssih"
  end

  it '7. finds the shifts' do
    @crack.align_last_four
    @crack.find_shifts
    expected = {
      A: 14,
      B: 5,
      C: 5,
      D: 8
    }
    expect(@crack.shifts).to eq expected
  end

  it '8. finds the key' do

  end

end

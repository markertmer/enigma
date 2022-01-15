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
    expect(crack.date).to eq "140122"
  end

end

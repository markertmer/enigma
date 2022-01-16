require './spec/spec_helper.rb'

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
    expect(@crack.last_four.join("")).to eq "ssih"
    expect(@crack.clue.join("")).to eq "end "
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

  it '8. finds shift key candidates' do
    @crack.align_last_four
    @crack.find_shifts
    @crack.generate_offsets
    @crack.find_shift_key_candidates
    expected = {
      A: [ "08", "35", "62", "89" ],
      B: [ "02", "29", "56", "83" ],
      C: [ "03", "30", "57", "84" ],
      D: [ "04", "31", "58", "85" ]
    }
    expect(@crack.shift_key_candidates).to eq expected
  end

  it '9. finds the shift keys' do
    @crack.align_last_four
    @crack.find_shifts
    @crack.generate_offsets
    @crack.find_shift_key_candidates
    @crack.find_shift_keys

    expected = {A: "08", B: "83", C: "30", D: "04"}

    expect(@crack.shift_keys).to eq expected
  end

  it '10. finds the key' do
    @crack.align_last_four
    @crack.find_shifts
    @crack.generate_offsets
    @crack.find_shift_key_candidates
    @crack.find_shift_keys
    @crack.find_key

    expect(@crack.key).to eq "08304"
  end

  it '11. decrypts the ciphertext' do
    expect(@crack.decrypt).to eq "hello world end"
  end

  it '12. outputs a hash' do
    expected = {
      decryption: "hello world end",
      key: "08304",
      date: "291018"
    }
    expect(@crack.output).to eq expected
  end

  it '13. cracks messages with special characters' do
    encrypt = Encrypt.new("hello, there, world; how are you doing?? end", "02715").output

    date_string = Date::today.strftime.delete("-")
    date = date_string[-2..-1] + date_string[-4..-3] + date_string[-6..-5]

    expected = {
      decryption: "hello, there, world; how are you doing?? end",
      key: "02715",
      date: date
    }
    expect(Crack.new(encrypt[:encryption]).output).to eq expected
  end
end

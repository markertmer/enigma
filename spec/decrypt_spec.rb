require './helper.rb'

describe Decrypt do
  before(:each) do
    @decrypt = Decrypt.new("keder ohulw", "02715", "040895")
  end

  it '1. exists' do
    expect(@decrypt).to be_instance_of Decrypt
  end

  it '2. has a collection of characters' do
    expect(@decrypt.characters).to eq ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"," "]
  end

  it '3. accepts ciphertext, key and date' do
    expect(@decrypt.ciphertext).to eq "keder ohulw"
    expect(@decrypt.key).to eq "02715"
    expect(@decrypt.date).to eq "040895"
  end

  it '4. uses todays date by default' do
    decrypt = Decrypt.new("keder ohulw", "02715")

    date_string = Date::today.strftime.delete("-")
    expected = date_string[-2..-1] + date_string[-4..-3] + date_string[-6..-5]

    expect(decrypt.date).to eq expected
    # expect(encrypt.date).to eq "130122"
  end

  it '5. generates a random key by default' do
    decrypt = Decrypt.new("keder ohulw")
    expect(decrypt.key.class).to be String
    expect(decrypt.key.length).to be 5
  end

  it '6. creates A, B, C and D shift keys' do
    expected = {A: 2, B: 27, C: 71, D: 15}
    expect(@decrypt.shift_keys).to eq expected
  end

  it '6. creates A, B, C and D offsets' do
    expected = {A: 1, B: 0, C: 2, D: 5}
    expect(@decrypt.offsets).to eq expected
  end

  it '7. creates A, B, C and D shifts' do
    expected = {A: 3, B: 27, C: 73, D: 20}
    expect(@decrypt.shifts).to eq expected
  end

  it '8. decrypts the message' do
    expect(@decrypt.decrypt_ciphertext).to eq "hello world"
  end

  it '9. ignores capitalization & special characters' do
    decrypt = Decrypt.new("Keder, ohulw!", "02715", "040895")
    expect(decrypt.decrypt_ciphertext).to eq "hello, world!"
    decrypt = Decrypt.new("K$e$d$e$r, o$h$u$l$w!", "02715", "040895")
    expect(decrypt.decrypt_ciphertext).to eq "h$e$l$l$o, w$o$r$l$d!"
  end

  it '9. outputs a hash' do
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }
    expect(@decrypt.output).to eq expected
  end
end

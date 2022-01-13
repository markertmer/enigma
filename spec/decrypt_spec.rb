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
end

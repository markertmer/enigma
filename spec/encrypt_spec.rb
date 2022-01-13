require './helper.rb'

describe Encrypt do
  before(:each) do
    @encrypt = Encrypt.new("hello world", "02715", "040895")
  end

  it '1. exists' do
    expect(@encrypt).to be_instance_of Encrypt
  end

  it '2. has a collection of characters' do
    expect(@encrypt.characters).to eq ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"," "]
  end

  it '3. accepts a message, key and date' do
    expect(@encrypt.message).to eq "hello world"
    expect(@encrypt.key).to eq "02715"
    expect(@encrypt.date).to eq "040895"
  end
end

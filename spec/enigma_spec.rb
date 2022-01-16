require './spec/spec_helper.rb'

describe Enigma do
  before(:each) do
    @enigma = Enigma.new
  end

  it '1. exists' do
    expect(@enigma).to be_instance_of Enigma
  end

  it '2. encrypts a message with a key and date' do
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    expect(@enigma.encrypt("hello world", "02715", "040895")).to eq expected
  end

  it '3. decrypts a message with a key and date' do
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }
    expect(@enigma.decrypt("keder ohulw", "02715", "040895")).to eq expected
  end

  it '4. encrypts and decrypts using todays date' do
    encrypted = @enigma.encrypt("hello world", "02715")
    expect(@enigma.decrypt(encrypted[:encryption], "02715")[:decryption]).to eq "hello world"
  end

  it '5. encrypts and decrypts using a random key' do
    encrypted = @enigma.encrypt("hello world")
    expect(@enigma.decrypt(encrypted[:encryption], encrypted[:key])[:decryption]).to eq "hello world"
  end

  it '6. cracks a message ending in _end using just the date' do
    encrypted = @enigma.encrypt("hello, world! end")
    expected = @enigma.decrypt(encrypted[:encryption], encrypted[:key], encrypted[:date])[:decryption]
    expect(@enigma.crack(encrypted[:encryption], encrypted[:date])[:decryption]).to eq expected
    expect(@enigma.crack(encrypted[:encryption], encrypted[:date])[:key]).to eq encrypted[:key]
  end
end

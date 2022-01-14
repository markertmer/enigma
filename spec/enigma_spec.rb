require './helper.rb'

describe Enigma do
  #describe 'Primitive Functions' do
    before(:each) do
      @enigma = Enigma.new
    end

    it '1. exists' do
      expect(@enigma).to be_instance_of Enigma
    end

    it '2. encrypts & gives outputs' do
      expected = {
        encryption: "keder ohulw",
        key: "02715",
        date: "040895"
      }
      expect(@enigma.encrypt("hello world", "02715", "040895")).to eq expected
    end

  #end
end

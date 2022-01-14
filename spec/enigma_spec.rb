require './helper.rb'

describe Enigma do
  #describe 'Primitive Functions' do
    before(:each) do
      @enigma = Enigma.new
    end

    it '1. exists' do
      expect(@enigma).to be_instance_of Enigma
    end

    # it '2. encrypts' do
    #   expect
    # end

  #end
end

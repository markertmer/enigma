require './helper.rb'

describe Crypt do
  describe 'Iteration 1' do
    before(:each) do
      @crypt = Crypt.new("name")
    end

    it 'exists' do
      expect(@crypt).to be_instance_of Crypt
    end

  end
end

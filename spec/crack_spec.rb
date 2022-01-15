require './helper.rb'

describe Crack do
  before(:each) do
    @crack = Crack.new("vjqtbeaweqihssi", "291018")
  end

  it '1. exists' do
    expect(@crack).to be_instance_of Crack
  end
end

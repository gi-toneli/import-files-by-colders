require 'rails_helper'

RSpec.describe ImportFile, type: :model do
  context "validating attributes" do
    it "should be invalid" do
      expect(subject.valid?).to be_falsy
      expect(subject.errors.size).to eql(2)
    end
    
  end
  
end

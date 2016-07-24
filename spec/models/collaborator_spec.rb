require 'rails_helper'

RSpec.describe Collaborator, type: :model do
  describe "factory" do
    it "has a valid factory" do
      expect(build(:collaborator)).to be_valid
    end
  end
  
  describe "associations" do
    it { is_expected.to belong_to(:wiki) }
    it { is_expected.to belong_to(:user) }
  end
    
end
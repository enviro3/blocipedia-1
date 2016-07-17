require 'rails_helper'

RSpec.describe User, type: :model do
  describe "factory" do
    it "has a valid factory" do
      expect(build(:user)).to be_valid
    end
  end

  describe "attributes" do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:role).of_type(:integer).with_options(default: 0, null: false) }
    it { should define_enum_for(:role).with([:standard, :premium, :admin]) }
  end
  
  describe "associations" do
    it { should have_many(:wikis).dependent(:destroy)}
  end
  
  describe "validations" do
  end
    
end
require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create(:user) }

  describe "attributes" do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should respond_to(:role) }
    it { should respond_to(:admin?) }
    it { should respond_to(:premium?) }
    it { should respond_to(:standard?) }
  end
    
  # Not sure what the equivalent are for these RSpec to Shoulda Matchers...

  describe "roles" do

    it "is standard by default" do
      expect(user.role).to eql("standard")
    end
 
    context "standard user" do
      it "returns true for #standard?" do
        expect(user.standard?).to be_truthy
      end
 
      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end
      
      it "returns false for #premium?" do
        expect(user.premium?).to be_falsey
      end
      
    end
 
    context "admin user" do
      before do
        user.admin!
      end
 
      it "returns false for #standard?" do
        expect(user.standard?).to be_falsey
      end
 
      it "returns true for #admin?" do
        expect(user.admin?).to be_truthy
      end
      
      it "returns false for #premium?" do
        expect(user.premium?).to be_falsey
      end
      
    end
    
    context "premium user" do
      before do
        user.premium!
      end
 
      it "returns false for #standard?" do
        expect(user.standard?).to be_falsey
      end
 
      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end
      
      it "returns true for #premium?" do
        expect(user.premium?).to be_truthy
      end
    end
  end

end

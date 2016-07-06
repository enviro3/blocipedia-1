require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:my_user)  { create(:user) }
  let(:premium)  { create(:user, role: 'premium')}

  # before(:each) do
  #   sign_in my_user
  # end

  describe "GET #index" do
    
    before :example do
      sign_in my_user
    end
    
    it "returns HTTP status success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "sets User.all to my_user" do
      get :index
      expect(assigns(:users)).to eq([my_user])
    end
   end

  describe "GET #show" do
    
    before :example do
      sign_in my_user
    end
    
    it "returns HTTP status success" do
      get :show, {id: my_user.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the show view" do
      get :show, {id: my_user.id}
      expect(response).to render_template :show
    end

    it "assigns my_user to @user" do
      get :show, {id: my_user.id}
      expect(assigns(:user)).to eq(my_user)
    end
  end

  describe "POST downgrade" do

    before :example do
      sign_in my_user
    end
    
    it "returns http redirect" do
      post :downgrade
  
    end
  end
end
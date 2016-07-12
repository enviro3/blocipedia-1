class UsersController < ApplicationController

  def downgrade
    @user = User.find(params[:id])
    @user.role = 'standard'
  
    if @user.save
      flash[:notice] = "You've been downgraded to standard. Your private wikis are now public."
      redirect_to :back
    else
      flash[:error] = "There was an error creating your account. Please try again."
      redirect_to :back
    end
  end
  
  def index
    @users = User.all
  end
  
  def show
  end
  
end
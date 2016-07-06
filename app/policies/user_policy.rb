class UserPolicy < ApplicationPolicy

  def destroy?
    user.present?
  end
  
  def index?
    user.present?
  end
  
  def show?
    @user = authorize User.find(params[:id])
  end
end
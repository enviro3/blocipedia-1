class WikiPolicy < ApplicationPolicy

  def index?
    user.admin? || user.wikis.count
  end

  def update?
    user.present?
  end

  def destroy?
    user.role == 'admin' || wiki.user == user
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def show?
    user.present? && (!wiki.private || user.admin? || wiki.user_id == user.id)
  end

  def edit?
    user.present?
  end

  class Scope
  attr_reader :user, :scope
  
  def initialize(user, scope)
    @user = user
    @scope = scope
  end
  
    def resolve
      if user.admin? || user.premium?
        return scope.all
      else
        return scope.where(private: false)
      end
      
      # wikis = []
      # if user.role == 'admin'
      #   wikis = scope.all # if the user is an admin, show them all the wikis
      # elsif user.role == 'premium'
      #   all_wikis = scope.all
      #   all_wikis.each do |wiki|
      #     if !wiki.private? || wiki.user == user || wiki.users.include?(user)
      #       wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
      #     end
      #   end
      # else # this is the lowly standard user
      #   all_wikis = scope.all
      #   wikis = []
      #   all_wikis.each do |wiki|
      #     if !wiki.private? || wiki.users.include?(user)
      #       wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
      #     end
      #   end
      # end
      # wikis # return the wikis array we've built up
    end
  end

end
class CollaborationPolicy < ApplicationPolicy
  def create?
    user.present? && (wiki.user == user) && user.role?(:premium)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end

end
class User < ActiveRecord::Base
  has_many :wikis
  enum role: [:standard, :premium, :admin]
  after_initialize :set_default_role
  
  #has_many :collaborations
  #has_many :wikis, through: :collaborations
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    role == :admin
  end
  
  def premium?
    role == :premium
  end
  
  def standard?
    role == :standard
  end
  
  #def downgrade
  #  self.role = :standard
  #    Wiki.where(user_id: id, private: true).destroy_all
  #  self.save
  #end
  
  private
  
  def set_default_role
    self.role ||= :standard
  end
end

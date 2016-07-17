class User < ActiveRecord::Base
  has_many :wikis, dependent: :destroy
  #has_many :collaborators
  #has_many :wikis, through: :collaborators
  
  enum role: [:standard, :premium, :admin]
  

  before_save { self.email = email.downcase }
  after_initialize { self.role ||= :standard }
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

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
  
  # private
  
  # def set_default_role
  #   self.role ||= :standard
  # end
  
end

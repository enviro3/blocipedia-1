class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
  # Associations
  
  has_many :wikis, dependent: :destroy
  #has_many :collaborators
  #has_many :wikis, through: :collaborators
  
  enum role: [:standard, :premium, :admin]
  
  # Validations
  
  # Call back
  before_save { self.email = email.downcase if self.email.present? }

  
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

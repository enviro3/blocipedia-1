class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
  enum role: [:standard, :premium, :admin]

  # Associations
  
  has_many :wikis, dependent: :destroy
  #has_many :collaborators
  #has_many :wikis, through: :collaborators
  
  # Validations
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  
  validates :name, 
    length: {minimum: 2, maximum: 100}, 
    presence: true
  
  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false},
    length: { minimum: 3, maximum: 254},
    format: { with: VALID_EMAIL_REGEX }
  
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

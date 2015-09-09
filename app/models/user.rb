class User < ActiveRecord::Base

  has_many :tasks
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, #:validatable,
          :confirmable,
         :omniauthable
  validates :nickname, presence: true, length: { maximum: 50 }, uniqueness: true
  
end

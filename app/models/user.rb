class User < ActiveRecord::Base

  has_many :tasks, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, #:validatable,
          #:confirmable,
         :omniauthable
  validates :nickname, presence: true, length: { maximum: 50 }, uniqueness: true
  
  letsrate_rater
end

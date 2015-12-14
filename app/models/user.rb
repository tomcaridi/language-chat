class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has many :natives
  has many :native_languages, through: :natives, source: :language

  has many :desireds
  has many :desired_languages, through: :desireds, source: :language
end

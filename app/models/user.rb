class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :natives
  has_many :native_languages, through: :natives, source: :language

  has_many :desireds
  has_many :desired_languages, through: :desireds, source: :language

  has_many :conversations, foreign_key: :sender_id

class LanguagePreference
	include ActiveModel::Model

	attr_accessor :native_id, :desired_id

	def save
		current_user.desired_languages << Di
		Desired.new
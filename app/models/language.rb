class Language < ActiveRecord::Base
	has_many :native_speakers, through: :native_languages, source: :natives
	has_many :desired_speakers, through: :desired_languages, source: :desireds
end

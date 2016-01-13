class LanguageChoicesController < ApplicationController
  # include ActiveModel::Model
  # attr_accessor :native_id, :desired_id
  
  def new
    @languages = Language.all
  	@user = current_user.id
  	@natives = Native.find_by(language_id: params[:language_id])
  	@desireds = Desired.find_by(language_id: params[:language_id])
  end

  def create
  	natives = params[:natives]
  	desireds = params[:desireds]
  	for d in desireds
  	  current_user.desired_languages.push(Language.find(d))
  	end  	

  	for n in natives
  	  current_user.native_languages.push(Language.find(d))
  	end
    redirect_to root_path, notice: "Welcome! Now you can start chatting with matched users."
  end

  def edit
  	@languages = Language.all
  	@user = current_user.id
  	@natives = Native.find_by(language_id: params[:language_id])
  	@desireds = Desired.find_by(language_id: params[:language_id])
  end

  def update
  	@natives.update(params[:natives])
  	@desireds.update(params[:desireds])
  	redirect_to root_path, notice: "Languages successfully updated"
  end
end
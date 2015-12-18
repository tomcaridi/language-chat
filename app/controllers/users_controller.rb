class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
	desired_languages = current_user.desired_languages
	native_languages = current_user.native_languages
	@users = User.where(id: Native.select(:user_id).where(language: desired_languages)).where(id: Desired.select(:user_id).where(language: native_languages))
    @conversations = Conversation.involving(current_user).order("created_at DESC")
  end
end
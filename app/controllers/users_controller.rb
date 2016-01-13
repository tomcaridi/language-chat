class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
	  @users = matched
    @conversations = Conversation.involving(current_user)
  end

  private
  def matched
    desired_languages = current_user.desired_languages
    native_languages = current_user.native_languages
    User.where(id: Native.select(:user_id).where(language: desired_languages)).where(id: Desired.select(:user_id).where(language: native_languages))
  end
end
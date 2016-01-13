class ConversationsController < ApplicationController
  before_filter :authenticate_user!

  def create
	@conversation = find_conversation
	if @conversation.save
	  redirect_to conversation_path(@conversation.id)
	else 
	  redirect_to root_path, alert: "There was an issue"
	end
  end

  def show
	@conversation = Conversation.find(params[:id])
	@receiver = interlocutor(@conversation)
	@messages = @conversation.messages
	@message = Message.new
	desired_languages = current_user.desired_languages
	native_languages = current_user.native_languages
	@users = User.where(id: Native.select(:user_id).where(language: desired_languages)).where(id: Desired.select(:user_id).where(language: native_languages))
	@conversations = Conversation.involving(current_user)
  end

  private

  def find_conversation
	current_user.conversations.find_or_initialize_by(recipient_id: params[:recipient_id])
  end

  def interlocutor(conversation)
	current_user == conversation.recipient ? conversation.sender : conversation.recipient
  end
end
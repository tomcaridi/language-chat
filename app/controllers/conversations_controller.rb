class ConversationsController < ApplicationController
	before_filter :authenticate_user!
	# layout false
	def create
	  if Conversation.between(params[:sender_id],params[:recipient_id]).present?
	  	@conversation = Conversation.between(params[:sender_id],params[:recipeient_id]).first
	  else
	  	@conversation = Conversation.create!(conversation_params)
	  end

	  render json: { conversation_id: @conversation.id }
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
	def conversation_params
	  params.permit(:sender_id, :recipient_id)
	end

	def interlocutor(conversation)
	  current_user == conversation.recipient ? conversation.sender : conversation.recipient
	end
end
class ConversationsController < ApplicationController
	before_filter :authenticate_user!

	def new
		@conversation = Conversation.new
		# @conversation = current_user.conversation.build
	end

	def create
	  if Conversation.between(params[:sender_id],params[:recipient_id]).present?
	  	@conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
	  else
	  	@conversation = Conversation.create!(conversation_params)
	  	redirect_to conversation_path(conversation.id)
	  end
	  render json: { conversation_id: @conversation.id }
	end

	def show
	  @conversation = Conversation.find(params[:id])
	  @receiver = interlocutor(@conversation)
	  @messages = @conversation.messages
	  @message = Message.new
	end

	private
	def conversation_params
	  params.permit(:sender_id, :recipient_id)
	end

	def interlocutor(conversation)
	  current_user == conversation.recipient ? conversation.sender : conversation.recipient
	end
end
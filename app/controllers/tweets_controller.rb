class TweetsController < ApplicationController
	before_action :authenticate_user! , only: [:create, :destroy]

	def index
		@tweet = current_user.tweets.build if user_signed_in?
	end

	def create
		@tweet = current_user.tweets.build(tweet_params)
		if @tweet.save
			redirect_to root_path, success: '<p class="alert alert-success"> Tweet posted</p>'
		else
			redirect_to root_path, danger: '<p class="alert alert-success">'+@tweet.errors.full_messages.to_sentence+'</p>'
		end
	end

	def show 
		@tweet = Tweet.find(params[:id])
    @comment = Comment.new
	end

	def hashtag
		@tweets = Tweet.all
	end

	private 
		def tweet_params
			params.require(:tweet).permit(:content)
		end

		def tweet_owner
			@tweet = current_user.tweets.find_by(id: params[:id])
		end

end

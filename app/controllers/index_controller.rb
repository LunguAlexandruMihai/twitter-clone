class IndexController < ApplicationController

	def index
		unless user_signed_in? 
			redirect_to new_user_session_path
		else
			@tweets = Tweet.where(user_id: current_user.id).all
			@tweet = current_user.tweets.build
			@feed  = User.get_feed current_user
		end

	end

	def followers
		unless user_signed_in?
			redirect_to new_user_session_path
		else
			@tweet = current_user.tweets.build
		end
	end

	def all_tweets
		unless user_signed_in?
			redirect_to new_user_session_path
		else
			@tweets = Tweet.all
			@tweet = current_user.tweets.build
		end
	end
	
end

class AddUserNicknameToUser < ActiveRecord::Migration
  def change
  	add_column :users , :tweetname, :string
  end
end

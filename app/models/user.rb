class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tweets, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: 'Relationship',
                                   dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower


  def self.get_feed id
    relationships = Relationship.select("followed_id").where(follower: id).all
    Tweet.where(user_id: relationships).all
  end

  def following? user
    relationships.find_by(followed_id: user.id)
  end

  def follow! user
    relationships.create(followed_id: user.id)
  end

  def unfollow! user
    relationships.find_by(followed_id: user.id).destroy()
  end

end
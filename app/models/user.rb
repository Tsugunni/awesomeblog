class User < ApplicationRecord
    has_many :microposts
    has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
    has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy
    # ↑中間テーブルをたくさん持っている
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower
    # ↑中間テーブルを通してたくさんのフォロー・フォロワーを持っている
    # ここの following, followers は @user.following.count として _user_info.html.erb で使われている。フォローしている・されているユーザー全部の情報が入っている
    # followed, follower は relationship.rb にある
    # ここの active_relationships, passive_relationships は下の関数と関係ない


    before_save { email.downcase! }
    # REGEX = Regular expression
    # To validate correct email structure
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 225 },
                format: { with: EMAIL_REGEX },
                uniqueness: { case_sensitive: false }

    has_secure_password
    validates :password, length: { minimum: 6 }, allow_nil: true

    def follow(other_user)
        Relationship.create(follower_id: id, followed_id: other_user.id)
    end
    # @user.follow でアクセスできる
    # current.user で来てるので id だけでいい

    def active_relationships
        Relationship.where(follower_id: id)
    end
    # する
    
    def passive_relationships
        Relationship.where(followed_id: id)
    end
    # される

    def relationship(other_user)
        active_relationships.find_by(followed_id: other_user.id)
    end

end

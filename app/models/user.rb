class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  #サーチ機能
  scope :search_by_name, ->(query) { ransack(name_cont: query).result }
  #エリアの設定
  belongs_to :region
  has_many :events, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :interesteds, dependent: :destroy
  has_many :absences, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar
  #has_many :relationships, foreign_key: :followed_id, dependent: :destroy
  # フォローする側からフォローされたユーザを取得する
  #has_many :followings, through: :relationships, source: :follower
  #has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id
  # フォローされる側からフォローしているユーザを取得する
  #has_many :followers, through: :reverse_of_relationships, source: :following

  # フォローをした、されたの関係
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  # 一覧画面で使う
  has_many :following_users, through: :followers, source: :followed
  has_many :follower_users, through: :followeds, source: :follower
  
  has_many :post_comments, dependent: :destroy
  #DM
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  
  
  def is_followed_by?(user)
    reverse_of_relationships.find_by(follower_id: user.id).present?
  end
  
  def already_favorited?(event)
    self.favorites.exists?(event_id: event.id) 
  end

  def already_interested?(event)
    self.interesteds.exists?(event_id: event.id) 
  end

  def already_absence?(event)
    self.absences.exists?(event_id: event.id) 
  end

    #バリゼーション（空欄をはじく）
  validates :username, presence: true
  
    #　フォローしたときの処理
  def follow(user_id)
    followers.create(followed_id: user_id)
  end
  
  #　フォローを外すときの処理
  def unfollow(user_id)
    followers.find_by(followed_id: user_id).destroy
  end
  
  #フォローしていればtrueを返す
  def following?(user)
    following_users.include?(user)
  end
  
  before_create :default_image

  def default_image
    if !self.avatar.attached?
      self.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'no-image.png')), filename: 'no-image.png', content_type: 'image/png')
    end
  end
  
  def self.search(word)
    @posts = Post.where("text LIKE?","#{word}%")
  end
  
  def self.ransackable_attributes(auth_object = nil)
    ["age", "created_at", "email", "encrypted_password", "gender", "id", "profile", "profile_image_id", "region_id", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at", "username"]
  end
  
end

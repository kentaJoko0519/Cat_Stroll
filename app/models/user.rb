class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :first_name, :last_name, :first_name_kana, :last_name_kana, presence: true
  
# post
  has_many :posts, dependent: :destroy
# bookmark
  has_many :bookmarks, dependent: :destroy
# comment
  has_many :comments, dependent: :destroy
# report
  has_many :reports, class_name: "Report", foreign_key: "reporter_id", dependent: :destroy
  has_many :reverse_of_reports, class_name: "Report", foreign_key: "reported_id", dependent: :destroy
# relationship
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

  # ユーザーをフォローする、controllerで使用
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す、controllerで使用
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す、viewで使用
  def following?(user)
    following_user.include?(user)
  end

  # プロフィール画像
    has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end

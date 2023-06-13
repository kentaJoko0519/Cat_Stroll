class Post < ApplicationRecord
  
  attribute :current_tags       # current_tagsというカラムを作成
# user
  belongs_to :user
# post_tags
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
# bookmark
  has_many :bookmarks, dependent: :destroy
# comment
  has_many :comments, dependent: :destroy

  before_validation :split_text
  after_save :save_tags
  after_initialize :append_tags

  def split_text
    data = self.introduction.split("#")     #新規投稿でのデータで、タグを表す # のもつデータを配列で、投稿文と分ける
    self.introduction = data.shift.chomp
    self.current_tags = data                #タグをcurrent_tagsへ
  end

  # タグの保存
  def save_tags
    posted_tags = self.current_tags.map{|tag| Tag.find_or_create_by(name: tag) }      #新規投稿時のタグが新しいものか既にあるものかを判別する
    recorded_tags = self.tags                           #新規投稿時に判別されたタグ
    new_tags = posted_tags - recorded_tags              #26と27行目で新しいタグかを判別
    old_tags = recorded_tags - posted_tags              #26と27行目で既にあるタグかを判別
    # 新しいタグの場合
    new_tags.each do |tag|
      self.post_tags.create!(tag_id: tag.id)
    end
    # 既に保存されているタグの場合
    old_tags.each do |tag|
      count = tag.post_tags.size
      if count <= 1
        tag.destroy
      else
        post_tag = self.post_tags.find_by(tag_id: tag.id)
        post_tag.destroy if post_tag
      end
    end
  end
  
  # 編集する際にフォームにタグを表示させる
  def append_tags
    recorded_tags = "\r\n#" + self.tags.pluck(:name).join(' #')
    self.introduction = self.introduction + recorded_tags
  end

# 既にブックマークしているかを検証します
  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

# 投稿画像(複数)
  has_many_attached :images
  def get_image(image, width, height)
    unless images.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end

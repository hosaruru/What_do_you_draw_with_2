class Post < ApplicationRecord
    has_one_attached :image
      belongs_to :user
      has_many :favorites, dependent: :destroy
      has_many :post_comments, dependent: :destroy    
      has_many :tagmaps, dependent: :destroy
      has_many :tags, through: :tagmaps
      has_many :pens, dependent: :destroy
      accepts_nested_attributes_for :pens, allow_destroy: true
    def favorited?(user)
   favorites.where(user_id: user.id).exists?
  end
    enum twitter: { youtube: 0, twitter: 1 }

 def self.posts_serach(search)
   Post.where(['title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%"])
 end

 def save_posts(tags)
   current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
   old_tags = current_tags - tags
   new_tags = tags - current_tags

   # Destroy
   old_tags.each do |old_name|
     tag= Tag.find_by(tag_name:old_name)
     self.tags.delete tag
     if Tagmap.where(tag_id:tag.id).count == 0
       tag.destroy
     end
   end

   # Create
   new_tags.each do |new_name|
     post_tag = Tag.find_or_create_by(tag_name:new_name)
     self.tags << post_tag
   end
 end
 def clean_tag
    self.tags.each do |tag|
       if Tagmap.where(tag_id:tag.id).where.not(post_id:self.id).count == 0
         tag.destroy
       end  
    end
 end

end

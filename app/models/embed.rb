class Embed < ApplicationRecord
  enum embed_type: { youtube: 0, twitter: 1 }
  validates :identifier, length: { maximum: 200 }
  def split_id_from_youtube_url
    # YoutubeならIDのみ抽出
    identifier.split('/').last if youtube?
end
end

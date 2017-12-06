class Post < ApplicationRecord
    belongs_to :category
    mount_uploader :image, ImageUploader
    validates :title, :summary, :body, presence: true
end

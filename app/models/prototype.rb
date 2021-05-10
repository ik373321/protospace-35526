class Prototype < ApplicationRecord

 has_many :comments, dependent: :destroy
 belongs_to :user
 has_one_attached :image
 validates :image, :title, :catch_copy, :concept,  presence: true
end

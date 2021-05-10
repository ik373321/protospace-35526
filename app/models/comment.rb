class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :prototype
  validates :text, :user, :prototype, presence: true
end

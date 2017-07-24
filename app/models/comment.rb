class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :content, presence: true,
            length: { minimum: 3, message: 'Comment body should be 3 chars min' }
  validates :content, length: { maximum: 1000, message: 'Comment body is too long!' }
  validates :title, length: {maximum: 300, message: 'Title should be 100 chars max'}
  validates :title, presence: true
end
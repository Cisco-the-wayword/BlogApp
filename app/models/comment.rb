class Comment < ApplicationRecord
  belongs_to :post, class_name: 'Post'
  belongs_to :author, class_name: 'User'

  after_create :update_post_comments_counter

  def update_post_comments_counter
    post.update_comments_counter
  end
end

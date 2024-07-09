class DeletePostJob < ApplicationJob
  queue_as :default

  def perform(post)
    # Find the post and destroy it
    post.destroy if post.present?  
  end
end

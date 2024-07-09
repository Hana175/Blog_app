class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post
    before_action :set_comment, only: [:update, :destroy]
  
    def create
      @comment = @post.comments.new(comment_params.merge(user: current_user))
      if @comment.save
        render json: @comment, status: :created
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @comment.user_id == current_user.id
        if @comment.update(comment_params)
          render json: @comment
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      else
        render json: { error: 'You can only edit your own comments' }, status: :forbidden
      end
    end
  
    def destroy
      if @comment.user_id == current_user.id
        @comment.destroy
      else
        render json: { error: 'You can only delete your own comments' }, status: :forbidden
      end
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def set_comment
      @comment = @post.comments.find(params[:id])
    end
  
    def comment_params
      params.require(:comment).permit(:body)
    end
  end
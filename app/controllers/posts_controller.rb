class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post, only: [:show, :update, :destroy]
  
    def index
      @posts = Post.all
      render json: @posts
    end
  
    def show
      render json: @post
    end
  
    def create
      @post = current_user.posts.new(post_params)
      if @post.save
         # Enqueue DeletePostJob with a delay of 24 hours
      DeletePostJob.set(wait: 24.hours).perform_later(@post)
      render json:@post, status: :created
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @post.user_id == current_user.id
        if @post.update(post_params)
          render json: @post
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      else
        render json: { error: 'You can only edit your own posts' }, status: :forbidden
      end
    end
  
    def destroy
      if @post.user_id == current_user.id
        @post.destroy
      else
        render json: { error: 'You can only delete your own posts' }, status: :forbidden
      end
    end
  
    private
  
    def set_post
      @post = Post.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit(:title, :body, tag_ids: [])
    end
  end
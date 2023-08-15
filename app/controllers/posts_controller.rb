class PostsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  def show
    post = Post.find(params[:id])
    
    render json: post
  end

  def update
    post = Post.find(params[:id])

    if post.update(post_params)
      render json: post
    else
      render json: { errors: post.errors }, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.permit(:category, :content, :title)
  end

  def not_found
    render json: {error: "Post not found"}, status: :not_found
  end

end

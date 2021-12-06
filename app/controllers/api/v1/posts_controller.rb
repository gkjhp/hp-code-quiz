class Api::V1::PostsController < ApplicationController
  before_action :load_post, only: [:show, :update, :destroy]

  def index
    threads = Post.threads.includes([:responses, :user])
    # refactor: this would be a lot nicer with jbuilder, pagination
    @posts = threads.map do |thread|
      {
        post: thread,
        author: thread.user,
        gravatar_url: thread.user.gravatar_url,
        replies: thread.responses.map do |reply|
          {
            post: reply,
            author: reply.user
          }
        end
      }
    end
    render json: @posts, status: 200
  end

  def create
    @post = Post.new(post_params.merge({ user_id: current_user.id }))

    if @post.save
      render json: @post
    else
      render json: @post.errors
    end
  end

  def update
    if @post.user == current_user
      @post.update(post_update_params)
      render json: @post
    else
      render json: { error: 'Not your post' }, status: :unauthorized
    end
  end

  def destroy
    if @post.user == current_user
      @post.archive!

      render json: { notice: 'Post archived.'}
    else
      render json: { error: 'Not your post' }, status: :unauthorized
    end
  end

  private

  def load_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.permit(:content, :parent_id)
  end

  def post_update_params
    params.permit(:content)
  end
end

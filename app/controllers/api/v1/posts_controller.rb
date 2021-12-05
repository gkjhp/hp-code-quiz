class Api::V1::PostsController < ApplicationController
  def index
    threads = Post.threads.includes([:responses, :user])

    # refactor: this would be a lot nicer with jbuilder, pagination
    @posts = threads.map do |thread|
      { post: thread,
        author: thread.user,
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
end

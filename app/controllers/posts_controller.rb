class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = PostsBuilderService.new(current_user, FacebookAdapter).posts
  end
end

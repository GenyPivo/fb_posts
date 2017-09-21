class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    fb_posts = PostsBuilderService.new(current_user, FacebookAdapter)
    binding.pry
  end
end

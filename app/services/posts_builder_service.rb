class PostsBuilderService
  def initialize(current_user, adapter)
    @adapter = adapter.new(current_user)
  end

  def posts
    @adapter.posts
  end
end

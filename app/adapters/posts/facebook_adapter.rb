class FacebookAdapter
  def initialize(current_user)
    user_graph = Koala::Facebook::API.new(current_user.oauth_token)
    @feed = user_graph.get_object('me/posts?limit=5&fields=comments.limit(5).summary(true),
                                    likes.summary(true),shares,message')
  end

  def posts
    @feed.map do |message|
      parse_message(message)
    end
  end

  private

  def parse_message(message)
    post = Post.new
    post.message = message['message']
    post.shares = message['shares'].try(:[], 'count') || 0
    post.likes = message['likes']['summary']['total_count']
    post.comments = parse_comments(message['comments']['data'])
    post
  end

  def parse_comments(comments)
    comments.map do |comment|
      comm = Comment.new
      comm.from = comment['from']['name']
      comm.message = comment['message']
      comm
    end
  end
end

module PostsHelper
  def comment_count(post)
    post.comments.count > 0 ? "#{post.comments.count} comments" : "no comments :("
  end
end
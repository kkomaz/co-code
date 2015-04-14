module PostsHelper
  def comment_count(post)
    post.comments.count > 0 ? "#{post.comments.count} comments" : "no comments :("
  end

  def delete_post_link(user, post)
    if post.user == user
      link_to "Delete Post", destroy_problem_post_path(post), :method => :delete, :remote => true
    end
  end
end

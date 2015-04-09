module CommentsHelper

  def delete_comment_link(user, comment)
    if comment.user == user
      link_to "Delete", post_comment_path(comment.post, comment), :method => :delete, :remote => true
    end
  end
end

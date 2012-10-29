module CommentsHelper

  def authorship_details_for(comment)
    [comment.author, l(comment.created_at, format: :long)].join(" - ")
  end
end

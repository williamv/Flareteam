module CommentsHelper
  def authorship_details_for(comment)
    [comment.author.to_s, posted_at(comment)].join(" - ")
  end

  def posted_at(comment, format = :long)
    posted_at = l(comment.created_at.in_time_zone(comment.author.time_zone), format: format)
  end
end

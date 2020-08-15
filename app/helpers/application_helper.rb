module ApplicationHelper
  def document_title
    if @title.present?
      "#{@title} - Catalks"
    else
      "Catalks"
    end
  end
end

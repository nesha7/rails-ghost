module PhrasingHelper
  def can_edit_phrases?
    current_user.present? && current_user.admin?
  end

  def safe_phrase(key, default_content = "")
    content = phrase(key) # call phrasing gem
    text_only = ActionView::Base.full_sanitizer.sanitize(content.to_s)
    if text_only == key
      PhrasingPhrase.find_or_create_by(key: key).update(value: default_content)
      content = phrase(key)
    end

    content
  end
end

module ApplicationHelper

  def full_title(page_title = "")
    base_title = "First Impression"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  # def gravatar_for(user)
  #   gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
  #   gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
  #   # image_tag(gravatar_url, alt: user.first_name, class: "gravatar")
  #   gravatar_image_tag(gravatar_url, :alt => 'Github Default Gravatar', :gravatar => { :default => 'https://assets.github.com/images/gravatars/gravatar-140.png' })
  # end

    def gravatar_for(user)
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
      image_url =  GravatarImageTag::gravatar_url(user.email, :d => :identicon)
      image_tag(image_url, alt: user.first_name, class: "gravatar")
    end

  def tel_to(text)
    groups = text.to_s.scan(/(?:^\+)?\d+/)
    link_to text, "tel:#{groups.join '-'}"
  end
end

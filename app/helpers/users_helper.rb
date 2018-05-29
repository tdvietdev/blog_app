module UsersHelper
  def gravatar_for(user, class_name = "gravatar",  options = {size: Settings.user_helper.size})
    class_name = "gravatar" if class_name == ""
    if user.avatar?
      gravatar_url = user.avatar.url
    else
      gravatar_id = Digest::MD5::hexdigest user.email.downcase
      size = options[:size]
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    end
      image_tag gravatar_url, alt: user.name, class: class_name
  end
end

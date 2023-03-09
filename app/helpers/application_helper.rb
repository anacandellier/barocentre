module ApplicationHelper

  def avatar_for(user)
    @avatar = user.avatar
    if @avatar.empty?
        @avatar_user = image_tag("https://pbs.twimg.com/media/C8QqGm3VYAEKUWC.jpg", alt: user.name)
    else
        @avatar_user = image_tag(@avatar.url, alt: user.name)
    end
    return @avatar_user
  end
end

module UsersHelper
  def user_avatar_photo(user, attributes = {})
    classes = attributes[:class] || ""
    data_toggle = attributes[:data_toggle] || ""
    id = attributes[:id] || ""

    # if user.photo?
    #   cl_image_tag user.photo.path, class: "#{classes}", id: "#{id}", "aria-hidden" => "true", "data-toggle" => "#{data_toggle}", "data-placement" => "top", "title" => user.first_name
    # else
    #   avatar_url = user.facebook_picture_url || "default_user_image.png"
      avatar_url = "default_user_image.png"
      image_tag avatar_url, class: "#{classes}", id: "#{id}", "aria-hidden" => "true", "data-toggle" => "#{data_toggle}", "data-placement" => "top", "title" => user.first_name
    # end
  end
end

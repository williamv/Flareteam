module NavigationHelper
  def organization_link(&block)
    title = capture(&block).html_safe
    if current_organization
      link_to title, edit_organization_path(current_organization)
    else
      link_to title, new_organization_invitation_request_path
    end
  end

  def affix_nav_list(items)

  end
end

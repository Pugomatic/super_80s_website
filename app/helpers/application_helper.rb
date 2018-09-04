module ApplicationHelper
  def resource_name
    :player
  end

  def resource
    @resource ||= Player.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:player]
  end

  def screenshot_tag(path)
    path = "screenshots/#{path}"
    content_tag("div", class: 'screenshot') do
      link_to asset_path(path), target: '_blank' do
        image_tag(path)
      end
    end
  end
end

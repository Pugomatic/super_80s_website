module ApplicationHelper

  def screenshot_tag(path)
    path = "screenshots/#{path}"
    content_tag("div", class: 'screenshot') do
      link_to asset_path(path), target: '_blank' do
        image_tag(path)
      end
    end
  end
end

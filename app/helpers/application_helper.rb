module ApplicationHelper
  def resource_name
    :player
  end

  def resource
    @resource ||= Player.new
  end

  def fix_lazer_font(text, limit = 20)
    return text unless text.empty? || text.length < limit
    dt = ""
    text.each_char do |char|
      if char == ' '
        dt << " &nbsp; "
      elsif %w(T t w W).include? char
        dt << "#{char}"
      else
        dt << "#{char} "
      end
    end
    dt
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

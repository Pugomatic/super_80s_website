module ApplicationHelper
  def resource_name
    :player
  end

  def value_for(obj, metric)
    case metric
    when 'score'
      obj.high_score
    when 'time'
      obj.fastest_time
    when 'kills'
      obj.max_kills
    when 'memo'
      obj.max_items_collected
    when 'tries'
      obj.tries
    when 'plays'
      obj.plays
    else
      ''
    end
  end

  def pad_with_8s(val, length = 12)
    val = val.to_s

    begin
      if val.blank?
        sanitize("<span class='out'>#{'8' * length}</span>", tags: %w(span))
      elsif val.length >= length
        truncate(val, length)
      else
        sanitize("<span class='out'>#{'8' * (length - val.length)}</span>#{val}", tags: %w(span))
      end
    rescue
      raise val.inspect
    end
  end

  def resource
    @resource ||= Player.new
  end

  def fix_lazer_font(text, limit = 20)
    return text if text.nil?
    return text unless text.length < limit
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

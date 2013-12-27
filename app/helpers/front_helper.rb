module FrontHelper

  def diff_color(rent_diff)
    'rent-diff-' + if rent_diff > 1
      'high'
    elsif rent_diff < -1
      'low'
    else
      'medium'
    end
  end

end

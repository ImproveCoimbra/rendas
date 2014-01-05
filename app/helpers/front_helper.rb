module FrontHelper

  def diff_color(rent_diff)
    'rent-diff-' + if rent_diff >= 0.5
      'high'
    elsif rent_diff <= -0.5
      'low'
    else
      'medium'
    end
  end

end

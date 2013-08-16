module ReportHelper
  def rating_for_expenditure(val, min, max)
    if val < min
      0.5
    elsif (val >= min && val <= max)
      2
    else
      1
    end
  end
end

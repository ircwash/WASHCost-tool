module ReportHelper
  def compute_rating_from_score(score)
    if score >= 7.5
      3
    elsif score >= 5 && score < 7.5
      2
    elsif score >= 2 && score < 5
      1
    else
      0
    end
  end

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

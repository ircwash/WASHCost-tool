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
end

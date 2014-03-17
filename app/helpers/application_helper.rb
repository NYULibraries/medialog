module ApplicationHelper
  def display_in_megabytes(bytes)
    return ((bytes / 1024) / 1024).round(2)
  end
end

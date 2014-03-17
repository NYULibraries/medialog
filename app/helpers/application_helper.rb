module ApplicationHelper
  def display_in_megabytes(bytes)
    bytes.nil? ? '' : ((bytes / 1024.0) / 1024.0).round(2)
  end
end

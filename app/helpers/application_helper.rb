module ApplicationHelper
  #ページがもし正しく表示されなかった時のために返すヘルパー
  def full_title(page_title = '')
    base_title = "Rails"
    if page_title.empty?
      base_title
    else
      page_title + "|" + base_title
    end
  end
end

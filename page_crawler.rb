require_relative './common'

def get_html(url)
  sleep 1
  open(url).read
end

def crawl_detail_url(page)
  restaurant_url = page.restaurant_url
  html = get_html(restaurant_url)
  page.update(html: html)
end

ids = Page.where(crawl_status: 1).pluck(:id)
ids.each do |id|
  begin
    page = Page.find(id)
    page.update(crawl_status: 1)
    crawl_detail_url(page)
    page.update(crawl_status: 2)
  rescue => e
    puts e.message
    puts e.backtrace
    page.update(crawl_status: 3)
  end
end

require_relative 'common'

def fetch_url(url)
  sleep 1
  open(url).read
end

def create_page_record(list_restaurant)
  name = list_restaurant.at_css('.list-rst__rst-name a').text.strip
  genre = list_restaurant.at_css('.list-rst__rst-name span')&.text&.gsub('/', '')&.strip
  rating_score = list_restaurant.at_css('.list-rst__rating-val')&.text&.strip
  review_count = list_restaurant.at_css('.cpy-review-count')&.text&.strip
  restaurant_url = list_restaurant.at_css('.list-rst__rst-name a')['href']
  return if Page.exists?(restaurant_url: restaurant_url)

  Page.create(
    crawl_status: 0,
    name: name,
    restaurant_url: restaurant_url,
    genre: genre,
    rating_score: rating_score,
    review_count: review_count
  )
end

def crawl(url)
  target_url = url
  loop do
    doc = Nokogiri::HTML.parse(fetch_url(target_url))
    lists_restaurant = doc.css('.list-rst__wrap')
    lists_restaurant.each do |list_restaurant|
      create_page_record(list_restaurant)
    end
    next_node = doc.css('li.c-pagination__item a').last
    break if doc.css('li.c-pagination__item a').empty?
    break unless next_node['rel'] == 'next'

    target_url = next_node['href']
  end
end

BASE_URL = 'https://tabelog.com/go-to-eat/list/'.freeze
top_doc = Nokogiri::HTML.parse(fetch_url(BASE_URL))
pref_urls = top_doc.css('.list-area li a').map { |a| a[:href] }
pref_urls.each do |prefecture_url|
  next unless prefecture_url.include?('tokyo')
  prefecture_doc = Nokogiri::HTML.parse(fetch_url(prefecture_url))
  area_level2_table = prefecture_doc.at_css('ul.list-level2').css('a')
  area_level2_table.each do |area_level2|
    area_level2_url = area_level2['href']
    area_level2_doc = Nokogiri::HTML.parse(fetch_url(area_level2_url))
    restaurant_count = area_level2_doc.at_css('div.c-page-count').text[/(\d+) 件$/, 1].to_i
    # 最大表示件数が1,200件までなので1,200件になるまでエリアを絞り込む
    if restaurant_count <= 1200
      crawl(area_level2_url)
    else
      area_level3_table = area_level2_doc.at_css('ul.list-level3').css('a')
      area_level3_table.each do |area_level3|
        area_level3_url = area_level3['href']
        crawl(area_level3_url)
      end
    end
  end
end

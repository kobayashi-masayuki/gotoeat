require_relative 'common'

def postal_code(doc)
  restaurant_json = doc.at_css('script[@type="application/ld+json"]').text
  restaurant_hash = JSON.load(restaurant_json)
  postalcode = restaurant_hash[0]['address']['postalCode'] # 7桁の郵便番号
  return nil unless postalcode

  "#{postalcode[0..2]}-#{postalcode[3..6]}"
end

def address(doc)
  table = doc.at_css('#rst-data-head')
  table.css('tr').each do |tr|
    return tr.at_css('.rstinfo-table__address').text.strip if tr.at_css('th').text == '住所'
  end
  nil
end

def business_hours(doc)
  table = doc.at_css('#rst-data-head')
  table.css('tr').each do |tr|
    return tr.at_css('td').text.gsub(/\s/,'') if tr.at_css('th')&.text == '営業時間・定休日'
  end
  nil
end

def parse(page_rec)
  doc = Nokogiri::HTML.parse(page_rec.html)
  restaurant_info = {}
  restaurant_info[:page_id] = page_rec.id
  restaurant_info[:name] = doc.at_css('.display-name span').text.strip
  restaurant_info[:postal_code] = postal_code(doc)
  restaurant_info[:image_url] = doc.at_css("meta[property='og:image']").attribute('content').text
  restaurant_info[:homepage_url] = doc.at_css('.homepage a')[:href] if doc.at_css('.homepage')
  restaurant_info[:phone_number] = doc.css('strong.rstinfo-table__tel-num')[1]&.text
  restaurant_info[:resevation_phone_number] = doc.css('strong.rstinfo-table__tel-num')[0]&.text
  restaurant_info[:tabelog_url] = doc.at_css("meta[property='og:url']").attribute('content').text
  restaurant_info[:genre1] = doc.css('.linktree__parent-target-text')[2]&.text&.strip
  restaurant_info[:genre2] = doc.css('.linktree__parent-target-text')[3]&.text&.strip
  restaurant_info[:genre3] = doc.css('.linktree__parent-target-text')[4]&.text&.strip
  restaurant_info[:rating_score] = doc.at_css('.rdheader-rating__score-val-dtl').text
  restaurant_info[:budget__price_lunch] = doc.css('.rdheader-budget__price-target')[1].text
  restaurant_info[:budget__price_dinner] = doc.css('.rdheader-budget__price-target')[0].text
  restaurant_info[:station] = doc.css('.linktree__parent-target-text')[0].text
  restaurant_info[:address] = address(doc).gsub(/\s|　/, '')
  restaurant_info[:business_hours] = business_hours(doc)
  restaurant_info[:feature] = doc.at_css('.pr-comment-title.js-pr-title')&.text&.strip
  restaurant_info
end

ids = Page.where(crawl_status: 2, parse_status: 0).pluck(:id)
ids.each do |id|
  page_rec = Page.find(id)
  # page_rec.update(parse_status: 1)
  begin
    restaurant_info = parse(page_rec)
    Detail.create(restaurant_info)
    page_rec.update(parse_status: 2)
  rescue => e
    puts e.message
    puts e.backtrace
    puts page_rec.id
    page_rec.update(crawl_status: 3)
  end
end

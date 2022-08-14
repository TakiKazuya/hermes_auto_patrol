require './hermes_crawler'
require './notification'

url = "https://www.hermes.com/jp/ja/category/women/bags-and-small-leather-goods/small-leather-goods/#|"
result_array = HermesCrawler.new(url).fetch_products

wanted_list = %w[ピコタン シルクイン]

wanted_list.each do |wanted|
  wanted_products = result_array.select do |hash|
    hash[:name].include?(wanted)
  end

  return if wanted_products.empty?

  message_text = "#{wanted}が追加されました！"
  Notification.push_line_message(message_text)

  wanted_products.each do |product|
    name = product[:name]
    link = product[:link]

    Notification.push_line_message(name)
    Notification.push_line_message(link)
  end
end

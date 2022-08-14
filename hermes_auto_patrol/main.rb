require 'selenium-webdriver'

driver = Selenium::WebDriver.for :chrome

driver.get 'https://www.hermes.com/jp/ja/category/women/bags-and-small-leather-goods/small-leather-goods/#|'

products_name_elements = driver.find_elements(class: 'product-item-name')
names = products_name_elements.map(&:text)

products_elements = driver.find_elements(class: 'product-item')
links = products_elements.map do |element|
  link = element.find_element(tag_name: 'a')
  link.attribute("href")
end

hash = names.zip(links).map.with_index do |(name, link), index|
  { index: index, product_name: name, link: link }
end

puts hash

driver.quit

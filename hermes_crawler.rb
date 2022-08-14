require 'selenium-webdriver'

class HermesCrawler
  # @param [String] url 商品一覧ページ
  def initialize(url)
    @driver = Selenium::WebDriver.for :chrome
    @driver.get url
  end

  # @return [Array]
  def fetch_products
    products_name_elements = @driver.find_elements(class: 'product-item-name')
    names = products_name_elements.map(&:text)

    products_elements = @driver.find_elements(class: 'product-item')
    links = products_elements.map do |element|
      link = element.find_element(tag_name: 'a')
      link.attribute("href")
    end

    @driver.quit

    names.zip(links).map.with_index do |(name, link), index|
      { index: index, name: name, link: link }
    end
  end
end

class ScrapeJob < ApplicationJob
  queue_as :default

  def perform(url)
    begin
      scraper = WebScraperService.new(url)
      data = scraper.scrape_data
      product = Product.find_by(title: data[:title], category_id: data[:category_id])
      product ? product.update(data) : Product.create(data)
    rescue => e
      Rails.logger.info e.message
    end
  end
end

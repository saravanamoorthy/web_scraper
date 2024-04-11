class WebScraperService
  def initialize(url)
    @url = url
  end

  def scrape_data
    uri = URI.parse(@url)
    if uri.hostname.include?('amazon')
      AmazonWebScraper.new(@url).data
    else
      raise ArgumentError, 'Unsupported website'
    end
  end
end
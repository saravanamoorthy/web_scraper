class AmazonWebScraper

  attr_accessor :url ,:html, :doc

  def initialize(url)
    @url = url
    init_scrap
  end

  def init_scrap
    begin
      @html = URI.open(@url, "User-Agent" => "ruby")
    rescue => e
      e.message
    end
    @doc = Nokogiri::HTML(@html)
  end

  def data
    {
      title: title,
      description: description,
      price: price,
      category_id: category_id,
      url: url
    }
  end

  def title
    doc.at_css("h1#title span").content.strip || ''
  end

  def price
    doc.at_css('span.a-price-whole').content&.gsub(',', '')&.to_f || 0
  end

  def description
    doc.css('div#feature-bullets ul li span').map { |span| span.content.strip }.join('. ') || ''
  end

  def category_id
    Category.find_or_create_by(name: category).id
  end

  def category
    categories.last
  end

  def categories
    doc.css('div#wayfinding-breadcrumbs_feature_div ul > li > span.a-list-item a').map { |link| link.content.strip }
  end
end
class ScrapperService
  def initialize(url)
    @url = url
    scrap!
  end

  def title
    @parsed.css('title').text
  end

  private

  def scrap!
    @response = HTTParty.get(@url)
    @parsed = Nokogiri::HTML(@response.body)
  end
end
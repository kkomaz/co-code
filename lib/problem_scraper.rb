require 'open-uri'

class ProblemScraper
  Content_URL = "https://projecteuler.net/show=all"

  attr_accessor :content_doc, :difficulty_doc

  def initialize
    get_content_doc
    get_difficulty_doc
  end

  def get_content_doc
    @content_doc = Nokogiri::HTML(open(Content_URL)).search("div#content")
  end

  def get_difficulty_doc
    f = File.open("lib/difficulty_source.html")
    @difficulty_doc = Nokogiri::XML(f).search("div.info")
    f.close
  end

  def create_import_hash
    @content_doc.search("h3").collect.with_index do |title, index|
      {:title => scrape_title(title),
      :content => scrape_content(title.next_sibling),
      :difficulty => scrape_difficulty(index)}
    end
  end

  def scrape_title (title)
    title.children.text
  end

  def scrape_content (content)
    content.to_s
    .gsub("<img src=\"", "<img src=\"https://projecteuler.net/")
    .gsub(/(\r\n|\r|\n)/," ")
    .gsub("href=\"", "href=\"https://projecteuler.net/")
  end

  def scrape_difficulty(index)
    if @difficulty_doc[index]
      raw = @difficulty_doc[index].attr("style")[/width:\d+/].gsub("width:","").to_i
      (raw / 10.0).ceil
    else
      10
    end
  end

end
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
    result = @content_doc.search("h3").collect.with_index do |title, index|
      {:title => scrape_title(title),
      :difficulty => scrape_difficulty(index)}
    end

    @content_doc.search('.problem_content').each_with_index do |description, index|
      result[index][:content] = (description.children.text.to_s.strip.gsub(/\r/," ").gsub(/\n/," "))
    end
    result
  end

  def scrape_title (title)
    title_filtered = title.children.text
    final_title = title_filtered.slice(0..(title_filtered.index('Published'))).slice(0..-2)
    final_title
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
require 'pry'

class Scraper

  # create an array of all of the movies on the 'Top 250 list.' Each movie should be a hash with their :name :stars

  def self.scrape_main_page(list_url)
    doc = Nokogiri::HTML(open(list_url))

    list = doc.css("tbody.lister-list tr")

    films = []

    list.each do |movie|
      film = {}
      film[:title] = movie.css("td.titleColumn a").text
      film[:stars] = movie.css("td.ratingColumn.imdbRating strong").text
      film[:url] = movie.css("td.titleColumn a").attribute("href").value.to_s
      film[:release_date] = movie.css("td.titleColumn span.secondaryInfo").text.gsub(/[()]/, "").to_i
      films << film
    end

    films
  end

  def self.scrape_movie_page(page_url)
    # page_url = page_url.sub(/http:\/\//, "")
    # page_url = "http://" + page_url
    doc = Nokogiri::HTML(open(page_url))

    film = {}
    film[:rating] = doc.css("div.title_wrapper div.subtext meta").attribute("content").value
    film[:runtime] = doc.css("div.title_wrapper div.subtext time").children.text.gsub(/^[ \t]+/, "").gsub(/\n/, "")
    film[:genres] = doc.css("div.title_wrapper div.subtext a span.itemprop").map {|genre| genre.text}
    film
  end
end

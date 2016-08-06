class Movie
  attr_accessor :title, :stars, :url, :release_date, :rating, :runtime, :genres, :ranking
  @@all = []

  def self.create_from_hash_array(hash_array)
    hash_array.each do |hash|
      movie = Movie.new
      hash.each do |key, value|
        movie.send("#{key}=", "#{value}")
      end
      Movie.save(movie)
    end
  end

  def add_details_from_hash(hash)
    hash.each do |key, value|
      self.send("#{key}=", "#{value}")
    end

    self.genres = self.genres.gsub(/["\[\],]/, "").split(" ")
  end

  def correct_movie_url
    self.url = self.url.to_s
    self.url = "http://www.imdb.com/" + self.url
  end

  def self.assign_ranking
    all.each.with_index do |movie, idx|
      movie.ranking = idx + 1
    end
  end

  def self.save(movie)
    self.all << movie
  end

  def self.all
    @@all
  end

end
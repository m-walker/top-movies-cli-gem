class DisplayMovies

  def call
    welcome
    explore_library
    goodbye
  end

  def explore_library
    puts "Which range would you like to see?"
    input = nil
    while true 
      input = gets.strip
      input == "exit" ? break : input

      list_twenty_five(input)

      input = gets.strip
      input == "exit" ? break : input

      display_one(input)
      sleep(2)

      puts "Do you want to see more? (Y/N)"
      input = gets.strip
      input == "Y" || input == "y" ? instructions : break
    end
  end

  def list_twenty_five(ranking)
    puts ""
    puts ""
    puts "IMBd's Top Movies"
    Movie.all.each.with_index(1) do |movie, idx|
      ranking = ranking.to_i
      rankings = (ranking..(ranking+24))
      rankings.include?(idx) ? (puts "#{idx}. #{movie.title} - #{movie.stars}" ) : next
    end
    puts ""
    puts "select a movie to see more info"
    puts ""
  end

  def display_one(ranking)
    ranking = ranking.to_i

    to_be_displayed = Movie.all.detect{|movie| (movie.ranking) == ranking}
    more_info = Scraper.scrape_movie_page(to_be_displayed.url)
    to_be_displayed.add_details_from_hash(more_info)
    
    puts "--------------------------------------------"
    puts "YOUR SELECTION"
    puts ""
    puts "#{to_be_displayed.title}"
    puts "  rating: #{to_be_displayed.rating}"
    puts "  runtime: #{to_be_displayed.runtime}"
    print "  genres: "
    to_be_displayed.genres.map{|genre| genre + " "}.each do |genre|
      print genre
    end
    puts ""
    if to_be_displayed.release_date
      puts "  release_date: #{to_be_displayed.release_date}"
    end
    puts "--------------------------------------------"
  end

  def instructions
    puts "------------------------------------------------------------------------------------------"
    puts "Welcome to IMDb's list of the top 250 movies of all time!"
    puts "You can view a list of a set of 25 and then ask for more information about any of them."
    puts ""
    puts "    1-25    51-75   101-125   151-175   201-225"
    puts "    26-50   76-100  126-150   176-200   225-250"
    puts ""
    puts "Instructions:"
    puts "- select the group you would like to view by typing in the first number!"
    puts "- if you wish to exit, type 'exit'"
    puts "------------------------------------------------------------------------------------------"
  end

  def welcome
    puts "------------------------------------------------------------------------------------------"
    puts "Welcome to IMDb's list of the top 250 movies of all time!"
    puts "You can view a list of a set of 25 and then ask for more information about any of them."
    puts ""
    puts "    1-25    51-75   101-125   151-175   201-225"
    puts "    26-50   76-100  126-150   176-200   225-250"
    puts ""
    puts "Instructions:"
    puts "- select the group you would like to view by typing in the first number!"
    puts "- if you wish to exit, type 'exit'"
    puts "------------------------------------------------------------------------------------------"
  end

  def goodbye
    puts "Thanks for stopping by! Enjoy the show."
  end

end
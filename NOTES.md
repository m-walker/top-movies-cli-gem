# top-movies-cli-gem

I want to: display top movies (in a list) and movie information. I will scrape this information from IMBD's top movies page as well as the movie page associated with each of the top movies. Therefore my models will be the following:
Models: Movie, Scraper, DisplayMovie

To do this, I have to do a number of things
1. Create movies from main list page
- Scraper: scrape data from IMDB's website
- Movie: Instantiate movie instances and assign some attributes when fed a hash of information from Scraper
2. Assign more attributes based on each movie's home page
- Scraper: scrape the link associated with the movie
- Movie: assign attributes based on the hash given
3. Display the data
  a. Display a list of 25 movies (as selected by the user)
  b. Display a movie and all of its attributes (as selected by the user)
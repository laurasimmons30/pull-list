#My-Pull-List

##About

My-Pull-List makes it easy to keep up to date with your comic subscriptions week to week. The app uses a series of calls to the Comicvine API to retrieve comic information such as titles, cover art, store dates, and issue descriptions. There is also use of a nokogiri webscraper to get the full list of titles available for the current week. A user can customize their own pull list of titles they would like to follow simply by signing in with Twitter.  

##Under the Hood

* Twitter Oauth for secure sign in
* Comics are always released on a Wednesday. The current week is determined from Monday to the following Sunday, by `self.comic_date(date)` method in the `comic.rb` [comic.rb](/app/models/comic.rb)
* When a user uses the search form to add to their pull list, a call is made to the Comicvine API for volumes, using the received `comic_name` param in the API fields `&field_list=id,name,start_year,publisher&filter=name:#{comic_name}&format=json` to return all results for that search. 
* Results have a restraint of year greater than 2005 `volume["start_year"].to_i > 2005`, and are sorted with most recent at the top.
* AJAX is used to render search results
* The nokogirl webscrap on the home page displays the full list of comic issues being released for the week, and supplies links to other sites where a user can purchase the titles.
* Snap and slide scroll effect implemented for modern UI with jquery pluggin [fullPage.js](https://github.com/alvarotrigo/fullPage.js/)
* PostgresSQL database with many to many, and many to one relations depicted in ER diagrams in next section.
* The Comicvine API only allows a certain number of calls a day, so an issues tables was added to the database to store any user pull list items already saved to cache and minimize the total API usage. This also significantly increases page loading times. 


##ER Diagrams

![ER Diagrams]
(http://i356.photobucket.com/albums/oo9/lsimm30/Screen%20Shot%202015-07-27%20at%2012.00.08%20PM_zpstepdlatg.png)
##Clone It

```git clone git@github.com:laurasimmons30/pull-list.git pull-list
cd pull-list
bundle install
rake db:create db:migrate
```

##Next Steps
* Continue modifying UI with javascript and images
* Contine to fine tune API utilization for more accurate search results
* Add delete features from pull list show pages
* Fully integrate mobile responsive interface
* Continue testing and TDD


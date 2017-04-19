# Vote

* ~~Decide how to vote~~
    * display a set of buttons with the different votes
    * disable them once one is clicked
    * at the end of the countdown, display the average (just for testing, does not have to be nicely styled
* ~~Overall design~~
    * Enhance the vote_started view
        * disable the buttons once one is clicked
    * send the vote when clicked
        * could send to every team member, for him to store its vote, but would make the design highly mutable
    * broadcast the vote when the time is over (from the server)
        * need a backgroung task
        * need a ref to the vote : currently, the team could do, but makes it highly mutable
    * or we could create a vote table
        * team would have many votes
        * but only one current vote
            * ? use time, latest id, or a special column
            * using latest would make the design more append only
        * every vote would have contributions
        * every contribution would have
            * a team member
            * and a vote (because with time, it's not always the current)
* ~~Create sub tasks about how I am going to do it~~
* ~~Write a test~~
* Enhance the vote_started view
    * ~~add a test~~
    * ~~add the buttons~~
    * ~~factorize the votes from the tests and the code~~
    * style the buttons
* disable the buttons once one is clicked
* create a vote table and model
    * team would have many votes
    * but only one current vote (the latest)
* refactor the current vote views to link to this model
* send the vote when clicked
* Create the contribution table and model
    * a team member
    * and a vote (because with time, it's not always the current)
* When the vote is started, start a background task on the server to end the vote
* broadcast the average when the vote is ended
* ? change the url as vote goes through steps (to make it rational how to start a new vote)

# Next Stories

* Display extra info about the vote results like
        * The median
        * The average
        * The standard deviation
* What about responsive design and display on phones (useful in meeting rooms) ?
* Garbage collect old elections and votes

# Smells
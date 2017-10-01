# UsersAndPosts
Demo Swift project with view controller testing, generic data source, supports iPhone and iPad

### Possible improvements:
* Additional tests for the view controllers.
* Remove async code from view controllers entirely and do the fetching in either a new "loading" controller with activity indicator, or in the in APIClient, with a callback instead of completion block.
* Improve font and appearance of text.
* Move error presentation away from view controllers and test them.
* Place all protocol implementations in extensions.

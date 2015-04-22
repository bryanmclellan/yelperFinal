## Yelp

This is a Yelp search app using the [Yelp API](http://developer.rottentomatoes.com/docs/read/JSON).

Time spent: 13

### Features

#### Required

- [check] Search results page
   - [check] Table rows should be dynamic height according to the content height
   - [check] Custom cells should have the proper Auto Layout constraints
   - [check] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
- [check] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
   - [check] The filters you should actually have are: category, sort (best match, distance, highest rated), radius (meters), deals (on/off).
   - I could not figure out how to complete the category filter
   - [check] The filters table should be organized into sections as in the mock.
   - [check] You can use the default UISwitch for on/off states. Optional: implement a custom switch
   - [check] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
   - [ ] Display some of the available Yelp categories (choose any 3-4 that you want).

#### Optional

- [ ] Search results page
   - [ ] Infinite scroll for restaurant results
   - [ ] Implement map view of restaurant results
- [ ] Filter page
   - [ ] Radius filter should expand as in the real Yelp app
   - [ ] Categories should show a subset of the full list with a "See All" row to expand. Category list is here: http://www.yelp.com/developers/documentation/category_list (Links to an external site.)
- [ ] Implement the restaurant detail page.

### Walkthrough
![My Image](https://github.com/bryanmclellan/yelperFinal/blob/master/YelpDemo.gif)

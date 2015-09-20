chrome_store_search is a Ruby gem that provides apps, extensions and themes search functions in chrome web store.

### Installation

```sh
$ gem install chrome_store_search
```

Or with Bundler in your Gemfile.

```ruby
gem 'chrome_store_search'
```

### Usage
It supports ruby 1.9.3+.

```ruby

require 'chrome_store_search'

chrome_store_search = ChromeStoreSearch::Search.new(:category => "apps")

# it will return app arrary which app only have basic info.
chrome_store_search.search("bird")

# also can get app detail info if have app id
ChromeStoreSearch::App.new("dkiahcckehgdocgonfdickeagmoembpe")

```

###Configuring

```ruby
chrome_store_search = ChromeStoreSearch::Search.new(:count => 100, :category => "apps")

* `count`: searched apps count
* `category`: search category. Default:nil. (can be "apps","extensions","themes").
```

###Search Result
The below is app basic info from app search
```ruby
app_list = chrome_store_search.search("bird")
app = app_list[0]

# chrome app id (like "aknpkdffaafgjchaibgeefbgmgeghloj")
app.id

# chrome app name (like "Angry Birds")
app.name

# chrome app detail url
app.url

# chrome app short description
app.short_description

# chrome app small logo url. (about 50*50)
app.small_logo_url

# chrome app big logo url. (about 128*128)
app.big_logo_url

# chrome app rating
app.rating

# chrome app total rating count
app.total_rating_count

# chrome app total users
app.total_users

```

###App detail info
The below is app detail info which get it by app id

```ruby
app = ChromeStoreSearch::App.new("dkiahcckehgdocgonfdickeagmoembpe")

# it also can get basic info same as above
# id, name, url, short_description, small_logo_url,
# big_logo_url, rating, total_rating_count, total_users

# app long description
app.description

# app site
app.site

# app version
app.version

# app updated date
app.updated_at

# app support url
app.support_url

# app videos url(array)
app.videos

# app images url(array)
app.images

# app size(ex: 14.52KB)
app.size

# app languages(array)
app.languages

```

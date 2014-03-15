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

```ruby
# only 1.8.7 need this
require 'rubygems'

require 'chrome_store_search'

chrome_store_search = ChromeStoreSearch::Search.new(:category => "apps")

# it will return app arrary.
chrome_store_search.search("bird")
```

###Configuring

```ruby
chrome_store_search = ChromeStoreSearch::Search.new(:count => 100, :category => "apps")

* `count`: searched apps count
* `category`: search category. Default:nil. (can be "apps","extensions","themes").
```

###Search Result
```ruby
app_list = chrome_store_search.search("bird")
app = app_list[0]

# chrome app id (like "aknpkdffaafgjchaibgeefbgmgeghloj")
app.id

# chrome app name (like "Angry Birds")
app.name

# chrome app detail url
app.url

# chrome app description
app.description

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

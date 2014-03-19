#Sinatra Init

Run the shell script sinatra_init.sh in any repository to setup Sinatra file structure utilizing ActiveRecord and Postgresql with some starter files.

Structure designed for one resource (one model/class, no relationships).

Placeholder resource is 'users' (class User, database: users_db). Placeholder attribute is 'attribute'

Structure includes:

* db, models, public, views, spec folder (formatted with RSpec)
* db/shema.sql, db/seeds.rb
* models/user.rb
* views/
  * layout.erb
  * root.erb
  * index.erb
  * show.erb
  * new.erb
  * edit.erb
* public/styles/style.css
* spec/spec_helper.rb
* spec/spec_helper.rb spec/user_spec.rb
* server.rb with appropriate RESTful routes and instance variables

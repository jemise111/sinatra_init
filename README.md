#Sinatra Init

Run the shell script sinatra_init.sh in any repository to setup Sinatra file structure utilizing ActiveRecord and Postgresql with some starter files and helper text.

Structure designed for one resource (one model/class, no relationships).

Placeholder resource is 'users' (class User, database: users_db). Placeholder attribute is 'attribute'
Change these in all files accordingly.

Structure includes:

* db, models, public, views, spec folder (using RSpec)
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
* server.rb with appropriate RESTful routes, instance variables, and
  root page

---

#Creating an alias

To create an alias add the following to your bash profile (assuming sinatra_init is in your home directory)

```
chmod u+rwx ~/sinatra_init/sinatra_init.sh
alias sinatrainit=~/sinatra_init/sinatra_init.sh
```

Then when inside any directory run 'sinatrainit' to run.

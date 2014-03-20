mkdir db models public views
mkdir public/styles
touch server.rb db/schema.sql db/seeds.rb views/layout.erb views/index.erb views/show.erb views/root.erb views/edit.erb views/new.erb public/styles/style.css models/user.rb
rspec --init
rm spec/spec_helper.rb
touch spec/spec_helper.rb
touch spec/user_spec.rb
cat <<EOS >> server.rb
require 'sinatra'
require 'sinatra/reloader'
require 'active_record'
require_relative './models/user'

ActiveRecord::Base.establish_connection(
  database: 'users_db',
  adapter: 'postgresql'
)

after{ActiveRecord::Base.connection.close}

get('/') do
  # ROOT action
  erb(:root)
end

get('/users') do
  # INDEX action
  @users = User.all
  erb(:index)
end

get('/users/new') do
  # NEW action, likely a form
  erb(:new)
end

get('/users/:id') do
  # SHOW action
  @user = User.find(params[:id])
  erb(:show)
end

post('/users') do
  # CREATE action
  User.create(params[:user])
  redirect '/users'
end

get('/users/:id/edit') do
  # EDIT action
  @user = User.find(params[:id])
  erb(:edit)
end

put('/users/:id') do
  # UPDATE action
  User.find(params[:id]).update(params[:user])
  redirect '/users'
end

delete('/users/:id') do
  # DESTROY action
  User.find(params[:id]).destroy
  redirect '/users'
end

EOS
cat <<EOS >> db/schema.sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY
  -- include other attributes here
);
EOS
cat <<EOS >> db/seeds.rb
# User.create(<attributes go here>)
EOS
cat <<EOS >> models/user.rb
require 'active_record'

class User < ActiveRecord::Base
end
EOS
cat <<EOS >> views/layout.erb
<!doctype html>
<html>
  <head>
    <link rel="stylesheet" href="/styles/style.css">
    <title></title>
  </head>
  <body>
    <%= yield %>
  </body>
</html>
EOS
cat <<EOS >> views/root.erb
<!-- Homepage -->
EOS
cat <<EOS >> views/index.erb
<% @users.each do |user| %>
  <!-- Display user here -->
  <!-- Link to edit form
  <a href="/users/<%= user.id %>/edit">edit</a>
  -->
<% end %>
EOS
cat <<EOS >> views/show.erb
<!-- show user using @user -->

<!-- Uncomment to add delete button
<form action="/users/<%= @user.id %>" method="post">
  <input type="hidden" name="_method" value="delete">
  <input type="submit" value="delete user">
</form>
-->
EOS
cat <<EOS >> views/new.erb
<!-- Form to create new user. Add/change attributes -->
<form action="/users" method="post">
  <label>Attribute:
    <input type="text" name="user[attribute]">
  </label>
  <input type="submit" value="create user">
</form>
EOS
cat <<EOS >> views/edit.erb
<!-- Form to edit a user with pre-populated values. Add/change attributes -->
<form action="/users/<%= @user.id %>" method="post">
  <input type="hidden" name="_method" value="put">
  <label>Attribute:
    <input type="text" name="user[attribute]" value="<%= @user.attribute %>">
  </label>
  <input type="submit" value="edit user">
</form>
EOS
cat <<EOS >> spec/user_spec.rb
require_relative './spec_helper'
require_relative '../models/user'

describe User do
  describe '.new' do
    it 'should create a new user with attributes' do
      test_user = User.new(<insert attributes here>)
      expect(user.id).to_not be_nil
      expect(user.<some attribute>).to eq(<some value>)
    end
  end
end
EOS
cat <<EOS >> spec/spec_helper.rb
require 'active_record'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.around do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

ActiveRecord::Base.establish_connection(
  database: "users_db",
  adapter: "postgresql"
)

EOS

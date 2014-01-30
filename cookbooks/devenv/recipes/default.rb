include_recipe "build-essential"

# install ruby_build
include_recipe 'ruby_build'

# build and install ruby
ruby_build_ruby node['app-rails']['ruby-string'] do
  prefix_path "/opt/rubies/#{node['app-rails']['ruby-string']}"
end

# install chruby
node.default['chruby']['default'] = 'system'
include_recipe 'chruby'

# install bundler
gem_package 'bundler' do
  gem_binary "/opt/rubies/#{node['app-rails']['ruby-string']}/bin/gem"
end

# Install Postgres
include_recipe "postgresql::server"

# create a user
pg_user "john" do
  privileges superuser: true, createdb: true, login: true
  password "password"
end

include_recipe "vim"
include_recipe "the_silver_searcher"

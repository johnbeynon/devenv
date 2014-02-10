include_recipe "build-essential"

# ZSH
package 'zsh'

# Switch to ZSH
execute "set zsh as default shell" do
  command "chsh -s $(which zsh) vagrant"
end

# TMUX
package 'tmux'

package 'python-pip'

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

#include_recipe "redisio::install"
#include_recipe "redisio::enable"

link "/home/vagrant/.tmux.conf" do
  to "/home/vagrant/dotfiles/tmux.conf"
end

git "/home/vagrant/dotfiles" do
  repository "https://github.com/johnbeynon/dotfiles"
  reference "master"
  action :checkout
  user "vagrant"
  group "vagrant"
end

link "/home/vagrant/.zshrc" do
  to "/home/vagrant/dotfiles/zshrc"
end

# VIM Setup
link "/home/vagrant/.vim" do
  to "/home/vagrant/dotfiles/vim"
end

link "/home/vagrant/.vimrc" do
  to "/home/vagrant/dotfiles/vim/vimrc"
end

directory "/home/vagrant/.vim/bundle" do
  action :create
  user "vagrant"
  group "vagrant"
end

git "/home/vagrant/.vim/bundle/vundle" do
  repository "https://github.com/gmarik/vundle.git"
  reference "master"
  action :checkout
  user "vagrant"
  group "vagrant"
end

execute "vim +BundleInstall! +qall" do
  user "vagrant"
  action :run
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})                                                             
end


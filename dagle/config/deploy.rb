# config valid only for current version of Capistrano
lock "3.7.2"
require 'colorize'

def quit(msg)
  puts ('*' * 50).yellow
  puts
  puts msg.red
  puts
  puts ('*' * 50).yellow
  puts
  exit(1)
end

puts <<-MSG.yellow
Cap参数说明：
APP_NAME=dagle REPO=dagle PROJECT_NAME=sxhop DEPLOY_TO=demo cap production deploy

APP_NAME: 这个名字决定了 sidekiq 等服务生产的文件名，不填默认就是PROJECT_NAME
REPO: 对应gitlab仓库项目的名字，不填默认就是dagle
PROJECT_NAME: 项目名称，必填
DEPLOY_TO: 部署到哪个目录，不填默认就是 APP_NAME 或 PROJECT_NAME，这个参数可以部署多个dagle系统给客户演示

例如，临时部署dagle系统给一个客户做演示，给客户演示的域名是 nj1688.dagle.cn：

APP_NAME=nj1688.dagle REPO=dagle PROJECT_NAME=dagle DEPLOY_TO=nj1688.dagle cap production deploy

可以简化为：

APP_NAME=nj1688.dagle REPO=dagle PROJECT_NAME=dagle cap production deploy

又例如我们像改变自有的dagle系统部署的目录，那么可以这样：

PROJECT_NAME=dagle DEPLOY_TO=new-dagle cap production deploy

  MSG

quit("项目名PROJECT_NAME必须填写在命令行中提供") unless ENV['PROJECT_NAME']
set :application, ENV['APP_NAME'] || ENV['PROJECT_NAME']
set :default_env, {
  'PROJECT_NAME' => ENV['PROJECT_NAME']
}

set :repo_url, "git@gitlab.tanmer.com:tanmer/#{ENV['REPO'] || ENV['PROJECT_NAME']}.git"
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :deploy_to, "/data/www/#{ENV['DEPLOY_TO'] || fetch(:application)}"

set :rvm_ruby_version, '2.3.4'

before "deploy", :check_branch do

  branch_prefix = "#{fetch(:application)}-"
  # quit("branch名称必须以#{branch_prefix}开头，否者不允许部署!") unless fetch(:branch).start_with?(branch_prefix)
  if fetch(:branch).start_with?(branch_prefix)
    set :branch, fetch(:branch)[branch_prefix.length..-1]
  end

  puts <<-MSG.green
        app name: #{fetch(:application)}
    project name: #{ENV['PROJECT_NAME']}
real repo url is: #{fetch(:repo_url)}
  real branch is: #{fetch(:branch)}
       deploy to: #{fetch(:deploy_to)} on #{env.servers.map(&:hostname).join(', ')}
  MSG
  # require 'pry-rails'
  # binding.pry
  ask(:is_start_to_deploy, 'start to deploy? (y/n, default=n)', 'n')

  quit("aborted") if fetch(:is_start_to_deploy).strip.downcase != 'y'
end


# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/settings.#{ENV['PROJECT_NAME']}.yml", "config/application.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/assets", "public/ckeditor_assets", 'node_modules', 'public/photos', 'public/attachments', 'public/templetes', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
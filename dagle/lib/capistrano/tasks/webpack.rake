namespace :webpack do

  after 'deploy:assets:precompile', 'webpack:defaults'

  task :defaults => ['install', 'precompile'] do
  end

  desc "Install npm packages for webpack"
  task :install do
    on roles(:assets) do |h|
      within release_path do
        execute :yarn
      end
    end
  end

  desc "Compile assets for webpack"
  task :precompile do
    on roles(:assets) do |h|
      within release_path do
        with rails_env: fetch(:stage) do
          execute :bundle, :exec, 'rails webpack:compile'
        end
      end
    end
  end
end

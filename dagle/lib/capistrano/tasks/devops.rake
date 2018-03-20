namespace :devops do
  desc "Check rails log"
  task :log do
    on roles(:web) do |h|
      within release_path do
        execute :tail, "-f log/#{fetch(:rails_env)}.log -n 1000"
      end
    end
  end
end

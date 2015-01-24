namespace :heroku do
  desc 'Create new heroku instance of Grouper'
  task create_instance: :environment do
    `heroku create`
    `git push heroku master`
    `heroku run rake db:migrate`
    `heroku ps:scale web=1`
    `heroku addons:add mandrill:starter`
    `heroku open`
  end
end

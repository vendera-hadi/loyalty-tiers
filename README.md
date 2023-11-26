
# README



Welcome to Backend API of **loyalty program**
To run this API make sure you have **ruby on rails** installed into your OS, for this case, i am using Ubuntu OS, please read this tutorial about how to install: 

    https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-20-04

Clone this repository and then, change directory to root project folder.

    cd {root_project_path}
Copy env template file to real env file, and after that change database credential inside **.env** file (MYSQL)


    cp .env.example .env
Run migration & seed file using this command:

    rails db:migrate db:seed
Run bundle install to install dependencies

    bundle install
Then register rake task to crontab using this command:

    bundle exec whenever --update-crontab
Or if you want to run the recalculate task manually, pls use this command:

    rake customer:recalculate

To Run the server please run this command:

    rails s -p 8080

Important: It has to be port 8080, because the FE project already set to hit port 8080
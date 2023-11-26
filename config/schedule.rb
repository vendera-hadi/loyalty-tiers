# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# execute this command to register to crontab:
# bundle exec whenever --update-crontab
every 1.year, at: 'December 31th 11:59pm' do
    rake "customer:recalculate"
end

# Learn more: http://github.com/javan/whenever

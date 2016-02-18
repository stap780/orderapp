# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
# rake "updateorder"
#set :bundle_command, "/usr/local/bin/bundle"


# очистить cron -> crontab -r
# просмотр cron -> crontab -l
# сохранение и запуск cron в режиме девелопмент (писать в терминале) ->  whenever --set environment='development' --write-crontab
# разница во времения с сервером 7 часов

env :PATH, ENV['PATH']
set :output, "#{path}/log/cron.log"

every 10.minutes do
  runner "Iorder.downloadorder", :environment => :development
  
end

every 10.minutes do
  runner "Iorder.updateorder", :environment => :development
  
end

every :day, :at => '12:21' do 
  runner "Product.updateproduct", :environment => :development
  
end

# every :day, :at => '12:26' do 
#   runner "Energy.updateproduct"
#   
# end

# every :day, :at => '12:31' do # починил работу загрузки из модели и заменил задание на работу из модели, а не из задачи
#   rake "emagupdate", :environment => :development
#   
# end

every :day, :at => '12:31' do 
  runner "Emag.emagupdate", :environment => :development
  
end

# every :day, :at => '12:36' do # починил работу загрузки из модели и заменил задание на работу из модели, а не из задачи
#   rake "rrcupdate", :environment => :development
#   
# end

every :day, :at => '12:36' do 
  runner "Rrc.rrcupdate", :environment => :development
  
end

every :day, :at => '12:46' do 
  runner "Product.checkquantity", :environment => :development
  
end

# every :day, :at => '13:16' do 
#   runner "Product.synchronize"
#   
# end

# __________________ Обновление цен по курсу ЦБ для ICR18650.ru в 19:16 __________________
every :day, :at => '12:16' do 
  runner "Icr.updateproduct", :environment => :development
  
end
# __________________
# __________________ Обновление статусов доставки IML и DPD __________________
every 3.hours do
  runner "Iml.updateiml", :environment => :development
  
end

every 3.hours do
  runner "Dpd.updatedpd", :environment => :development
  
end

every 3.hours do
  runner "Iorder.checkdelivery", :environment => :development
  
end
# __________________
# __________________ Обновление Ситилинк в 18:11 __________________
every :day, :at => '11:11' do 
  runner "Citylink.updateproduct", :environment => :development
  
end
# __________________

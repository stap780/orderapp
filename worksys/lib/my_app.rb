class MyApp < InsalesApi::App
  self.api_key = 'app1'
end

MyApp.configure_api('http://worksys.myinsales.ru', '9b80e05c79004aef0b077ba6d4ed220a')
require File.dirname(__FILE__) + '/lib/yandex_geocode.rb'

geo = Geocode.new("AKaGj00BAAAAz2OPKAIA608dLocZlaNxLvYZYsVUM57Ip9MAAAAAAAAAAAAN3VjKAA2y2tQtrqARB1EU80UO3w==")
geo.get("Москва")
geo.parse
p geo.result

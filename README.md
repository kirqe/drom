# Drom

парсер drom.ru


    $ gem install drom

## Возможные варианты использования
```ruby

s = Drom.search(make: "toyota", model: "camry", maxprice: 900000, minyear: 2009, status: :spinner)
s.listings
# > [{поля которые были доступны "Двигатель"=>"бензин, 3.5 л", "Мощность"=>"249 л.с", ...}, {}, ...]

# status: :spinner показывает прогресс в терминале

# сохраняет результат в listings.csv
s = Drom.search(make: "toyota", model: "camry", minprice: 900000, maxyear: 2010)
s.to_csv

#
s = Drom.search(make: "toyota", model: "camry", minprice: 900000, maxyear: 2010)
s.each { |listing| p listing["Цена"] }

arr = []
Drom.search(make: "toyota", model: "camry") { |listing| arr << listing["Цена"] }
# > arr
# => ["235000", "249999", nil, "300000", ...]

s = Drom.search(make: "toyota", model: "camry")
s.map { |e| e["Цена"] }
# => ["10000", "109000", "130000", "270000", "270000", nil, "300000", "222000", "300000"]

Drom.get_single_listing(url)
# {"Двигатель"=>"бензин, 3.5 л", "Мощность"=>"249 л.с", ...}
```

Пример того как может выглядеть csv: [listing.csv](./listings.csv)

## License

[MIT](./LICENSE)

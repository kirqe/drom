# Drom


## Installation

    $ gem install drom

## Возможные варианты использования
```ruby

Drom.search(make: "toyota", model: "camry", maxprice: 900000, minyear: 2009)
# > [{поля которые были доступны "Двигатель"=>"бензин, 3.5 л", "Мощность"=>"249 л.с", ...}, {}, ...]

# сохраняет результат в listings.csv
Drom.search(make: "toyota", model: "camry", minprice: 900000, maxyear: 2010).to_csv

arr = []
Drom.search(make: "toyota", model: "camry") { |listing| arr << listing["Цена"] }
# > arr
# => ["235000", "249999", nil, "300000", ...]

Drom.get_single_listing(url)
# {"Двигатель"=>"бензин, 3.5 л", "Мощность"=>"249 л.с", ...}
```

Пример того как может выглядеть csv: [listing.csv](./listings.csv)

## License

[MIT](./LICENSE)

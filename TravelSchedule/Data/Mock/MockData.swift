import Foundation

enum MockData {
    static let cities: [City] = [
        City(id: "c213", title: "Москва", stations: [
            Station(id: "s2000006", title: "Киевский вокзал"),
            Station(id: "s2000001", title: "Курский вокзал"),
            Station(id: "s2000002", title: "Ярославский вокзал"),
            Station(id: "s2000007", title: "Белорусский вокзал"),
            Station(id: "s2000009", title: "Савёловский вокзал"),
            Station(id: "s2006004", title: "Ленинградский вокзал"),
        ]),
        City(id: "c2", title: "Санкт-Петербург", stations: [
            Station(id: "s9602494", title: "Московский вокзал"),
            Station(id: "s9602498", title: "Ладожский вокзал"),
            Station(id: "s9602497", title: "Балтийский вокзал"),
            Station(id: "s9602496", title: "Финляндский вокзал"),
        ]),
        City(id: "c239", title: "Сочи", stations: [
            Station(id: "s9623547", title: "Сочи"),
            Station(id: "s9623540", title: "Адлер"),
        ]),
        City(id: "c11050", title: "Горный воздух", stations: [
            Station(id: "s9613483", title: "Горный воздух"),
        ]),
        City(id: "c35", title: "Краснодар", stations: [
            Station(id: "s9623120", title: "Краснодар-1"),
            Station(id: "s9623124", title: "Краснодар-2"),
        ]),
        City(id: "c43", title: "Казань", stations: [
            Station(id: "s9623144", title: "Казань-Пассажирская"),
        ]),
        City(id: "c66", title: "Омск", stations: [
            Station(id: "s9629161", title: "Омск-Пассажирский"),
        ]),
    ]

    static let rzd = Carrier(
        id: "112",
        title: "РЖД",
        logo: "RZDLogo",
        email: "info@rzd.ru",
        phone: "+7 (800) 775-00-00"
    )
    static let fgk = Carrier(
        id: "113",
        title: "ФГК",
        logo: "FGKLogo",
        email: "info@fgk.ru",
        phone: "+7 (800) 775-00-00"
    )
    static let uralLogistics = Carrier(
        id: "114",
        title: "Урал логистика",
        logo: "UralLogisticsLogo",
        email: "info@ural-logistics.ru",
        phone: "+7 (343) 000-00-00"
    )

    static let trips: [Trip] = [
        Trip(id: "1", carrier: rzd, date: "14 января", departureTime: "22:30", arrivalTime: "08:15", duration: "20 часов", transferCity: "Костроме"),
        Trip(id: "2", carrier: fgk, date: "15 января", departureTime: "01:15", arrivalTime: "09:00", duration: "9 часов", transferCity: nil),
        Trip(id: "3", carrier: uralLogistics, date: "16 января", departureTime: "12:30", arrivalTime: "21:00", duration: "9 часов", transferCity: nil),
        Trip(id: "4", carrier: rzd, date: "17 января", departureTime: "22:30", arrivalTime: "08:15", duration: "20 часов", transferCity: "Костроме"),
        Trip(id: "5", carrier: rzd, date: "17 января", departureTime: "07:10", arrivalTime: "15:40", duration: "8 часов", transferCity: nil),
        Trip(id: "6", carrier: fgk, date: "18 января", departureTime: "16:45", arrivalTime: "05:20", duration: "13 часов", transferCity: "Твери"),
    ]
}

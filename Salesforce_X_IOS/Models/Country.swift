import Foundation

struct Country: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let code: String // ex: +33
    let flag: String // ex: 🇫🇷
}

extension Country {
    static let france = Country(name: "France", code: "+33", flag: "🇫🇷")
    static let usa = Country(name: "United States", code: "+1", flag: "🇺🇸")
    static let uk = Country(name: "United Kingdom", code: "+44", flag: "🇬🇧")
    static let germany = Country(name: "Germany", code: "+49", flag: "🇩🇪")
    static let spain = Country(name: "Spain", code: "+34", flag: "🇪🇸")
    static let israel = Country(name: "Israel", code: "+972", flag: "🇮🇱")
    static let all: [Country] = [.france, .usa, .uk, .germany, .spain, .israel]
} 
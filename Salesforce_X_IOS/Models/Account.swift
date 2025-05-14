import Foundation

struct Account: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    let birthDate: Date
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    // Formatage de la date pour l'affichage
    var formattedBirthDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: birthDate)
    }
    
    // Conversion en JSON pour l'affichage console
    func toJSON() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        
        do {
            let data = try encoder.encode(self)
            return String(data: data, encoding: .utf8)
        } catch {
            print("Error encoding Account: \(error)")
            return nil
        }
    }
} 
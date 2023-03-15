import Foundation

struct ProfileImage: Codable {
    let small: String?
    let medium: String?
    let large: String?
    
    var image: String? { large ?? medium ?? small }
}

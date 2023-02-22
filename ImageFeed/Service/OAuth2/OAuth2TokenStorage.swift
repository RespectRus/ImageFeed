import UIKit
import SwiftKeychainWrapper

final class OAuth2TokenStorage {
    private let keychainWrapper = KeychainWrapper.standard
    private enum Keys: String {
        case bearerToken
    }
    
    var token: String? {
      get {
          return keychainWrapper.string(forKey: Keys.bearerToken.rawValue)
      }
      set {
          if let token = newValue {
              keychainWrapper.set(token, forKey: Keys.bearerToken.rawValue)
          }
      }
    }
}

import Foundation

enum Constants {
    static let accessKey = "InsrsXtDqqAnS87QhUbvESsvqurg0g5g8J72mLtpiCk"
    static let secretKey = "miNJ8ds5YaGvCyDkJQ3S3BKJF-UjUGG_cqHbb9wOuiY"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    static let defaultBaseURL = URL(string: "https://api.unsplash.com")!
    static let tokenURL = "https://unsplash.com/oauth/token"
    static let authorizeURL = "https://unsplash.com/oauth/authorize"
    static let profileURL = "\(defaultBaseURL)/me"
    static let profileImageURL = "\(defaultBaseURL)/users"
    static let photoUrl = "\(defaultBaseURL)/photos"
    static let nativePath = "/oauth/authorize/native"
}

struct AuthConfiguration {
    let accessKey: String
    let secretKey: String
    let redirectURI: String
    let accessScope: String
    let defaultBaseURL: URL
    let authURLString: String
    
    init(accessKey: String, secretKey: String, redirectURL: String, accessScope: String, defaultBaseURL: URL, authURLString: String) {
        self.accessKey = accessKey
        self.secretKey = secretKey
        self.redirectURI = redirectURL
        self.accessScope = accessScope
        self.defaultBaseURL = defaultBaseURL
        self.authURLString = authURLString
    }
    
    static var standart: AuthConfiguration {
        return AuthConfiguration(accessKey: Constants.accessKey,
                                 secretKey: Constants.secretKey,
                                 redirectURL: Constants.redirectURI,
                                 accessScope: Constants.accessScope,
                                 defaultBaseURL: Constants.defaultBaseURL,
                                 authURLString: Constants.authorizeURL)
    }
}

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


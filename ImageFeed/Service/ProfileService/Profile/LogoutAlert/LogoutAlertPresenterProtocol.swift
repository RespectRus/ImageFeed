import UIKit

protocol LogoutAlertPresenterProtocol: AnyObject {
    func requestShowLogoutAlert(alertModel: LogoutAlertModel?)
}

import UIKit

extension UIColor {
    static func asset(_ name: ColorAsset) -> UIColor {
        return UIColor(named: name.rawValue) ?? UIColor(white: 1, alpha: 0.5)
    }
}

import UIKit

extension UIFont {
    static func asset(_ name: FontAsset, size: CGFloat) -> UIFont {
        return UIFont(name: name.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

import UIKit

extension UIImage {
    static func asset(_ name: ImageAsset) -> UIImage {
        guard let image = UIImage(named: name.rawValue) else {
            fatalError("Empty asset with name \(name.rawValue)")
        }
        return image
    }
}

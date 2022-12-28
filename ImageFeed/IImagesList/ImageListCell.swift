import UIKit

final class ImagesListCell: UITableViewCell {
    
    @IBOutlet weak var dataLable: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    
    static let reuseIdentifier = "ImagesListCell"
}

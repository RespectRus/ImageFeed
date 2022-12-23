import UIKit

final class ImagesListCell: UITableViewCell {
    
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var cellImage: UIImageView!
    static let reuseIdentifier = "ImagesListCell"

    @IBOutlet weak var gradientView: UIView!
    
}

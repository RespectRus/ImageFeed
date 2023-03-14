import UIKit

protocol ImagesListCellDelegate: AnyObject {
    func imageListCellDidTapLike(_ cell: ImagesListCell)
    func reloadView(_ cell: ImagesListCell)
}

final class ImagesListCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    
    static let reuseIdentifier = "ImagesListCell"
    
    weak var delegate: ImagesListCellDelegate?
    
    @IBAction func likeButtonClicked() {
        delegate?.imageListCellDidTapLike(self)
    }
    
    private func reloadView() {
        delegate?.reloadView(self)
    }
    
    public func configure(from photo: Photo) {
        cellImage.kf.indicatorType = .activity
        cellImage.kf.setImage(with: photo.thumbImageURL)
        cellImage.kf.setImage(with: photo.thumbImageURL){result in self.reloadView()}
        dateLabel.text = DateFormatter().displayFormat.string(from: photo.createdAt)
        setIsLiked(isLiked: photo.isLiked)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // отменяем загрузку, чтобы избежать багов при переиспользовании ячеек
        cellImage.kf.cancelDownloadTask()
    }
    
    public func setIsLiked(isLiked: Bool) {
        let likeImage = isLiked ? UIImage(named: "active_like_button") : UIImage(named: "no_active_like_button")
        likeButton.setImage(likeImage, for: .normal)
    }
}


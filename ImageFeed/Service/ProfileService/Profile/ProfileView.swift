import UIKit

protocol ProfileViewProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }
    func updateProfile(from profile: Profile?)
    func updateAvatar(_ image: UIImage)
    func requestShowAlertGetAvatarError(alertModel: ErrorAlertModel)
}

final class ProfileView: UIView {
    
    weak var viewController: ProfileViewControllerProtocol?
    var presenter: ProfilePresenterProtocol?
    
    // MARK: - UI object
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var photoAndExitButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var lablesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "profile_image_log_out")
        imageView.image = image
        imageView.layer.cornerRadius = 35
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage.asset(ImageAsset.exitProfileButton), for: .normal)
        button.accessibilityIdentifier = "logout button"
        button.addTarget(self, action: #selector(didExitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Екатерина Новикова"
        label.textColor = UIColor.asset(ColorAsset.ypWhite)
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        return label
    }()
    
    private lazy var loginNameLabel: UILabel = {
        let label = UILabel()
        label.text = "@ekaterina_nov"
        label.textColor = UIColor.asset(ColorAsset.ypWhite).withAlphaComponent(0.5)
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, world!"
        label.textColor = UIColor.asset(ColorAsset.ypWhite)
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    // MARK: - Initializers
    init(frame: CGRect, viewController: ProfileViewControllerProtocol) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.asset(ColorAsset.ypBackground)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.viewController = viewController
        let helper = ProfileHelper()
        presenter = ProfilePresenter(helper: helper)
        presenter?.view = self
        presenter?.viewDidLoad()
        addSabViews()
        activateConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - Private methods
    private func addSabViews() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(photoAndExitButtonStackView)
        stackView.addArrangedSubview(lablesStackView)
        
        photoAndExitButtonStackView.addArrangedSubview(profileImageView)
        photoAndExitButtonStackView.addArrangedSubview(exitButton)
        
        lablesStackView.addArrangedSubview(nameLabel)
        lablesStackView.addArrangedSubview(loginNameLabel)
        lablesStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func activateConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 76),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            photoAndExitButtonStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            photoAndExitButtonStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            
            exitButton.heightAnchor.constraint(equalToConstant: 44),
            exitButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func didExitButtonTapped() {
        guard let alertModel = presenter?.creatLogoutAlert() else { return }
        viewController?.logoutProfile(alertModel: alertModel)
    }
}

// MARK: ProfileViewProtocol
extension ProfileView: ProfileViewProtocol {
    func updateAvatar(_ image: UIImage) {
        profileImageView.image = image
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
    }
    
    func requestShowAlertGetAvatarError(alertModel: ErrorAlertModel) {
        self.viewController?.showAlertGetAvatarError(alertModel: alertModel)
    }
    
    func updateProfile(from profile: Profile?) {
        guard let profile else { return }
        nameLabel.text = profile.name
        loginNameLabel.text = profile.username
        descriptionLabel.text = profile.bio
    }
}

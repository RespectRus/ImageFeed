import UIKit

class ProfileViewController: UIViewController {
    
    private var nameLabel: UILabel?
    private var loginNameLabel: UILabel?
    private var discriptionLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView()
    }
    
    private func settingsView() {
        
        //MARK: - ImageView
        
        let profileImage = UIImage(named: "photo.profile")
        let imageView = UIImageView(image: profileImage)
        
        imageView.layer.cornerRadius = 35
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        //MARK: - Labels
        
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor(named: "YP White (iOS)")
        nameLabel.text = "Екатерина Новикова"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 23.0)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        self.nameLabel = nameLabel
        
        let loginNameLabel = UILabel()
        loginNameLabel.textColor = UIColor(named: "YP Gray (iOS)")
        loginNameLabel.text = "@ekaterina_nov"
        loginNameLabel.font = loginNameLabel.font.withSize(13)
        loginNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginNameLabel)
        self.loginNameLabel = loginNameLabel
        
        let discriptionLabel = UILabel()
        discriptionLabel.textColor = UIColor(named: "YP White (iOS)")
        discriptionLabel.text = "Hello, world!"
        discriptionLabel.font = discriptionLabel.font.withSize(13)
        discriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(discriptionLabel)
        self.discriptionLabel = discriptionLabel
        
        //MARK: - Button
        
        let button = UIButton.systemButton(
            with: UIImage(systemName: "ipad.and.arrow.forward")!,
            target: self,
            action: #selector(Self.didTapButton)
        )
        button.tintColor = UIColor(named: "YP Red (iOS)")
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        //MARK: - Activate
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            
            nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26),
            button.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            loginNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            loginNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            
            discriptionLabel.leadingAnchor.constraint(equalTo: loginNameLabel.leadingAnchor),
            discriptionLabel.topAnchor.constraint(equalTo: loginNameLabel.bottomAnchor, constant: 8)
        ])
    }
    
    @objc
    private func didTapButton() {
        nameLabel?.removeFromSuperview()
        nameLabel = nil
        loginNameLabel?.removeFromSuperview()
        loginNameLabel = nil
        discriptionLabel?.removeFromSuperview()
        discriptionLabel = nil
    }
}


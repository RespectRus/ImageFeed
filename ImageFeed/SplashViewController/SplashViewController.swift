import UIKit
import ProgressHUD

final class SplashViewController: UIViewController {
    
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private var isAuthorized: Bool = false
    private let oAuth2Service = OAuth2Service()
    private var oAuth2TokenStorage: OAuth2TokenStorageProtocol = OAuth2TokenStorage()
    private let errorAlertController = ErrorAlertViewController()
    
    private let showAuthIdentifier = "ShowAuthIdentifier"
    
    private var splashImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "YP Black (iOS)")
        createImageSplash()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkAuth()
    }
    
    private func createImageSplash() {
        let splashImage = UIImage(named: "Logo_YP")
        let splashImageView = UIImageView(image: splashImage)
        splashImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(splashImageView)
        self.splashImageView = splashImageView
        
        NSLayoutConstraint.activate([
            splashImageView.widthAnchor.constraint(equalToConstant: 75),
            splashImageView.heightAnchor.constraint(equalToConstant: 77.68),
            splashImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            splashImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ])
    }
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
        window.rootViewController = tabBarController
    }
    
    private func checkAuth() {
        guard isAuthorized == false else  {
            return
        }
        
        if oAuth2TokenStorage.token != nil {
            UIBlockingProgressHUD.show()
            fetchProfile()
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            guard let authViewController = storyboard.instantiateViewController(
                withIdentifier: "AuthViewController"
            ) as? AuthViewController else {
                return
            }
            authViewController.delegate = self
            authViewController.modalPresentationStyle = .fullScreen
            present(authViewController, animated: true)
        }
    }
}

extension SplashViewController: AuthViewControllerDelegate {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        isAuthorized = true
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            UIBlockingProgressHUD.show()
            self.fetchOAuthToken(code)
        }
    }
    
    private func fetchOAuthToken(_ code: String) {
        oAuth2Service.fetchAuthToken(code) {  [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let token):
                self.oAuth2TokenStorage.token = token
                self.fetchProfile()
            case .failure:
                UIBlockingProgressHUD.dismiss()
                self.showError()
            }
        }
    }
    
    private func fetchProfile() {
        profileService.fetchProfile { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let username):
                ProfileImageService.shared.fetchProfileImageURL(username: username) { _ in }
                DispatchQueue.main.async {
                    self.switchToTabBarController()
                }
            case .failure:
                self.showError()
                break
            }
            UIBlockingProgressHUD.dismiss()
        }
    }
}

extension SplashViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showAuthIdentifier {
            guard
                let navigationController = segue.destination as? UINavigationController,
                let viewController = navigationController.viewControllers[0] as? AuthViewController
            else { fatalError("Failed to prepare for \(showAuthIdentifier)") }
            
            viewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}

extension SplashViewController {
    private func showError() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return }
            self.errorAlertController
                .displayAlert(
                    over: self,
                    title: "Что-то пошло не так(",
                    message: "Не удалось войти в систему",
                    actionTitle: "Ок") {
                        self.checkAuth()
                    }
        }
    }
}


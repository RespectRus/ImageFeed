import UIKit

final class AlertViewController {
    
    func showAlert(vc: UIViewController, model: AlertModel) {
        let alertController = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.complection()
        }
        alertController.addAction(action)
        vc.present(alertController, animated: true)
    }
}

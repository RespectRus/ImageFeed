import UIKit

extension DateFormatter {
    var displayFormat: DateFormatter {
        self.dateStyle = .long
        self.timeStyle = .none
        return self
    }
}

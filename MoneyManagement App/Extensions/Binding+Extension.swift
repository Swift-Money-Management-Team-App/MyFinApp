import SwiftUI

extension Binding where Value == String {
    func clearString() {
        self.wrappedValue = ""
    }
}

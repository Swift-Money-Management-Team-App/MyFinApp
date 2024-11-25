import Foundation

extension NumberFormatter {
    
    var formatToCurrency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.currencyCode = "BRL"
        formatter.currencySymbol = "R$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.minimumIntegerDigits = 2
        formatter.maximumIntegerDigits = 13
        formatter.usesGroupingSeparator = true
        return formatter
    }
}

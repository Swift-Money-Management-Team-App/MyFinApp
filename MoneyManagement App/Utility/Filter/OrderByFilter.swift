import Foundation

enum OrderByFilter: String, CaseIterable {
    case AscendingAlphabetical = "A - Z"
    case DescendingAlphabetical = "Z - A"
    case AscendingValue = "Valor Crescente"
    case DescendigValue = "Valor Descrescente"
}

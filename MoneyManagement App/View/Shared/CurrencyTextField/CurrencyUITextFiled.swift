import Foundation
import UIKit
import SwiftUI

/// CurrencyUITextField formata um valor numerico
class CurrencyUITextField: UITextField {
  
  // MARK: Propriedades
  
  /// O valor digitado pelo usuário
  @Binding private var value: Double
  
  /// Formador para formatar um valor decimal
  var formatter: NumberFormatter
  
  /// O valor convertido em decimal
  var decimal: Decimal {
    return textValue.decimal / pow(10, formatter.maximumFractionDigits)
  }
  
  /// Texto digitado pelo usuário
  private var textValue: String {
    return text ?? ""
  }

  /// Converte texto de um Double
  private var doubleValue: Double {
    return (decimal as NSDecimalNumber).doubleValue
  }

  // MARK: Init
  
  /// Criar uma CurrencyUITextField
  /// - Parameters:
  ///   - formatter: Formador para formatar um valor decimal
  ///   - value: O valor digitado pelo usuário
  init(formatter: NumberFormatter, value: Binding<Double>) {
    self.formatter = formatter
    self._value = value
    super.init(frame: .zero)
    setupViews()
  }
  
  /// init(coder:) has not been implemented
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Function
  
  /// Configure a CurrencyUITextField
  private func setupViews() {
    addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    addTarget(self, action: #selector(resetSelection), for: .allTouchEvents)
    keyboardType = .numberPad
    textAlignment = .right
    text = formatter.string(from: value as NSNumber)
    resetSelection()
  }

  /// Formata o valor decimal no formator
  /// - Parameter decimal: Valor decimal a ser formatado
  /// - Returns: a string formatada
  func currency(from decimal: Decimal) -> String {
    return formatter.string(for: decimal) ?? ""
  }

  // MARK: Action
  
  /// Aplica o formatador e reseta a Seleção
  @objc private func editingChanged() {
    text = currency(from: decimal)
    value = doubleValue
    resetSelection()
  }
  
  /// Reseta o cursor para o final do texto
  @objc func resetSelection() {
    selectedTextRange = textRange(from: endOfDocument, to: endOfDocument)
  }
}

extension StringProtocol where Self: RangeReplaceableCollection {

  /// Filtrar dígitos de uma string
  var digits: Self { filter (\.isWholeNumber) }
}

extension String {
  /// Converte uma string em valor decimal
  var decimal: Decimal { Decimal(string: digits) ?? 0 }
}

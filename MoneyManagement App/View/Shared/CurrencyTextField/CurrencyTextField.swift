import SwiftUI
import UIKit

/// CurrencyTextField representa a CurrencyUITextField do UIKit
struct CurrencyTextField: UIViewRepresentable {
  
  typealias UIViewType = CurrencyUITextField
  
  /// CurrencyUITextField formata um valor numerico
  private var currencyField: CurrencyUITextField
  
  /// Fonte da CurrencyUITextField
  private var font: UIFont?
  
  /// ForegroundColor da CurrencyUITextField
  private var foregroundColor: UIColor?
  
  /// Formatador de numero da CurrencyUITextField
  private var numberFormatter: NumberFormatter
  
  /// Cria uma CurrencyTextField Swiftui
  /// - Parameters:
  ///   - numberFormatter: formatador de numero da CurrencyUITextField
  ///   - value: valor a ser fortado pela CurrencyUITextField
  init(numberFormatter: NumberFormatter, value: Binding<Double>) {
    self.numberFormatter = numberFormatter
    currencyField = CurrencyUITextField(formatter: numberFormatter, value: value)
  }
  
  /// Cria a CurrencyUITextField Uikit
  /// - Parameter context: um context
  /// - Returns: uma CurrencyUITextField que formata um valor numerico
  func makeUIView(context: Context) -> CurrencyUITextField {
    currencyField.font = font
    currencyField.textColor = foregroundColor
    currencyField.setContentHuggingPriority(.defaultHigh, for: .vertical)
    currencyField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    return currencyField
  }
  
  /// Atualizada o formatador e texto
  /// - Parameters:
  ///   - uiView: uma CurrencyUITextField
  ///   - context: um context
  func updateUIView(_ uiView: CurrencyUITextField, context: Context) {
    // Atualiza o formatador
    uiView.formatter = numberFormatter
    uiView.text = uiView.currency(from: uiView.decimal)
    uiView.resetSelection()
  }
}

extension CurrencyTextField {
  
  /// Modificar que aplica uma fonte personalizada
  /// - Parameter font: nova fonte da CurrencyTextField
  /// - Returns: a CurrencyTextField com nova fonte
  func font(_ font: UIFont?) -> CurrencyTextField {
    var view = self
    view.font = font
    return view
  }
  
  /// Modificar que aplica uma foregroundColor personalizada
  /// - Parameter color: nova color da CurrencyTextField
  /// - Returns: a CurrencyTextField com nova color
  func foregroundColor(_ color: UIColor?) -> CurrencyTextField {
    var view = self
    view.foregroundColor = color
    return view
  }
  
  /// Modificar que aplica aliamneot do texto
  /// - Parameter textAlignment
  /// - Returns: a CurrencyTextField com nova aliamento
  func alimentText(_ textAlignment: NSTextAlignment) -> CurrencyTextField {
    let view = self
    view.currencyField.textAlignment = textAlignment
    return view
  }
}

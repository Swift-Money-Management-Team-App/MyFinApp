import SwiftUI

struct FinancialInstitueForm: View {
    // WRAPPERS
    @Environment(\.dismiss) var dismiss
    @Binding var bankName: String
    @State var originalName: String
    @State var isShowDiscardChangeAlert: Bool = false
    @State var isShowDeleteAlert: Bool = false
    @State var formState: UserFormState
    
    // PROPS
    let action: () -> Void
    let deleteAction: () -> Void
    
    init(bankName: Binding<String>, originalName: String, formState: UserFormState, action: @escaping () -> Void, deleteAction: @escaping () -> Void = {}) {
        self._bankName = bankName
        self.originalName = originalName
        self.formState = formState
        self.action = action
        self.deleteAction = deleteAction
    }
    
    var body: some View {
        NavigationStack {
            formContent
                .toolbar { toolbarContent }
                .presentationDetents([.height(250)])
                .interactiveDismissDisabled(true)
                .alert(LocalizedStringKey.financialInstituteDiscardAlertTitle.message, isPresented: self.$isShowDiscardChangeAlert) {
                    Button(LocalizedStringKey.financialInstituteDiscardChangesButton.button, role: .destructive) {
                        if formState == .create {
                            discardAllChanges()
                        } else {
                            formState = .read
                            bankName = originalName
                        }
                    }
                        .tint(.blue)
                    Button(LocalizedStringKey.financialInstituteContinueEditingButton.button, role: .cancel) { }
                }
                .alert(isPresented: $isShowDeleteAlert, content: deleteAlert)
        }
    }
}

extension FinancialInstitueForm {
    private var formContent: some View {
        VStack {
            titleView
            fieldsView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
    
    private var titleView: some View {
        Text(LocalizedStringKey.financialInstituteFormTitle.label)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }
    
    private var fieldsView: some View {
        VStack(spacing: 0) {
            bankNameField
            if formState == .read {
                deleteButton
            }
        }
    }
    
    private var bankNameField: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .foregroundStyle(Color("backgroundColorRow"))
                .frame(height: 50)
            
            TextField(text: $bankName, label: {
                Text(LocalizedStringKey.financialInstitutePlaceholder.label)
            })
            .foregroundStyle(formState == .read ? .gray : .black)
            .disabled(formState == .read)
            .padding(.horizontal, 80)
            
            HStack {
                Text(LocalizedStringKey.financialInstituteNameField.label)
                    .padding(.leading)
                Spacer()
                if !bankName.isEmpty && formState != .read {
                    clearButton
                }
            }
        }
    }
    
    private var clearButton: some View {
        Button(action: { clearAllVariables() }) {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.gray)
        }
        .padding(.trailing)
        .transition(.opacity)
    }
    
    private var deleteButton: some View {
        VStack {
            Divider()
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundStyle(Color("backgroundColorRow"))
                    .frame(height: 50)
                Button(LocalizedStringKey.financialInstituteDeleteButton.button, role: .destructive) {
                    isShowDeleteAlert = true
                }
                .padding(.leading)
            }
        }
    }
    
    private var toolbarContent: some ToolbarContent {
        Group {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: { handleCancelButton() }) {
                    Text(formState == .read
                         ? LocalizedStringKey.financialInstituteBackButton.button
                         : LocalizedStringKey.financialInstituteCancelButton.button)
                        .padding(10)
                }
            }
            ToolbarItem(placement: .principal) {
                Text(formState == .create
                     ? LocalizedStringKey.financialInstituteAddTitle.label
                     : formState == .read
                     ? bankName
                     : LocalizedStringKey.financialInstituteEditTitle.label)
                    .multilineTextAlignment(.center)
            }
            ToolbarItem {
                Button(action: { handleSaveOrEditAction() }) {
                    Text(formState == .create
                         ? LocalizedStringKey.financialInstituteAddButton.button
                         : formState == .read
                         ? LocalizedStringKey.financialInstituteEditButton.button
                         : LocalizedStringKey.financialInstituteSaveButton.button)
                        .padding(10)
                }
                .disabled(handleSaveButton())
            }
        }
    }
    
    private func deleteAlert() -> Alert {
        Alert(
            title: Text(String(format: LocalizedStringKey.financialInstituteDeleteAlertTitle.message, bankName)),
            message: Text(LocalizedStringKey.financialInstituteDeleteAlertMessage.message),
            primaryButton: .destructive(Text(LocalizedStringKey.financialInstituteDeleteButton.button)) {
                deleteAction()
                self.dismiss()
            },
            secondaryButton: .cancel(Text(LocalizedStringKey.financialInstituteCancelButton.button))
        )
    }
    
    private func handleSaveButton() -> Bool {
        formState != .read && bankName == originalName
    }
    
    private func handleCancelButton() {
        if formState != .read && bankName != originalName {
            isShowDiscardChangeAlert = true
        } else if formState == .update {
            formState = .read
        } else {
            dismiss()
        }
    }
    
    private func handleSaveOrEditAction() {
        if formState != .read {
            action()
            clearAllVariables()
            self.dismiss()
        } else {
            formState = .update
        }
    }
    
    private func clearAllVariables() {
        bankName = ""
    }
    
    private func discardAllChanges() {
        bankName = originalName
        dismiss()
    }
}

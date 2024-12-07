import SwiftUI

struct UserForm: View {
    
    // WRAPPERS
    @Environment(\.dismiss) var dismiss
    @Binding var name: String
    @State private var originalName: String
    @State private var isShowDiscardChangeAlert: Bool = false
    @State var formState: UserFormState
    
    // PROPS
    let action: () -> Void
    
    init(name: Binding<String>, formState: UserFormState, action: @escaping () -> Void) {
        self._name = name
        self._originalName = State(initialValue: name.wrappedValue)
        self.formState = formState
        self.action = action
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                formTitle
                nameInputField
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
            .toolbar { toolbarContent }
        }
        .presentationDetents([.height(200)])
        .interactiveDismissDisabled(true)
        .alert(LocalizedStringKey.userFormDiscardAlertTitle.label, isPresented: $isShowDiscardChangeAlert) {
            discardAlertActions
        }
    }
}

extension UserForm {
    
    // MARK: - Subviews
    
    private var formTitle: some View {
        Text(LocalizedStringKey.userFormTitle.label)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }
    
    private var nameInputField: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .foregroundStyle(Color("backgroundColorRow"))
                .frame(height: 50)
            
            TextField(text: $name) {
                Text(name.isEmpty ? LocalizedStringKey.userFormNamePlaceholder.label : name)
            }
            .foregroundStyle(formState == .read ? .gray : .black)
            .disabled(formState == .read)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 80)
            
            HStack {
                Text(LocalizedStringKey.userFormNameField.label)
                    .padding(.leading)
                Spacer()
                if !name.isEmpty && formState != .read {
                    Button(action: { clearAllVariables() }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray)
                    }
                    .padding(.trailing)
                    .transition(.opacity)
                }
            }
        }
    }
    
    private var toolbarContent: some ToolbarContent {
        Group {
            if formState != .create {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { handleCancelButton() }) {
                        Text(cancelButtonTitle).padding(10)
                    }
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text(formTitleText)
                    .multilineTextAlignment(.center)
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button(action: { handleEditButton() }) {
                    Text(editButtonTitle).padding(10)
                }
                .disabled(handleSaveButton())
            }
        }
    }

    
    private var discardAlertActions: some View {
        Group {
            Button(LocalizedStringKey.userFormDiscardButton.button, role: .destructive) {
                discardAllChanges()
            }
            Button(LocalizedStringKey.userFormContinueEditingButton.button, role: .cancel) {}
                .foregroundStyle(.blue)
        }
    }
    
    // MARK: - Computed Properties
    
    private var cancelButtonTitle: String {
        formState == .read
        ? LocalizedStringKey.userFormBackButton.button
        : LocalizedStringKey.userFormCancelButton.button
    }
    
    private var formTitleText: String {
        switch formState {
        case .create:
            return LocalizedStringKey.userFormCreateTitle.label
        case .read:
            return LocalizedStringKey.userFormReadTitle.label
        case .update:
            return LocalizedStringKey.userFormEditTitle.label
        }
    }
    
    private var editButtonTitle: String {
        switch formState {
        case .create:
            return LocalizedStringKey.userFormAddButton.button
        case .read:
            return LocalizedStringKey.userFormEditButton.button
        case .update:
            return LocalizedStringKey.userFormSaveButton.button
        }
    }
    
    // MARK: - Logic
    
    private func checkIfNameUpdate() -> Bool {
        name == originalName
    }
    
    private func handleSaveButton() -> Bool {
        formState == .update && checkIfNameUpdate()
    }
    
    private func handleCancelButton() {
        if formState != .read && !checkIfNameUpdate() {
            isShowDiscardChangeAlert = true
        } else if formState == .update {
            formState = .read
        } else {
            dismiss()
        }
    }
    
    private func handleEditButton() {
        if formState == .read {
            formState = .update
        } else {
            action()
            dismiss()
        }
    }
    
    private func clearAllVariables() {
        name = ""
    }
    
    private func discardAllChanges() {
        formState = .read
        clearAllVariables()
        name = originalName
    }
}

enum UserFormState {
    case create
    case read
    case update
}

#Preview {
    UserForm(name: .constant("Filipe"), formState: .update, action: { print("User Form Button Debug") })
}

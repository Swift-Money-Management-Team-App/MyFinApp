import SwiftData

extension EarningCategoryFormView {
    
    func checkForChangesBeforeDismiss() {
        if name != initialName || emoji != initialEmoji {
            showCancelEditAlert = true
        } else {
            isEditing = false
            dismiss()
        }
    }
    
    func resetChanges() {
        name = initialName
        emoji = initialEmoji
        dismiss()
    }
    
    func saveChanges() {
        repeat {
            earningCategory!.name = name
            earningCategory!.emoji = emoji
        } while self.save()
        isEditing = false
    }
    
    func deleteMethod() {
        modelContext.delete(earningCategory!)
        dismiss()
    }
    
    func save() -> Bool {
        do {
            try modelContext.save()
            return false
        } catch {
            print("Deu ruim 2")
            return true
        }
    }
    
}

extension ExpenseCategoryFormView {
    
    func checkForChangesBeforeDismiss() {
        if name != initialName || emoji != initialEmoji {
            showCancelEditAlert = true
        } else {
            isEditing = false
            dismiss()
        }
    }
    
    func resetChanges() {
        name = initialName
        emoji = initialEmoji
        dismiss()
    }
    
    func saveChanges() {
        repeat {
            expenseCategory!.name = name
            expenseCategory!.emoji = emoji
        } while self.save()
        isEditing = false
    }
    
    func deleteMethod() {
        modelContext.delete(expenseCategory!)
        dismiss()
    }
    
    func save() -> Bool {
        do {
            try modelContext.save()
            return false
        } catch {
            print("Deu ruim 2")
            return true
        }
    }
    
}

extension CategoryFormCreateView {
    
    func appendCategory() {
        if self.type == .earning {
            modelContext.insert(EarningCategory(idUser: user.first!.id, emoji: self.emoji, name: self.name))
        } else {
            modelContext.insert(ExpenseCategory(idUser: user.first!.id, emoji: self.emoji, name: self.name))
        }   
    }
    
}

extension MethodFormView {
    
    func checkForChangesBeforeDismiss() {
        if name != initialName || emoji != initialEmoji {
            showCancelEditAlert = true
        } else {
            isEditing = false
            dismiss()
        }
    }
    
    func resetChanges() {
        name = initialName
        emoji = initialEmoji
        dismiss()
    }
    
    func saveChanges() {
        repeat {
            method!.name = name
            method!.emoji = emoji
        } while self.save()
        isEditing = false
    }
    
    func deleteMethod() {
        modelContext.delete(method!)
        dismiss()
    }
    
    func save() -> Bool {
        do {
            try modelContext.save()
            return false
        } catch {
            print("Deu ruim 2")
            return true
        }
    }
    
}

extension MethodFormCreateView {
    
    func appendMethod() {
        modelContext.insert(Method(idUser: user.first!.id, emoji: self.emoji, name: self.name))
    }
    
}

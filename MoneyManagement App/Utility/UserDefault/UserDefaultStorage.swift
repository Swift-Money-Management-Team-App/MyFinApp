import Foundation

class Storage {
    
    static let share = Storage()
    let userDefault: UserDefaults
    
    @UserDefault var firstLaunchApplication: Bool
    @UserDefault var hiddenValues: Bool
    
    init(userDefault: UserDefaults  = .standard) {
        self.userDefault = userDefault
        self._firstLaunchApplication = .init(keys: .firstLaunchApplication, default: true, userDefault)
        self._hiddenValues = .init(keys: .hiddenValues, default: true, userDefault)
    }
}

@propertyWrapper
struct UserDefault<T: PropertyListValue> {
    let userDefault: UserDefaults
    let keys: Keys
    let `default`: T
    
    init(keys: Keys, `default`: T, _ userDefault: UserDefaults) {
        self.keys = keys
        self.default = `default`
        self.userDefault = userDefault
    }
    
    var wrappedValue: T {
        get { userDefault.value(forKey: keys.rawValue) as? T ?? `default` }
        set { userDefault.set(newValue, forKey: keys.rawValue)}
    }
}

extension UserDefaults {
    
    func setCodableObject<T: Codable>(_ data: T?, forKey defaultName: String) {
        let encoded = try? JSONEncoder().encode(data)
        set(encoded, forKey: defaultName)
    }
    
    func codableObject<T: Codable>(dataType: T.Type, key: String) -> T? {
        guard let userDefaultData = data(forKey: key) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: userDefaultData)
    }
    
}

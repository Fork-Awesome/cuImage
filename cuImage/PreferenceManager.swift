//
//  PreferenceManager.swift
//  cuImage
//
//  Created by HuLizhen on 06/01/2017.
//  Copyright © 2017 HuLizhen. All rights reserved.
//

import Cocoa

/// A convenient global handler to access preferences with subscripts.
let preferences = PreferenceManager.shared

final class PreferenceManager: NSObject {
    static let shared = PreferenceManager()
    fileprivate let defaults = UserDefaults.standard
    private let shortcutManager = ShortcutManager.shared
    
    private override init() {
        super.init()
        
        registerDefaultPreferences()
    }
    
    private func registerDefaultPreferences() {
        // Convert dictionary of type [PreferenceKey: Any] to [String: Any].
        let defaultValues: [String: Any] = defaultPreferences.reduce([:]) {
            var dictionary = $0
            dictionary[$1.key.rawValue] = $1.value
            return dictionary
        }
        defaults.register(defaults: defaultValues)
    }
}

// Subscripts
extension PreferenceManager {
    subscript(key: PreferenceKey<Any>) -> Any? {
        get { return defaults.object(forKey: key.rawValue) }
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<URL>) -> URL {
        get { return defaults.url(forKey: key.rawValue) ?? URL(string: "")!}
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<[Any]>) -> [Any] {
        get { return defaults.array(forKey: key.rawValue) ?? []}
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<[String: Any]>) -> [String: Any] {
        get { return defaults.dictionary(forKey: key.rawValue) ?? [:] }
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<String>) -> String {
        get { return defaults.string(forKey: key.rawValue) ?? ""}
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<[String]>) -> [String] {
        get { return defaults.stringArray(forKey: key.rawValue) ?? []}
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<Data>) -> Data {
        get { return defaults.data(forKey: key.rawValue) ?? Data()}
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<Bool>) -> Bool {
        get { return defaults.bool(forKey: key.rawValue) }
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<Int>) -> Int {
        get { return defaults.integer(forKey: key.rawValue) }
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<Float>) -> Float {
        get { return defaults.float(forKey: key.rawValue) }
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<Double>) -> Double {
        get { return defaults.double(forKey: key.rawValue) }
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
}

class PreferenceKeys: RawRepresentable, Hashable {
    let rawValue: String
    
    required init!(rawValue: String) {
        self.rawValue = rawValue
    }
    
    convenience init(_ key: String) {
        self.init(rawValue: key)
    }
    
    var hashValue: Int {
        return rawValue.hashValue
    }
}

final class PreferenceKey<T>: PreferenceKeys { }

/// The collection of all preference keys.
extension PreferenceKeys {
    // General
    static let launchAtLogin = PreferenceKey<Bool>("launchAtLogin")
    static let keepWindowsOnTop = PreferenceKey<Bool>("keepWindowsOnTop")
    
    // Hosts
    static let currentHost = PreferenceKey<String>("currentHost")
    static let qiniuHostInfo = PreferenceKey<[String: Any]>("qiniuHostInfo")
}


// The collection of all default preference, except shortcuts managed by MASShortcut.
private let defaultPreferences: [PreferenceKeys: Any] = [
    // General
    .launchAtLogin: false,
    .keepWindowsOnTop: true,
    
    // Hosts
    .currentHost: SupportedHost.qiniu.rawValue,
    .qiniuHostInfo: QiniuHostInfo().dictionary(),
]

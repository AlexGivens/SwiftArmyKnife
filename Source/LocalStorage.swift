//
//  LocalStorage.swift
//
//  Copyright (c) 2017 Alex Givens (http://alexgivens.com/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

public class LocalStorage {
    
    public static var suiteName: String {
        set {
            _suiteName = newValue
        }
        get {
            assert(_suiteName != nil, "LocalStorage requires a suiteName be specifed to store and manage UserDefaults.")
            return _suiteName!
        }
    }
    
    private static var _suiteName: String?
    
    public static func saveObject(_ object: Any, forKey key: String) {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: object)
        UserDefaults(suiteName: suiteName)?.set(encodedData, forKey: key)
    }
    
    public static func loadObject<T>(forKey key: String) -> T? {
        if
            let decodedData = UserDefaults(suiteName: suiteName)?.data(forKey: key),
            let object = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? T
        {
            return object
        }
        return nil
    }
    
    public static func deleteObject(forKey key: String) {
        UserDefaults(suiteName: suiteName)?.removeObject(forKey: key)
    }
    
}

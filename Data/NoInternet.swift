//
//  NoInternet.swift
//  Avito_Intern
//
//  Created by siuzanna on 5/9/21.
//

import UIKit
import Network


class NetworkErrorViewController: UIViewController {
    static var identifier = "NetworkErrorViewController"

    let someImageView: UIImageView = {
        let theImageView = UIImageView()
        theImageView.image = UIImage(named: "NoConnection.png")
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        return theImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        view.addSubview(someImageView)
        someImageView.fillSuperView()
    }
     
}


final class Cache<Key: Hashable, Value> {
    private let wrapped = NSCache<WrappedKey, Entry>()
    private let dateProvider: () -> Date
        private let entryLifetime: TimeInterval

        init(dateProvider: @escaping () -> Date = Date.init,
             entryLifetime: TimeInterval = 1 * 60 * 60) {
            self.dateProvider = dateProvider
            self.entryLifetime = entryLifetime
        }
    
    func insert(_ value: Value, forKey key: Key) {
        let date = dateProvider().addingTimeInterval(entryLifetime)
        let entry = Entry(value: value, expirationDate: date)
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }

    func value(forKey key: Key) -> Value? {
        guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
            return nil
        }

        guard dateProvider() < entry.expirationDate else {
            // Discard values that have expired
            removeValue(forKey: key)
            return nil
        }

        return entry.value
    }

    func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }
}


private extension Cache {
    final class WrappedKey: NSObject {
        let key: Key

        init(_ key: Key) { self.key = key }

        override var hash: Int { return key.hashValue }

        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }

            return value.key == key
        }
    }

    final class Entry {
        let value: Value
        let expirationDate: Date

        init(value: Value, expirationDate: Date) {
            self.value = value
            self.expirationDate = expirationDate
        }
    }

    subscript(key: Key) -> Value? {
        get { return value(forKey: key) }
        set {
            guard let value = newValue else {
                // If nil was assigned using our subscript,
                // then we remove any value for that key:
                removeValue(forKey: key)
                return
            }

            insert(value, forKey: key)
        }
    }
}

//
//  Network.swift
//  Data
//
//  Created by siuzanna on 6/9/21.
//

import Foundation

extension ViewController{
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
                    self.reachability.whenReachable = { reachability in
                        if reachability.connection == .wifi {
                            print("Reachable via WiFi")
                        } else {
                            print("Reachable via Cellular")
                        }
                        self.view.window?.rootViewController?.dismiss(animated: true)
                    }
                    self.reachability.whenUnreachable = { _ in
                        print("Not reachable")
                        
                        let vc = NetworkErrorViewController()
                        vc.modalPresentationStyle = .automatic
                        self.present(vc, animated: true, completion: nil)
                    }
                    
                    do {
                        try self.reachability.startNotifier()
                    } catch {
                        print("Unable to start notifier")
                    }
                }
    }
}

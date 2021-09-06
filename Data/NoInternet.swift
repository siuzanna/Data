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



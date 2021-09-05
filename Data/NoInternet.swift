//
//  NoInternet.swift
//  Avito_Intern
//
//  Created by siuzanna on 5/9/21.
//

import UIKit

class NetworkErrorViewController: UIViewController {
    
    let someImageView: UIImageView = {
        let theImageView = UIImageView()
        theImageView.image = UIImage(named: "NoConnection.png")
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        return theImageView
    }()
    
    static var identifier = "NetworkErrorViewController"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        view.addSubview(someImageView)
        someImageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)

    }
    

    override func viewWillDisappear(_ animated: Bool) {
        
    }
   

}

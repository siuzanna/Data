//
//  ViewController.swift
//  Data
//
//  Created by siuzanna on 5/9/21.
//

import UIKit

class ViewController: UIViewController {
    
    weak var collectionView: UICollectionView!
    let reachability = try! Reachability()

    override func loadView() {
        super.loadView()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.view.addSubview(collectionView)
        collectionView.fillSuperView()
        self.collectionView = collectionView
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        getMethod {
            self.collectionView.reloadData()
        }
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = .lightGray
        
    }
    
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
    
    deinit {
            reachability.stopNotifier()
    }
}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as! Cell

        //sorting employees by alphabet
        let data = newsPosts?.company.employees.sorted { $0.name < $1.name }[indexPath.item]
        cell.phoneNumber?.text = data?.phone_number
        cell.name?.text = data?.name
        
        var n = ""
    
        if let ma = data?.skills {
        for i in ma {
                n += "\n    •\(i)"
            }
        }
        
        cell.skills?.text = "Skills:\(n)"
        
        print(n)
        
        //styling the cell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 25
        cell.layer.shadowOffset = CGSizeMake(5, 5)
        cell.layer.shadowOpacity = 0.4
        cell.layer.shadowRadius = 10
        cell.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        
        
        func CGSizeMake(_ width: CGFloat, _ height: CGFloat) -> CGSize {
            return CGSize(width: width, height: .zero)
                }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return newsPosts?.company.employees.count ?? 0
    }
}

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    // resizes whe device rotates
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    //padding and size
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: .zero, bottom: 30, right: .zero)
    }
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 30) / 1.2
        return CGSize(width: size, height: 150)
    }
 
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

}

//
//  ViewController.swift
//  Data
//
//  Created by siuzanna on 5/9/21.
//
import TTGTags
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
        self.collectionView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
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
        if let phone = data?.phone_number { cell.phoneNumber?.text = "Phone number: \(phone)" }
        cell.name?.text = data?.name
        
        if let data = data?.skills {
            cell.collectionView.removeAllTags()
            for text in data {
                let content = TTGTextTagStringContent.init(text: text)
                content.textColor = UIColor.white
                content.textFont = UIFont.boldSystemFont(ofSize: 10)
                
                let normalStyle = TTGTextTagStyle.init()
                normalStyle.backgroundColor = UIColor.systemGreen
                normalStyle.extraSpace = CGSize.init(width: 5, height: 3)
                
                let selectedStyle = TTGTextTagStyle.init()
                selectedStyle.backgroundColor = UIColor.orange
                selectedStyle.extraSpace = CGSize.init(width: 5, height: 3)
                
                let tag = TTGTextTag.init()
                tag.content = content
                tag.style = normalStyle
                tag.selectedStyle = selectedStyle
                
                cell.collectionView.addTag(tag)
            }
        }
        cell.collectionView.reload()
        
        //styling the cell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 25
        cell.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.layer.shadowOpacity = 0.4
        cell.layer.shadowRadius = 10
        cell.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        return cell
    }
    
    // cells count
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return newsPosts?.company.employees.count ?? 0
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {

    //resizes when device rotates
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    //padding
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: .zero, bottom: 30, right: .zero)
    }

    //width & height
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 30) / 1.2
        return CGSize(width: size, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

}




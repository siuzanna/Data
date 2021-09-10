//
//  VC-extension-UICollectionViewDelegateDataSource.swift
//  Data
//
//  Created by siuzanna on 8/9/21.
//
import TTGTags
import UIKit
import SnapKit



extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //sorting employees by alphabet
        let data = DataToDisplay?.company.employees.sorted { $0.name < $1.name }[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as! Cell
        //styling the cell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 25
        cell.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.layer.shadowOpacity = 0.4
        cell.layer.shadowRadius = 10
        cell.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        
        //phone number
        if let phone = data?.phone_number { cell.phoneNumber.text = "Phone number: \(phone)" }
        
        //names
        if let name = data?.name { cell.name.text = name }
       
        // skills
        if let skills = data?.skills {
            cell.collectionView.removeAllTags()
            for skill in skills {
                let content = TTGTextTagStringContent.init(text: skill)
                content.textColor = UIColor.white
                content.textFont = UIFont.boldSystemFont(ofSize: 14)
                
                let normalStyle = TTGTextTagStyle.init()
                normalStyle.backgroundColor = UIColor.systemGreen
                normalStyle.extraSpace = CGSize.init(width: 5, height: 3)
                
                let selectedStyle = TTGTextTagStyle.init()
                selectedStyle.backgroundColor = UIColor.purple
                selectedStyle.extraSpace = CGSize.init(width: 5, height: 3)
                
                let tag = TTGTextTag.init()
                tag.content = content
                tag.style = normalStyle
                tag.selectedStyle = selectedStyle
                
                //each skill we modifying using TTGTags and than addind them to collectionView
                cell.collectionView.addTag(tag)
            }
        }
        cell.collectionView.reload()
        return cell
    }
    
    // cells count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataToDisplay?.company.employees.count ?? 0
    }
}


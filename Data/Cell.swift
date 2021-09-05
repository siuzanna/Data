import UIKit
import TTGTags

class Cell: UICollectionViewCell {
    static var identifier: String = "Cell"

    weak var phoneNumber: UILabel!
    weak var name: UILabel!
    let collectionView = TTGTextTagCollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = #colorLiteral(red: 0.3568639755, green: 0.2908577919, blue: 0.7719110847, alpha: 1)
        contentView.layer.cornerRadius = 20
        
        let phoneNumber = UILabel(frame: .zero)
        let name = UILabel(frame: .zero)
        self.contentView.addSubview(phoneNumber)
        self.contentView.addSubview(name)
        self.contentView.addSubview(collectionView)
        
        //names
        name.textAlignment = .left
        name.font = UIFont.boldSystemFont(ofSize: 20.0)
        name.textColor = .white
        name.anchor(top: contentView.topAnchor,
                    leading: contentView.leadingAnchor,
                    bottom: phoneNumber.topAnchor,
                    trailing: contentView.trailingAnchor,
                    padding: .init(top: 40, left: 30, bottom: -2, right: -30), size: .init(width: contentView.frame.width-60, height: 16))
        
        //phone numbers
        phoneNumber.textColor = .white
        phoneNumber.font = UIFont.italicSystemFont(ofSize: 10.0)
        phoneNumber.anchor(top: name.bottomAnchor,
                                   leading: contentView.leadingAnchor,
                                   bottom: collectionView.topAnchor,
                                   trailing: contentView.trailingAnchor,
                                   padding: .init(top: 0, left: 30, bottom: -20, right: -30), size: .init(width: contentView.frame.width-60, height: 14))
        
        //skills
        collectionView.alignment = .fillByExpandingWidth
        collectionView.anchor(top: phoneNumber.bottomAnchor,
                           leading: contentView.leadingAnchor,
                           bottom: contentView.bottomAnchor,
                           trailing: contentView.trailingAnchor,
                           padding: .init(top: 0, left: 30, bottom: -10, right: -30))
        
        
        
        self.phoneNumber = phoneNumber
        self.name = name
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

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
        name.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.bottom.equalTo(phoneNumber.snp.top)
            make.trailing.leading.equalToSuperview().offset(30)
            make.height.equalTo(20)
        }
        
        //phone numbers
        phoneNumber.textColor = .white
        phoneNumber.font = UIFont.italicSystemFont(ofSize: 10.0)
        phoneNumber.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom)
            make.bottom.equalTo(collectionView.snp.top).offset(-10)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(20)
        }
        
        //skills
        collectionView.alignment = .fillByExpandingWidthExceptLastLine
        collectionView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        self.phoneNumber = phoneNumber
        self.name = name
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


import UIKit

class Cell: UICollectionViewCell {

    
    static var identifier: String = "Cell"

    weak var phoneNumber: UILabel!
    weak var name: UILabel!
    weak var skills: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let phoneNumber = UILabel(frame: .zero)
        let name = UILabel(frame: .zero)
        let skills = UITextView(frame: .zero)
        
        self.contentView.addSubview(phoneNumber)
        self.contentView.addSubview(name)
        self.contentView.addSubview(skills)

        name.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 30, left: 30, bottom: 0, right: 0), size: .zero)
        phoneNumber.anchor(top: topAnchor, leading: name.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 30, left: 30, bottom: 0, right: -30), size: .zero)
        phoneNumber.textColor = .systemGreen
        skills.anchor(top: name.bottomAnchor, leading: name.leadingAnchor, bottom: nil, trailing: phoneNumber.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .zero)
//        skills.backgroundColor = .systemPink
        skills.textColor = .gray
        skills.isEditable = false
        skills.isScrollEnabled = false
        skills.font =  UIFont.systemFont(ofSize: 15)

        
        
        self.phoneNumber = phoneNumber
        self.name = name
        self.skills = skills

        
        self.reset()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }

    func reset() {
        self.phoneNumber.textAlignment = .center
    }
}

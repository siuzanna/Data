
import UIKit
import Network
import SnapKit


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
        someImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
     
}

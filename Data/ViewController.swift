import UIKit
import TTGTags
import Network
import SnapKit

class ViewController: UIViewController {
    
    let reachability = try! Reachability()
    
    weak var collectionView: UICollectionView!
    
    var screenTitle: UILabel = {
        let label = UILabel()
        label.text = "👩🏻‍💻 Employees"
        label.textColor = UIColor.systemGreen
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont(name: "Helvetica-Bold", size: 27)
        return label
    }()
    
    var viewTitle = UIView()
    
    
    override func loadView() {
        super.loadView()

        //check internet conection before fetching the data
        monitorNetwork()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.view.addSubview(collectionView)
        self.view.addSubview(viewTitle)
        
        viewTitle.addSubview(screenTitle)
        viewTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        screenTitle.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(viewTitle.snp.bottom)
            make.bottom.trailing.leading.equalToSuperview()
        }

        self.collectionView = collectionView

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        monitorNetwork()
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
    
    override func viewDidAppear(_ animated: Bool) {
        getMethod {
            self.collectionView.reloadData()
        }
    }
    
    //monitor network
    func monitorNetwork() {
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

                //showing vc which stands for network conection
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




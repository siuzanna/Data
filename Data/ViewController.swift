import UIKit
import TTGTags
import Network
import SnapKit

class ViewController: UIViewController {

    private let networkService = NetworkService()
    
    let reachability = try! Reachability()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        return collectionView
    }()
    
    lazy var screenTitle: UILabel = {
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
        
        self.view.addSubview(collectionView)
        self.view.addSubview(viewTitle)
        
        setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        monitorNetwork()
        getPosts()
    }
    
    private func getPosts() {
        
        networkService.sendRequest(
            urlRequest: MainController.getAllPosts.getURLRequest(),
            successModel: Welcome.self
        ) { [weak self] response in
            guard let self = self else {return}
            switch response {
            case .success(let model):
                dump(model)
                
                newsPosts = model
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .badRequest(let model):
                dump(model)
            case .failure(let message):
                print(message)
            }
        }
    }
    
    deinit {
        reachability.stopNotifier()
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
    
    func setupConstraints() {
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
    }
}



extension Encodable {
    func toData() -> Data {
        (try? JSONEncoder().encode(self)) ?? Data()
    }
}

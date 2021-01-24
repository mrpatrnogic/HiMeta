//
//  GameListViewController.swift
//  HiMeta
//
//  Created by Marcio Romero on 1/18/21.
//

import UIKit
import IGListKit
import RxSwift
import RxCocoa

final class GameListViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = MetafyStyle.font.h2SemiBold
            titleLabel.textColor = .white
        }
    }
    @IBOutlet private weak var searchTextField: UITextField! {
        didSet {
            searchTextField.backgroundColor = MetafyStyle.color.background
            searchTextField.autocorrectionType = .no
            searchTextField.textColor = .white
            searchTextField.tintColor = MetafyStyle.color.metafy
            searchTextField.layer.cornerRadius = 10.0
            let searchIcon = UIImageView()
            searchIcon.tintColor = MetafyStyle.color.metafy
            searchIcon.image = MetafyIconCatalog.search.make().withRenderingMode(.alwaysTemplate)
            searchTextField.leftView = searchIcon
            searchTextField.leftViewMode = .always
            let placeholderAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: MetafyStyle.color.stone]
            searchTextField.attributedPlaceholder = NSAttributedString(string: "What´s your game?",
                                                                       attributes: placeholderAttributes)
        }
    }
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.color = .gray
            activityIndicator.hidesWhenStopped = true
        }
    }
    @IBOutlet private weak var collection: UICollectionView! {
        didSet {
            collection.backgroundColor = .black
        }
    }
    static let title = "Pick your poison"
    private let presenter: GameListPresenterProtocol
    private let dataSource = GameListDataSource()
    private let disposeBag = DisposeBag()
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    init(presenter: GameListPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: GameListViewController.self),
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpCollectionView()
        bind()
        presenter.fetchGames(query: "")
    }
}

private extension GameListViewController {
    func setUpView() {
        titleLabel.text = GameListViewController.title
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .black
    }
    
    func setUpCollectionView() {
        adapter.collectionView = collection
        adapter.dataSource = dataSource
        adapter.scrollViewDelegate = self
        dataSource.delegate = presenter
    }
    
    func bind() {
        presenter
            .onUIEvent
            .subscribe(onNext: { [weak self] event in
                switch event {
                case .reloadData:
                    self?.adapter.reloadData()
                case .showLoader(let show):
                    self?.showLoader(show)
                case .showError(let error):
                    break
                }
            }).disposed(by: disposeBag)
        
        searchTextField.rx
            .text
            .throttle(RxTimeInterval.milliseconds(750), scheduler: MainScheduler.instance)
            .subscribe(onNext:{ [weak self] (query) in
                guard let query = query else { return }
                self?.presenter.fetchGames(query: query)
            })
            .disposed(by: disposeBag)

    }
    
    func showLoader(_ show: Bool) {
        show ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}

extension GameListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let endPoint = scrollView.contentOffset.y + scrollView.frame.size.height
        if endPoint >= 0.8 * scrollView.contentSize.height {
            presenter.fetchMoreItems()
        }
    }
}

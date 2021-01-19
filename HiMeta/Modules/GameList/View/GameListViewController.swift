//
//  GameListViewController.swift
//  HiMeta
//
//  Created by Marcio Romero on 1/18/21.
//

import UIKit
import IGListKit
import RxSwift

final class GameListViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = MetafyStyle.font.h2SemiBold
            titleLabel.textColor = .white
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
                    break
                case .showError(let error):
                    break
                }
            }).disposed(by: disposeBag)
    }
}

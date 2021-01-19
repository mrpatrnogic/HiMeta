//
//  GameListPresenterTests.swift
//  HiMetaTests
//
//  Created by Marcio Romero on 1/19/21.
//

import XCTest
import RxSwift
import RxRelay
import RxTest
import RxBlocking
@testable import HiMeta

class GameListPresenterTests: XCTestCase {
    private typealias SUTest = (presenter: GameListPresenterProtocol,
                                interactor: InteractorSpy,
                                router: RouterSpy)

    private var sut: SUTest!
    private var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        let router = RouterSpy()
        let interactor = InteractorSpy()
        let presenter = GameListPresenter(interactor: interactor, router: router)
        sut = (presenter: presenter, interactor: interactor, router: router)
    }
    
    func test_presentGameList() {
        let presenter = sut.presenter
        let router = sut.router
        router.navigationCount = 0
        
        presenter.presentGameList()
        
        XCTAssertEqual(router.navigationCount, 1)
    }
    
    func test_data() {
        let presenter = sut.presenter
        let interactor = sut.interactor
        
        let result: GameListSearchResult? = presenter.data.first as? GameListSearchResult
        
        XCTAssert(result === interactor.searchResult)
    }
    
    func test_fetchGames() {
        let presenter = sut.presenter
        let interactor = sut.interactor
        let resultExpectation = expectation(description: "fetch games success expectation")
        var didReloadData = false
        interactor.fetchCount = 0
        
        presenter.onUIEvent.subscribe(onNext: { (event) in
            switch event {
            case .reloadData:
                didReloadData = true
                resultExpectation.fulfill()
            default: break
            }
        }).disposed(by: disposeBag)
        presenter.fetchGames(query: "metafy")
        
        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssert(didReloadData)
        XCTAssertEqual(interactor.fetchCount, 1)
    }

    private class InteractorSpy: GameListInteractorProtocol {
        var fetchCount = 0
        var searchResult: GameListSearchResult? = GameListSearchResult(JSON: [:])!
        
        func fetchGames(query: String) -> Completable {
            fetchCount += 1
            return .empty()
        }
    }
    
    private class RouterSpy: GameListRouterProtocol {
        var navigationCount: Int = 0
        func showGameList(with presenter: GameListPresenterProtocol) {
            navigationCount += 1
        }
    }
    
    private class SectionSpy: GameListActionHandler {
        var onActionSubject = PublishRelay<GameListUserAction>()
        var onAction: Observable<GameListUserAction> {
            onActionSubject.asObservable()
        }
        var disposeBag: DisposeBag = DisposeBag()
    }
}

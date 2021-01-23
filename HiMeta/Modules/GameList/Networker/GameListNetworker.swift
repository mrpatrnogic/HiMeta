//
//  GameListNetworker.swift
//  HiMeta
//
//  Created by Marcio Romero on 1/18/21.
//

import Foundation
import RxSwift

struct GameListRequestParams: Codable {
    var query: String?
    var offset: Int?
    var limit: Int?
    var filters: String?
    
    enum CodingKeys: String, CodingKey {
            case query = "q"
            case offset
            case limit
            case filters
        }
}

struct NetworkError: Error {}

protocol GameListNetworkerProtocol {
    func fetchGames(query: String, offset: Int, limit: Int, filters: String) -> Single<[String: Any]>
}

final class GameListNetworker: GameListNetworkerProtocol {
    func fetchGames(query: String,
                    offset: Int,
                    limit: Int,
                    filters: String) -> Single<[String: Any]> {
        return Single<[String: Any]>.create { [weak self] single in
            if let request = self?.getGameListRequest(query: query,
                                                   offset: offset,
                                                   limit: limit,
                                                   filters: filters) {
                let session = URLSession.shared
                let task = session.dataTask(with: request,
                                            completionHandler: {data, response, error -> Void in
                    DispatchQueue.main.async {
                        if let data = data,
                           let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                            single(.success(json))
                        } else {
                            single(.failure(NetworkError()))
                        }
                    }
                })
                task.resume()
            } else {
                single(.failure(NetworkError()))
            }
            return Disposables.create()
        }
    }
}

private extension GameListNetworker {
    func getGameListRequest(query: String,
                            offset: Int,
                            limit: Int,
                            filters: String) ->  URLRequest? {
        print("SEARCH QUERY: \(query)")
        let urlString: String = "https://search.metafy.gg//indexes/games/search"
        let apiKey: String = "743f623717fa650ac58dc5b6a65da4d87320bc6cd6fc8e3ad84d1bd5e4c66c35"
        guard let url = URL(string: urlString) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(apiKey, forHTTPHeaderField: "x-meili-api-key")
        let params = GameListRequestParams(query: query,
                                           offset: offset,
                                           limit: limit,
                                           filters: filters)
        let jsonData = try? JSONEncoder().encode(params)
        request.httpBody = jsonData
        
        return request
    }
}

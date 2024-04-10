//
//  NetworkManager.swift
//  SomeCoin
//
//  Created by CEMRE YARDIM on 7.04.2024.
//

import Foundation
//import Moya
//import RxSwift
import Combine

struct CoinNetworkManager {
  
  static let shared = CoinNetworkManager()
  
  private let session: URLSession
  private let decoder: JSONDecoder
//  private let provider = MoyaProvider<CoinService>()
  
  private init() {
    decoder = JSONDecoder()
    session = URLSession.shared
  }
  
  public func performRequest(urlRequest: URLRequest) -> AnyPublisher<Data, Error> {
    return session.dataTaskPublisher(for: urlRequest)
      .tryMap { data, response -> Data in
        guard let httpResponse = response as? HTTPURLResponse else {
          throw HTTPError.invalidResponse
        }
        guard (200 ..< 300).contains(httpResponse.statusCode) else {
          throw HTTPError.invalidResponse
        }
        return data
      }.eraseToAnyPublisher()
  }
  
  public func fetchCoinPrice(params: CoinModel) -> AnyPublisher<CoinModel, Error> {
    let endpoint = CoinService.fetchCoinPrice(params: params)
    return performRequest(urlRequest: endpoint.makeURLRequest(params: params))
      .decode(type: CoinModel.self, decoder: decoder)
      .eraseToAnyPublisher()
  }
}

public enum HTTPError: Equatable {
    case statusCode(Int)
    case invalidResponse
}

extension HTTPError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return NSLocalizedString("Error: 401", comment: "401")
        case .statusCode(let int):
            return String(int)
        }
    }
}

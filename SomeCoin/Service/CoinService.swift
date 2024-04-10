//
//  CoinService.swift
//  SomeCoin
//
//  Created by CEMRE YARDIM on 7.04.2024.
//
//
import Foundation
//import Moya

struct Const {
  static let baseURL = "https://rest.coinapi.io/v1/exchangerate/"
  static let apiKey = "YOUR_API_KEY_HERE"
}

enum CoinService {
  case fetchCoinPrice(params: CoinModel)
}

extension CoinService {
  public func makeURL(_ params: CoinModel) -> URL {
    let urlString = baseURL + path
    print(urlString)
    guard let url = URL(string: urlString) else {
      fatalError("Failed to create URL for: \(urlString)")
    }
    return url
  }
  
  public func makeURLRequest(params: CoinModel) -> URLRequest {
    var request = URLRequest(url: makeURL(params))
    request.httpMethod = method
    request.allHTTPHeaderFields = headers
    return request
  }
}

extension CoinService: ServiceCompliant {
  var baseURL: String {
    switch self {
    case .fetchCoinPrice:
      return Const.baseURL
    }
  }
  
  var path: String {
    switch self {
    case .fetchCoinPrice(let params):
      return "\(params.name ?? "")/USD/apikey-\(Const.apiKey)"
    }
  }
  
  var method: String {
    switch self {
    case .fetchCoinPrice:
      return "GET"
    }
  }
  
  var headers: [String : String]? {
    var dic = [String: String]()
    dic["Accept"] = "application/json"
    dic["Content-type"] = "application/json"
    return dic
  }
}

public protocol ServiceCompliant {

    var baseURL: String { get }
    var path: String { get }
    var method: String { get }
//    var sampleData: Data { get }
//    var task: Task { get }
//    var validationType: ValidationType { get }
    var headers: [String: String]? { get }
}



//extension CoinService: TargetType {
//  
//  var baseURL: URL {
//    switch self {
//    case .fetchCoinPrice:
//      return URL(string:"https://rest.coinapi.io/v1/exchangerate/")!
//    }
//  }
//  
//  var path: String {
//    switch self {
//    case .fetchCoinPrice(let params):
//      return "/\(params.name)/USD/apikey-\(Const.apiKey)"
//    }
//  }
//  
//  var method: Moya.Method {
//    switch self {
//    case .fetchCoinPrice:
//      return .post
//    }
//  }
//  
//  var task: Moya.Task {
//    switch self {
//    case .fetchCoinPrice(let params):
//      return .requestJSONEncodable(params)
//    }
//  }
//  
//  var headers: [String : String]? {
//    var dic = [String: String]()
//    dic["Accept"] = "application/json"
//    dic["Content-type"] = "application/json"
//    return dic
//  }
//}

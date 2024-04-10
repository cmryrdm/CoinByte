//
//  SomeCoinModel.swift
//  SomeCoin
//
//  Created by CEMRE YARDIM on 7.04.2024.
//

import SwiftUI

struct CoinModel: Codable, Hashable {
  let name: String?
  var rate: Double?
  let image: String?
}

extension CoinModel {
  static let data: [CoinModel] = [
    CoinModel(name: "BTC", rate: nil, image: "btc"),
    CoinModel(name: "ETH", rate: nil, image: "eth"),
    CoinModel(name: "USDT", rate: nil, image: "usdt"),
    CoinModel(name: "BNB", rate: nil, image: "bnb"),
    CoinModel(name: "SOL", rate: nil, image: "sol")
  ]
}


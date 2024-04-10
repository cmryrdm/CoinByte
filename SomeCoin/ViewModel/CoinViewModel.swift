//
//  SomeCoinViewModel.swift
//  SomeCoin
//
//  Created by CEMRE YARDIM on 7.04.2024.
//

import SwiftUI
//import RxSwift
import Combine

class CoinViewModel: ObservableObject {
  @Published var selected: CoinModel
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    selected = CoinModel.data[0]
    fetchCoinPrice(item: selected)
  }
  
  func fetchCoinPrice(item: CoinModel) {
    
    CoinNetworkManager.shared.fetchCoinPrice(params: item)
      .receive(on: DispatchQueue.main)
      .sink { error in
        print(error)
      } receiveValue: { [weak self] data in
        self?.selected.rate = data.rate
      }.store(in: &cancellables)
  }
}

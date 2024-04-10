//
//  SomeCoinView.swift
//  SomeCoin
//
//  Created by CEMRE YARDIM on 7.04.2024.
//

import SwiftUI

struct CoinView: View {
  @ObservedObject var viewModel = CoinViewModel()
  let color: Color = .indigo
  
  
  var body: some View {
    ZStack {
      color
        .opacity(0.33)
        .edgesIgnoringSafeArea(.all)
      
      VStack {
        HStack {
          Spacer()
          Text("Some")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(color)
          
          Text("Coin")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(color)
            .padding(.leading, -8)
          
          Spacer()
        }.padding(.top, 16)
        
        Spacer()
        
        HStack {
          Image(viewModel.selected.image ?? "")
            .background(.white)
            .clipShape(Circle())
          
          Text(String(format: "%.0f", viewModel.selected.rate ?? 0) + " USD")
            .font(.title)
            .fontWeight(.medium)
            .foregroundStyle(.white)
        }
        .padding(.all, 8)
        .background(RoundedRectangle(cornerRadius: 100).fill(color
          .opacity(0.67)))
        
        Picker("", selection: $viewModel.selected) {
          ForEach(CoinModel.data, id: \.self) { datum in
            Text(datum.name ?? "")
              .font(.title)
              .fontWeight(.light)
              .foregroundStyle(color)
          }
        }.pickerStyle(.wheel)
          .padding(.horizontal, 32)
          .onChange(of: viewModel.selected) { newValue in
            viewModel.fetchCoinPrice(item: viewModel.selected)
          }

        Spacer()

      }
    }
  }
}

//#Preview {
//  CoinView(viewModel: CoinViewModel())
//}

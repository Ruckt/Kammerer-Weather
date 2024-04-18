//
//  CityDetailsView.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/16/24.
//

import SwiftUI

struct CityDetailsView: View {
    var detail: CityDetailVM
    
    init(detail: CityDetailVM) {
        self.detail = detail
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("\(self.detail.name) is \(self.detail.mainDescription)")
                    .font(.headline)
                
                if let url = self.detail.iconUrl {
                    AsyncImageView(url: url)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 250)
                }
                Text("Description:  \(self.detail.description)")
                    .font(.body)
                    .padding()
                Text("Current Temperature: \(self.detail.weatherData.main.temp)")
                    .font(.subheadline)
                Text("Feels Like: \(self.detail.weatherData.main.feelsLike)")
                    .font(.subheadline)
            }
        }
        .frame(maxWidth: .infinity)
        .refreshable {
            await loadData()
        }
    }
    
    func loadData() async {
            // Simulate network request with delay
            try? await Task.sleep(nanoseconds: 2_000_000_000)  // 2 seconds delay
            print(" Refreshing")
    }
}

//
//  CityDetailsView.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/16/24.
//

import SwiftUI

struct CityDetailsView: View {
    @ObservedObject var detail: CityDetailVM
    
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
                    .font(.largeTitle)
                    .padding()
                Text("Current Temperature: \(self.detail.weatherData.main.temp)")
                    .font(.body)
                Text("Feels Like: \(self.detail.weatherData.main.feelsLike)")
                    .font(.body)
                Spacer()
                Text("Pull to Refresh!")
                    .font(.footnote)
            }
        }
        .frame(maxWidth: .infinity)
        .refreshable {
            await detail.refreshWeather()
        }
    }
}

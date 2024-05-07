//
//  CityDetailsView.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/16/24.
//

import SwiftUI

struct CityDetailsView: View {
    @ObservedObject var detail: CityDetailVM
    
    let locationName: String
    
    init(detail: CityDetailVM) {
        self.detail = detail
        let city = detail.name
        
        if let state = detail.stateCode {
            locationName = city + ", " + state + ", " + detail.country
        } else {
            locationName = city + ", " + detail.country
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("\(locationName) is \(self.detail.mainDescription)")
                    .font(.headline)
                
                if let url = self.detail.iconUrl {
                    AsyncImageView(url: url)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 250)
                }
                Text("Description:  \(self.detail.description)")
                    .font(.largeTitle)
                    .padding()
                Text("Current Temperature: \(self.detail.temperature)")
                    .font(.body)
                Text("Feels Like: \(self.detail.feelsLike)")
                    .font(.body)
                Spacer()
                Spacer()
                Text(detail.errorMessage)
                    .font(.caption)
                    .foregroundStyle(.red)
                Spacer()
                Text("Pull to Refresh!")
                    .font(.footnote)
                    .foregroundStyle(.blue)
            }
        }
        .frame(maxWidth: .infinity)
        .refreshable {
            await detail.refreshWeather()
        }
    }
}

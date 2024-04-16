//
//  ContentView.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var cityName: String = ""
    @State  var selectedCountryIndex = 0
    @StateObject var viewModel = CityWeatherVM()
   // @State private var weatherData: WeatherData?
    
    var countries: [(name: String, code: String)] = []

    init() {
        countries = CodeLoader().getCodes()
    }
    
    var body: some View {
        NavigationView {
            
            List {
                TextField("Enter city name", text: $cityName)
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(5)
                    .padding(.vertical, 8)
                    .listRowSeparator(.hidden)
   
                Picker("Select Country", selection: $selectedCountryIndex) {
                    ForEach(0..<countries.count, id: \.self) { index in
                        Text(self.countries[index].name).tag(index)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color(UIColor.systemBackground))
                .clipped()
                .padding(.vertical, 8)
                .listRowSeparator(.hidden)
                
                HStack {
                    Spacer()
                    PrettyButton {
                        Task {
                            let countryCode = countries[selectedCountryIndex].code
                            
                            print("Fetching weather for \(cityName), \(countryCode)")
                            
                            await viewModel.fetchWeatherFor(city: cityName, country: countryCode)
                        }
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity, minHeight: 50)
                .padding(.vertical, 8)
                
            }
           // .navigationBarTitle(Text("Kammerer Weather!"), displayMode: .inline)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                      VStack {
                          Text("Kammerer Weather")
                              .font(.largeTitle)
                              .multilineTextAlignment(.center)
                      }
                  }
              }
//              .sheet(item: $weatherData) { data in
//                  WeatherDetailsView(weatherData: data)
//              }
            Spacer()
        }

    }
    
}

#Preview {
    ContentView()
}

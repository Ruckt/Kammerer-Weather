//
//  ContentView.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var cityName: String = ""
    @State var countryCode: String = ""
    @State  var selectedCountryIndex = 0
    @StateObject var getService = GetWeatherService()
    @State var weatherData: OpenWeatherResponse?
    @State var shouldNavigate = false
    @State var isFahrenheit = true
    
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
                    Text("Celsius")
                        .foregroundColor(isFahrenheit ? .gray : .blue)
                    Spacer()
                    Toggle("", isOn: $isFahrenheit)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                    Spacer()
                    Spacer()
                    Text("Fahrenheit")
                        .foregroundColor(isFahrenheit ? .blue : .gray)
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
                            countryCode = countries[selectedCountryIndex].code
                            
                            let response = await getService.fetchWeatherFor(city: cityName, country: countryCode, isFarenheit: isFahrenheit)
                            weatherData = response
                            shouldNavigate = true // Trigger navigation
                        }
                    }
                    if let wd = weatherData {
                        let detail = CityDetailVM(name: cityName,
                                                  country: countryCode, isFarenheit: isFahrenheit, weatherData: wd, getService: getService)
                        
                        NavigationLink(destination: CityDetailsView(detail: detail), isActive: $shouldNavigate) {
                            EmptyView()
                        }.hidden()
                    }
                    
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity, minHeight: 50)
                .padding(.vertical, 8)
            }
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
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}

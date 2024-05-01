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
    @State var stateCode: String?
    @State var selectedCountryIndex = 0
    @State var selectedStateIndex = 0
    @State var weatherData: OpenWeatherResponse?
    @State var shouldNavigate = false
    @State var isFahrenheit = true
    @State var errorMessage: String = ""
    
    @ObservedObject var viewModel: ContentViewVM
    
    var countries: [(name: String, code: String)] = []
    var states: [(name: String, code: String)] = []

    init() {
        viewModel = ContentViewVM()
        countries = CodeLoader().getCodes(fileName: "CountryCodes")
        states = CodeLoader().getCodes(fileName: "States")
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
   
                Picker("US State", selection: $selectedStateIndex) {
                    ForEach(0..<states.count, id: \.self) { index in
                        Text(self.states[index].name).tag(index)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color(UIColor.systemBackground))
                .clipped()
                .padding(.vertical, 8)
                .listRowSeparator(.hidden)
                .disabled(selectedCountryIndex != 0) // For this version, support only US states/provinces.  USA is first, thus 0.
                
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
                            if selectedCountryIndex == 0 {
                                stateCode = states[selectedStateIndex].code
                            } else {
                                stateCode = nil
                            }
                            
                            let package = await viewModel.fetchWeatherFor(city: cityName, stateCode, countryCode, isFahrenheit)
                            if let wd = package.response {
                                weatherData = wd
                                shouldNavigate = true // Trigger navigation
                            } else if let message = package.error {
                                errorMessage = message
                            }
                        }
                    }
                    if let wd = weatherData {
                        let detail = CityDetailVM(name: cityName, stateCode: stateCode, country: countryCode, isFarenheit: isFahrenheit, weatherData: wd, weatherService: viewModel.weatherService)
                        
                        NavigationLink(destination: CityDetailsView(detail: detail), isActive: $shouldNavigate) {
                            EmptyView()
                        }.hidden()
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity, minHeight: 50)
                .padding(.vertical, 8)

                Text(errorMessage)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.red)
                    .listRowSeparator(.hidden)
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

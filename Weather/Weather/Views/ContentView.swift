//
//  ContentView.swift
//  Weather
//
//  Created by Jhonathan Matos on 31/07/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatnerManager = WeatherManager()
    @State var weather:ResponseBody?
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                try await weather = weatnerManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("error getting weather: \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
            
        }
        .background(Color(hue: 0.656, saturation: 0.059, brightness: 0.001))
        .preferredColorScheme(.dark)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

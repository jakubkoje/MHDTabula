//
//  ContentView.swift
//  MHDTabula
//
//  Created by Jakub Jelínek on 23/07/2022.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var searchText = ""
    @State private var showingInfoSheet = false
    @StateObject var locationManager = LocationManager()
    @StateObject var favoriteStops = FavoriteStops()
    
    var stops = [Stop]()
    
    init() {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: "stops", withExtension: "json")
        else {
            fatalError("Couldn't find stops.json in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load stops.json from main bundle:\n\(error)")
        }
        
        do {
            self.stops = try JSONDecoder().decode([Stop].self, from: data)
        } catch {
            fatalError("Couldn't parse stops.json as \([Stop].self):\n\(error)")
        }
    }
    
    var body: some View {
        NavigationView {
            List(searchedStops) { stop in
                StopItemView(stop: stop)
                    .environmentObject(favoriteStops)
            }
            .searchable(text: $searchText, prompt: "Hľadať zastávku")
            .navigationTitle("MHD Tabuľa")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingInfoSheet.toggle()
                    } label: {
                        Image(systemName: "questionmark.circle")
                    }
                }
            }
            
            Text("Vyber si v menu zastávku")
                .font(.largeTitle)
        }
        .sheet(isPresented: $showingInfoSheet) {
            InfoSheetView()
        }

    }
    
    var searchedStops: [Stop] {
        if searchText.isEmpty {
            if locationManager.lastLocation != nil {
                return stops
                    .sorted {
                        if favoriteStops.contains($0) != favoriteStops.contains($1) {
                            return favoriteStops.contains($0) && !favoriteStops.contains($1)
                        } else {
                            return CLLocation.init(latitude: $0.lat, longitude: $0.lon).distance(from: locationManager.lastLocation!) < CLLocation.init(latitude: $1.lat, longitude: $1.lon).distance(from: locationManager.lastLocation!)
                        }
                    }
            }
            return stops.sorted { favoriteStops.contains($0) && !favoriteStops.contains($1) }
        } else {
            if locationManager.lastLocation != nil {
                return stops.filter { $0.name.lowercased().folding(options:                             .diacriticInsensitive, locale: .current).contains(searchText.lowercased().folding(options: .diacriticInsensitive, locale: .current)) }
                    .sorted {
                        if favoriteStops.contains($0) != favoriteStops.contains($1) {
                            return favoriteStops.contains($0) && !favoriteStops.contains($1)
                        } else {
                            return CLLocation.init(latitude: $0.lat, longitude: $0.lon).distance(from: locationManager.lastLocation!) < CLLocation.init(latitude: $1.lat, longitude: $1.lon).distance(from: locationManager.lastLocation!)
                        }
                    }
            }
            return stops.filter { $0.name.lowercased().folding(options: .diacriticInsensitive, locale: .current).contains(searchText.lowercased().folding(options: .diacriticInsensitive, locale: .current)) }
                .sorted { favoriteStops.contains($0) && !favoriteStops.contains($1) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  StopItemView.swift
//  MHDTabula
//
//  Created by Jakub Jelínek on 23/07/2022.
//

import SwiftUI

struct StopItemView: View {
    @EnvironmentObject var favoriteStops: FavoriteStops
    
    let stop: Stop
    
    var body: some View {
        NavigationLink {
            StopDetailView(stop: stop)
        } label: {
            HStack {
                Text(stop.name)
                Spacer()
                if favoriteStops.contains(stop) { Image(systemName: "star") }
            }
        }
        .swipeActions(edge: .leading) {
            Button {
                print("Awesome!")
                if favoriteStops.contains(stop) {
                    favoriteStops.remove(stop)
                } else {
                    favoriteStops.add(stop)
                }
            } label: {
                Image(systemName: favoriteStops.contains(stop) ? "star.slash" : "star")
            }
            .tint(.yellow)
        }
    }
}

struct StopItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                StopItemView(stop: Stop.example)
                    .environmentObject(FavoriteStops())
            }
        }
    }
}

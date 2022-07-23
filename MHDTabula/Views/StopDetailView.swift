//
//  StopDetailView.swift
//  MHDTabula
//
//  Created by Jakub Jelínek on 23/07/2022.
//

import SwiftUI

struct StopDetailView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    let stop: Stop
    
    var body: some View {
        // darkblue and white
        ZStack {
            Color("Background").ignoresSafeArea()
            ProgressView()
                .scaleEffect(2)
            WebView(url: URL(string: "https://imhd.sk/ba/online-zastavkova-tabula?st=\(stop.value)&theme=\(colorScheme == .light ? "white" : "darkblue")&zoom=100&I_CONSENT=TO_THE_COOKIES_POLICY_AND_THE_PRIVACY_POLICY&nthDisplay=1&showClock=0&showInfoText=1")!)
                .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    let IDSBKUrl = URL(string: "com.casperise.urbi.online.bid://")!
                    if UIApplication.shared.canOpenURL(IDSBKUrl) {
                        UIApplication.shared.open(IDSBKUrl)
                    } else {
                        UIApplication.shared.open(URL(string: "https://apps.apple.com/sk/app/ids-bk-cestovn%C3%A9-l%C3%ADstky/id1360894243")!)
                    }
                } label: {
                    Image(systemName: "ticket")
                }
            }
        }
    }
}

struct StopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StopDetailView(stop: Stop.example)
        }
    }
}

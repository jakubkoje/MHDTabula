//
//  InfoSheetView.swift
//  MHDTabula
//
//  Created by Jakub Jelínek on 19/11/2022.
//

import SwiftUI

struct InfoSheetView: View {
    @Environment(\.dismiss) var dismiss;
    var body: some View {
        NavigationView {
            Text("hi")
                .navigationBarItems(trailing: Button {
                    dismiss()
                } label: {
                    Text("Zrušiť")
                })
        }
    }
}

struct InfoSheetView_Previews: PreviewProvider {
    static var previews: some View {
        InfoSheetView()
    }
}

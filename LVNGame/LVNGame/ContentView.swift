//
//  ContentView.swift
//  LVNGame
//
//  Created by Constantin Angheloiu on 07.11.2022.
//

import SwiftUI
import PhoenixLiveViewNative

struct ContentView: View {
    @State var coordinator = LiveViewCoordinator(URL(string: "http://constantin.local:4000")!)

    var body: some View {
        LiveView(coordinator: coordinator)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

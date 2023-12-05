//
//  TabBarView.swift
//  pokeapi
//
//  Created by Shreeram Kelkar on 13/11/23.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            PokeDexView()
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("First Tab")
                }
            
            Text("Tab 2")
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Second Tab")
                }

            Text("Tab 3")
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("Third Tab")
                }

        }
    }
}

#Preview {
    TabBarView()
}

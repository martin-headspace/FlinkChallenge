//
//  ContentView.swift
//  FlinkChallenge
//
//  Created by Fernando Martin Garcia Del Angel on 18/02/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                CharacterFeedView().navigationBarTitle(Text("Characters"))
            }.accentColor(Color(red: 0, green: 0.6, blue: 0.6))
             .tag(0)
             .tabItem {
                Text("Characters")
            }
            
            NavigationView {
                AdvancedFilterView().navigationBarTitle(Text("Advanced Search"))
            }
            .tag(1)
                .tabItem {
                    Text("Advanced Search")
            }
        }
    }
}

struct dummyView : View {
    var body: some View {
        Text("rendering...")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

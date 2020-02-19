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
        NavigationView {
            CharacterFeedView().navigationBarTitle(Text("Characters"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

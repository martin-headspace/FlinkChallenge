//
//  AdvancedFilterView.swift
//  FlinkChallenge
//
//  Created by Fernando Martin Garcia Del Angel on 19/02/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import SwiftUI

struct RoundedButton : View {
    var body: some View {
        Button(action: {}){
            HStack {
                Spacer()
                Text("Search")
                    .font(.headline)
                Spacer()
            }
        }
        .padding(.vertical, 10.0)
        .padding(.horizontal, 50)
    }
}

struct AdvancedFilterView: View {
    @State private var name: String = ""
    @State private var status: String = ""
    @State private var species : String = ""
    @State private var type : String = ""
    var body: some View {
        Form {
            Section(header: Text("Basic Data")) {
                TextField("Name",text: $name)
            }
            
            Section(header: Text("Other data")) {
                TextField("Status",text: $status)
                TextField("Species",text: $species)
                TextField("Type",text: $type)
            }
            RoundedButton()
        }
    }
}

struct AdvancedFilterView_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedFilterView()
    }
}

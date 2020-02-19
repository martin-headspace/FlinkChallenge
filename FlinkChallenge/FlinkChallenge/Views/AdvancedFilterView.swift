//
//  AdvancedFilterView.swift
//  FlinkChallenge
//
//  Created by Fernando Martin Garcia Del Angel on 19/02/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import SwiftUI

struct RoundedButton : View {
    var name : String = ""
    var status : String = ""
    var species : String = ""
    var type: String = ""
    var gender : String = ""
    
    var body: some View {
        NavigationLink(destination:
            CharacterFilterView(name: name,
                                status: status,
                                species: species,
                                type: type,
                                gender: gender)) {
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
}

struct AdvancedFilterView: View {
    var statuses = ["alive","dead","unknown"]
    var genders = ["female","male","genderless","unknown"]
    @State private var selectedStatus = 0
    @State private var selectedGender = 0
    @State private var name: String = ""
    @State private var status: String = ""
    @State private var species : String = ""
    @State private var type : String = ""
    @State private var gender : String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Basic Data")) {
                TextField("Name",text: $name)
            }
            
            Section(header: Text("Other data")) {
                Picker (selection: $selectedStatus, label: Text("Status")) {
                    ForEach(0 ..< statuses.count) {
                        Text(self.statuses[$0].capitalized)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                Picker (selection: $selectedGender, label: Text("Gender")) {
                    ForEach(0 ..< genders.count) {
                        Text(self.genders[$0].capitalized)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                TextField("Species",text: $species)
                TextField("Type",text: $type)
                
            }
            RoundedButton(name: name,
                          status: statuses[selectedStatus],
                          species: species,
                          type: type,
                          gender: genders[selectedGender])
        }
    }
}

struct AdvancedFilterView_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedFilterView()
    }
}

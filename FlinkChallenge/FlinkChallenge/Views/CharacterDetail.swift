//
//  CharacterDetail.swift
//  FlinkChallenge
//
//  Created by Fernando Martin Garcia Del Angel on 18/02/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CircleImage: View {
    var url : String
    var body: some View {
        WebImage(url: URL(string: url))
        .resizable()
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.gray,lineWidth: 4))
        .shadow(radius: 10)
    }
}

struct BackgroundView: View {
    var body: some View {
        Image("background").resizable()
    }
}


struct MainCharacterAttributes : View {
    var character: APICharacter
    var body: some View {
        HStack {
            VStack {
                Text("Status")
                    .font(.headline)
                Text(character.status ?? "Unknown")
                    .font(.caption)
            }
            Spacer()
            VStack {
                Text("Species")
                    .font(.headline)
                Text(character.species ?? "Unknown")
                    .font(.caption)
            }
            Spacer()
            if !character.type!.isEmpty {
                VStack {
                    Text("Type")
                        .font(.headline)
                    Text(character.type ?? "Unknown")
                        .font(.caption)
                }
                Spacer()
            }
            VStack {
                Text("Gender")
                    .font(.headline)
                Text(character.gender ?? "Unknown")
                    .font(.caption)
            }
        }.padding()
    }
}

struct DataCard : View {
    var character : APICharacter
    var body: some View {
        VStack {
            VStack {
                VStack {
                    Text("Origin").font(.headline).bold()
                    Text(character.origin?.name ?? "Location Unknown")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }.padding()
                
                VStack {
                    Text("Location").font(.headline).bold()
                    Text(character.location?.name ?? "Location Unknown")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }.padding()
                
                VStack() {
                    Text("Episodes \(character.name ?? "this character") appears in").bold().multilineTextAlignment(.center).font(.headline)
                    Text("\(character.episode?.count ?? 0)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }.padding()
            }.padding().frame(width: 300, height: 500, alignment: .center)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.bottom)
    }
}

struct CharacterDetail: View {
    var character : APICharacter
    
    var body: some View {
        ScrollView {
            VStack {
                BackgroundView()
                .frame(height: 300)
                CircleImage(url: character.image ?? "")
                    .frame(width: 200, height: 200)
                    .offset(y: -130)
                    .padding(.bottom, -130)
                VStack(alignment: .center) {
                    Text(character.name ?? "Unknown")
                        .font(.title)
                    MainCharacterAttributes(character: character)
                }.padding()
                DataCard(character: character)
            }
        }.edgesIgnoringSafeArea(.top)
    }
}

struct CharacterDetail_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetail(character: APICharacter.init())
    }
}

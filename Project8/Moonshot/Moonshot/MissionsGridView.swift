//
//  MissionsGridView.swift
//  Moonshot
//
//  Created by Matthew Zierl on 9/25/24.
//

import SwiftUI

struct MissionsGridView: View {
    
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        }
                    }
//                    NavigationLink(value: {
//                        MissionView(mission: mission, astronauts: astronauts)
//                    }, label: {
//                        VStack {
//                            Image(mission.image)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 100, height: 100)
//                                .padding()
//                            VStack {
//                                Text(mission.displayName)
//                                    .font(.headline)
//                                    .foregroundStyle(.white)
//                                Text(mission.formattedLaunchDate)
//                                    .font(.caption)
//                                    .foregroundStyle(.gray)
//                            }
//                            .padding(.vertical)
//                            .frame(maxWidth: .infinity)
//                            .background(.lightBackground)
//                        }
//                        .clipShape(.rect(cornerRadius: 10))
//                        .overlay {
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(.lightBackground)
//                        }
//                        
//                    })
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

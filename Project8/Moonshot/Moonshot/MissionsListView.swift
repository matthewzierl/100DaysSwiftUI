//
//  MissionsListView.swift
//  Moonshot
//
//  Created by Matthew Zierl on 9/25/24.
//

import SwiftUI

struct MissionsListView: View {
    
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .padding(.horizontal)
                    Text(mission.displayName)
                        .font(.headline)
                        .foregroundStyle(.white)
                    Spacer()
                    Text(mission.formattedLaunchDate)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
        }
        .listStyle(.plain)
        .listRowBackground(Color.darkBackground)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json") // type annotation required for generic type methods
    let missions: [Mission] = Bundle.main.decode("missions.json") // uses generic method to accomplish each call
    MissionsListView(astronauts: astronauts, missions: missions)
}

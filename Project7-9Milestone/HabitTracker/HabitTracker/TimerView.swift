//
//  TimerView.swift
//  HabitTracker
//
//  Created by Matthew Zierl on 10/3/24.
//

import SwiftUI

// TODO: Bug where exiting before pressing pause continues timer while still showing play button

struct TimerView: View {
    
    @State private var timerStart = Date.now
    @State private var timerCurrent = Date.now
    @Binding var habit: Habit
    @Binding var timeBank: TimeInterval
    @State private var isPlaying = false
    
    @State private var timer: Timer?
    
    var body: some View {
        HStack {
            
            Button() {
                if isPlaying {
                    isPlaying = false
                    timer?.invalidate()
                } else {
                    isPlaying = true
                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
                        timeBank += 1
                    })
                }
                
            } label: {
                ZStack {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .foregroundStyle(.white)
                }
            }
            
            Text(timeString(from: timeBank))
            
                .frame(width: 100, height: 50)
                .foregroundStyle(.white)
                .padding()
            
            Button() {
                // Deposit time
                timer?.invalidate()
                isPlaying = false
                habit.progress += timeBank
                timeBank = 0
            } label: {
                Image(systemName: "arrow.up.arrow.down.circle.fill")
                    .foregroundStyle(.white)
            }
            
        }
        .frame(width: 250, height: 50)
        .background(.lightBackground)
        .clipShape(.capsule)
    }
    
    func timeString(from time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


#Preview {
    @Previewable @State var timeBank: TimeInterval = 0
    @Previewable @State var habit = Habit(name: "Example", goal: 5, progress: 1, color: .blue, description: "description")
    TimerView(habit: $habit, timeBank: $timeBank)
}

//
//  LargeTimerView.swift
//  HabitTracker
//
//  Created by Matthew Zierl on 10/8/24.
//

import SwiftUI

struct LargeTimerView: View {
    @State private var timerStart = Date.now
    @State private var timerCurrent = Date.now
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
            .font(.system(size: 28))
            
            Text(timeString(from: timeBank))
                .frame(width: 100, height: 50)
                .foregroundStyle(.white)
                .font(.system(size: 22))
                .padding()
            
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
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
    LargeTimerView(timeBank: $timeBank)
}

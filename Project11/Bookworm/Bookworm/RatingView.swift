//
//  RatingView.swift
//  Bookworm
//
//  Created by Matthew Zierl on 1/3/25.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int
    
    var label: String = ""
    var maxRating: Int = 5
    
    var offImage: Image?
    var onImage: Image = Image(systemName: "star.fill")
    
    var offColor: Color = Color.gray
    var onColor: Color = Color.yellow
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            ForEach(1 ..< maxRating + 1, id: \.self) { number in
                Button {
                    print("Tapped \(number)")
                    rating = number
                } label: {
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
            }
            .buttonStyle(.plain) // somehow allows SwiftUI to treat each button individually???
            .accessibilityElement()
            .accessibilityLabel(label)
            .accessibilityValue(rating == 1 ? "1 star" : "(\(rating) stars")
            .accessibilityAdjustableAction { direction in
                switch direction {
                case .increment:
                    if rating < maxRating {
                        rating += 1
                    }
                case .decrement:
                    if rating > 1 {
                        rating -= 1
                    }
                @unknown default:
                    break
                }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}

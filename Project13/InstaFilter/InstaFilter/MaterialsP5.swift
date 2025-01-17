//
//  MaterialsP5.swift
//  InstaFilter
//
//  Created by Matthew Zierl on 1/14/25.
//

import PhotosUI
import SwiftUI

struct MaterialsP5: View {
    
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $pickerItems, maxSelectionCount: 5, matching: .any(of: [.images, .not(.screenshots)])) {
                Label("Select Pictures", systemImage: "photo")
            }
            
            ScrollView {
                ForEach(0 ..< selectedImages.count, id: \.self) { index in
                    selectedImages[index]
                        .resizable()
                        .scaledToFit()
                }
            }
            
        }
        .onChange(of: pickerItems) {
            Task { // asynchronous
                selectedImages.removeAll() // remove previous
                for pickerItem in pickerItems {
                    if let image = try? await pickerItem.loadTransferable(type: Image.self) {
                        selectedImages.append(image)
                    }
                }
            }
        }
    }
}

#Preview {
    MaterialsP5()
}

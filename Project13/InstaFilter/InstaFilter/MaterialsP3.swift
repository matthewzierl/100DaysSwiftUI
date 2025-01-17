//
//  MaterialsP3.swift
//  InstaFilter
//
//  Created by Matthew Zierl on 1/12/25.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct MaterialsP3: View {
    
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
                
        }
        .onAppear {
            loadImage()
        }
    }
    
    /*
     3 types of images:
        UIImage
        CGImage
        CIImage
     */
    func loadImage() {
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
    
        currentFilter.inputImage = beginImage
        
        let amount = 1.0
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) { // if filter supports intensity
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) { // if filter supports radius
            currentFilter.setValue(amount * 300, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) { // if filter supports scale
            currentFilter.setValue(amount * 20, forKey: kCIInputScaleKey)
        }
        
//        currentFilter.radius = 1000
//        currentFilter.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)
//        currentFilter.scale = 10
//        currentFilter.intensity = 0.4
        
        // get CIImage from filter
        guard let outputImage = currentFilter.outputImage else { return }
        // convert CIImage to CGImage
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        // convert CGImage to UIImage
        let uiImage = UIImage(cgImage: cgImage)
        
        image = Image(uiImage: uiImage)
        
    }
}

#Preview {
    MaterialsP3()
}

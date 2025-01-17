//
//  ContentView.swift
//  InstaFilter
//
//  Created by Matthew Zierl on 1/12/25.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    
    @State private var selectedItem: PhotosPickerItem?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext() // not gonna change
    
     @State private var showFilterPicker = false
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
            NavigationStack {
                VStack {
                    Spacer()
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        
                        // image area
                        if let processedImage {
                            processedImage
                                .resizable()
                                .scaledToFit()
                        } else {
                            ContentUnavailableView {
                                Label("No Picture", systemImage: "photo.badge.plus")
                            } description: {
                                Text("Tap to Import a Photo")
                            }
                        }
                        
                    }
                    .buttonStyle(.plain)
                        
                    Spacer()
                    
                    HStack {
                        Text("Intensity")
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity) {
                                applyProcessing()
                            }
                    }
                    HStack {
                        Button("Change Filter") {
                            changeFilters()
                        }
                        Spacer()
                        
                        // share picture
                        
                        if let processedImage {
                            ShareLink(item: processedImage, preview: SharePreview("InstalFilter Image", image: processedImage))
                        }
                        
                    }
                }
                .padding([.horizontal, .vertical])
                .navigationTitle("InstaFilter")
                .onChange(of: selectedItem) {
                    loadImage()
                }
                .confirmationDialog("Select a Filter", isPresented: $showFilterPicker) {
                    Button("Bloom") {
                        setFilter(CIFilter.bloom())
                    }
                    Button("Gaussian Blur") {
                        setFilter(CIFilter.gaussianBlur())
                    }
                    Button("Parallelogram Tile") {
                        setFilter(CIFilter.parallelogramTile())
                    }
                    Button("Sepia Tone") {
                        setFilter(CIFilter.sepiaTone())
                    }
                    Button("Crystallize") {
                        setFilter(CIFilter.crystallize())
                    }
                    Button("Cancel", role: .cancel) {}
                }
            }
        }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        
        filterCount += 1
        
        if filterCount >= 20 {
            requestReview()
        }
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 300, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 20, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { // apply filters and return CIImage
            print("Could not apply filter")
            return
        }
        
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { // convert CIImage to CGImage
            print("Could not convert CIImage to CGImage")
            return
        }
        let uiImage = UIImage(cgImage: cgImage) // convert CGImage to UIImage
        
        processedImage = Image(uiImage: uiImage) // convert UIImage to Image (SwiftUI can display)
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {
                print("Could not retrieve raw data from photo picker")
                return
            }
            guard let inputImage = UIImage(data: imageData) else {
                print("Could not convert raw data to UIImage")
                return
            }
            
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
            
        }
    }
    
    func changeFilters() {
        showFilterPicker.toggle()
    }
}

#Preview {
    ContentView()
}

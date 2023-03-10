//
//  CustomCameraView.swift
//  Prototype-AIMoodDetection-IOS
//
//  Created by Reno Muijsenberg on 27/02/2023.
//

import SwiftUI
import CoreML
import Vision

struct PhotoView: View {
    @Binding var capturedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    @State private var mood: String = ""
    
    struct Mood {
        var mood: String
        var availableMoods: [String]
        var emoji: String
    }
    
    var Moods: [Mood] = [
        Mood(mood: "Happy", availableMoods: ["Happy", "Surprise"], emoji: "😁"),
        Mood(mood: "Neutral", availableMoods: ["Neutral"], emoji: "😐"),
        Mood(mood: "Sad", availableMoods: ["Fear", "Disgust", "Sad", "Angry"], emoji: "😔"),
    ]
    
    var body: some View {
        ZStack {
            if let image = capturedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .scaleEffect(x: -1, y: 1, anchor: .center).onAppear{
                        classifyImage()
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                    .imageScale(.large)
                    .padding(.leading, -8)
                Text("Delete").foregroundColor(.white)
            })
        )
    }
    
    private func getTheCurrentMood(){
        if let myMood = Moods.first(where: { $0.availableMoods.contains(mood)}){
            print(myMood.mood)
        }
    }
    
    private func classifyImage() {
        guard let image = capturedImage else { return }
        
        DispatchQueue.global().async {
            do {
                let model = try VNCoreMLModel(for: FacialExpression().model)
                
                let request = VNCoreMLRequest(model: model) { request, error in
                    guard let results = request.results as? [VNClassificationObservation],
                          let topResult = results.first else {
                        self.mood = "Unable to classify image"
                        return
                    }
                    print("Confidence: \(topResult)")
                    self.mood = topResult.identifier
                    self.getTheCurrentMood()
                }
                let cgImage = image.cgImage!
                let handler = VNImageRequestHandler(cgImage: cgImage)
                
                try handler.perform([request])
            } catch {
                DispatchQueue.main.async {
                    print("Error classifying image: \(error)")
                    self.mood = "Error classifying image"
                }
            }
        }
        
    }
}

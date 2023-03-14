//
//  CustomCameraView.swift
//  Prototype-AIMoodDetection-IOS
//
//  Created by Reno Muijsenberg on 27/02/2023.
//

import SwiftUI
import CoreML
import Vision
import Firebase
import FirebaseStorage

struct PhotoView: View {
    @Binding var capturedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    @State private var mood: String = ""
    @State private var emoji: String = ""
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if let image = capturedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .scaleEffect(x: -1, y: 1, anchor: .center).onAppear{
                        classifyImage()
                    }
            }
            VStack {
                EmojiPhotoComponent(emoji: emoji)
                if capturedImage != nil {
                    Button(action: {
                        uploadPhoto()
                    }) {
                        Text("Send >")
                    }
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
    
    func uploadPhoto() {
        guard capturedImage != nil else {
            return
        }
        
        let storageRef = Storage.storage().reference()

        let imageData = capturedImage!.jpegData(compressionQuality: 0.0)
        
        guard imageData != nil else {
            return
        }
        
        if let currentUser = Auth.auth().currentUser {
            let fileRef = storageRef.child("images/\(currentUser.uid).jpeg")
            
            fileRef.putData(imageData!, metadata: nil) { metedata, error in
                if error != nil && metedata == nil {
                    print(error)
                }
            }
        }
    }
    
    private func setCurrentMood(predictedMood: String){
        switch mood {
        case "happy":
            emoji = "😁"

        case "neutral":
            emoji = "😐"

        case "sad":
            emoji = "😔"

        default:
            print(mood)
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
                    self.setCurrentMood(predictedMood: topResult.identifier)
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

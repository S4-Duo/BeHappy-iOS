//
//  CustomCameraView.swift
//  Prototype-AIMoodDetection-IOS
//
//  Created by Reno Muijsenberg on 27/02/2023.
//

import SwiftUI

struct CustomCameraView: View {
    
    let cameraService = CameraService()
    @Binding var isPresent: Bool
    
    @State var capturedImage: UIImage?
    
    @Environment(\.presentationMode) private var PresentationMode
    
    var body: some View {
        NavigationStack {
            if capturedImage != nil {
                Image(uiImage: capturedImage!).resizable().scaledToFill().ignoresSafeArea().scaleEffect(x: -1, y: 1, anchor: .center)
            } else {
                ZStack {
                    CameraView(cameraService: cameraService) { result in
                        switch result {
                            
                        case .success(let photo):
                            if let data = photo.fileDataRepresentation() {
                                capturedImage = UIImage(data: data)
                                PresentationMode.wrappedValue.dismiss()
                            } else {
                                print("Error: No image data found")
                            }
                        case .failure(let err):
                            print(err.localizedDescription)
                        }
                    }
                    
                    VStack {
                        Spacer()
                        
                        Button(action: {
                            cameraService.capturePicture()
                        },
                               label: {
                            Image(systemName: "circle").font(.system(size: 72)).foregroundColor(.white)
                        }).padding(.bottom)
                    }
                }.ignoresSafeArea()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(
                        leading: Button(action: {
                            PresentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .imageScale(.large)
                                .padding(.leading, -8)
                            Text("Back")
                                .foregroundColor(.white)
                        })
                    )
            }
        }
    }
}

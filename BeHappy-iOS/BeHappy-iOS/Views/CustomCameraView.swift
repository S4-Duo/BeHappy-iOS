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
    @State var isCustomPhotoView: Bool = false
    
    @Environment(\.presentationMode) private var PresentationMode

    var body: some View {
        NavigationStack {
            ZStack {
                CameraView(cameraService: cameraService) { result in
                    switch result {
                        
                    case .success(let photo):
                        if let data = photo.fileDataRepresentation() {
                            capturedImage = UIImage(data: data)
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
                        DispatchQueue.main.async {
                            cameraService.capturePicture()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                if capturedImage != nil {
                                    isCustomPhotoView = true
                                }
                            }
                        }
                    },
                           label: {
                        Image(systemName: "circle").font(.system(size: 72)).foregroundColor(.white)
                    }).padding(.bottom)
                }
            }.ignoresSafeArea()
                .navigationDestination(isPresented: $isCustomPhotoView) {
                    CustomPhotoView(isPresent: $isCustomPhotoView, capturedImage: $capturedImage)
                }
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

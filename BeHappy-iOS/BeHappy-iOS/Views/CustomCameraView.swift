//
//  CustomCameraView.swift
//  Prototype-AIMoodDetection-IOS
//
//  Created by Reno Muijsenberg on 27/02/2023.
//

import SwiftUI

struct CustomCameraView: View {
    let cameraService = CameraService()
    @State var capturedImage: UIImage? = nil
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        ZStack {
            //View that extually shows the camera
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
            
            //Layout on top of the camera view
            VStack {
                Spacer()
                Button(action: {
                    cameraService.capturePicture()
                },
                label: {
                    Image(systemName: "circle")
                        .font(.system(size: 72))
                        .foregroundColor(.white)
                })
                .padding(.bottom)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationDestination(isPresented: Binding(
            get: { capturedImage != nil },
            set: { if !$0 { capturedImage = nil } }
        )) {
            CustomPhotoView(capturedImage: $capturedImage)
         }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            },
            label: {
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

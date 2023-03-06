//
//  CustomCameraView.swift
//  Prototype-AIMoodDetection-IOS
//
//  Created by Reno Muijsenberg on 27/02/2023.
//

import SwiftUI

struct CustomPhotoView: View {
    @Binding var isPresent: Bool
    @Binding var capturedImage: UIImage?
    
    @Environment(\.presentationMode) private var PresentationMode
    
    var body: some View {
        NavigationStack {
            VStack {
                if capturedImage != nil {
                    Image(uiImage: capturedImage!).resizable().scaledToFill().ignoresSafeArea().scaleEffect(x: -1, y: 1, anchor: .center)
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

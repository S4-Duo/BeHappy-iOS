//
//  ExploreView.swift
//  BeHappy-iOS
//
//  Created by Reno Muijsenberg on 14/03/2023.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct ExploreView: View {
    let storage = Storage.storage()
    let reference = Storage.storage().reference(withPath: "images/")
    @State private var images: [UIImage] = []
    @State private var currentIndex = 0
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            PagerView(pageCount: images.count, currentIndex: $currentIndex) {
                ForEach(images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .onTapGesture {
                            // Add action here if needed
                        }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
            .gesture(DragGesture()
                        .onEnded({ value in
                            if value.translation.height < -50 {
                                currentIndex = min(currentIndex + 1, images.count - 1)
                            }
                            if value.translation.height > 50 {
                                currentIndex = max(currentIndex - 1, 0)
                            }
                        }))
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear(perform: loadImage)
        .navigationBarHidden(true)
    }
    
    func loadImage() {
        reference.listAll { (result, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                for item in result!.items {
                    item.getData(maxSize: 1024 * 1024) { (data, error) in
                        if let error = error {
                            print("Error: \(error.localizedDescription)")
                        } else {
                            if let data = data, let image = UIImage(data: data) {
                                images.append(image)
                            }
                        }
                    }
                }
            }
        }
    }
}


struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}

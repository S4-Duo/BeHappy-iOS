//
//  PagerView.swift
//  BeHappy-iOS
//
//  Created by Reno Muijsenberg on 14/03/2023.
//

import SwiftUI

struct PagerView<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content
    
    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    content
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            .content.offset(y: CGFloat(currentIndex) * -geometry.size.height)
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
            .gesture(DragGesture()
                        .onEnded({ value in
                            if value.translation.height < -50 {
                                currentIndex = min(currentIndex + 1, pageCount - 1)
                            }
                            if value.translation.height > 50 {
                                currentIndex = max(currentIndex - 1, 0)
                            }
                        }))
        }
    }
}

//
//  AnimatedImageView.swift
//  BeHappy-iOS
//
//  Created by Reno Muijsenberg on 08/03/2023.
//

import Foundation
import SwiftUI
import FLAnimatedImage

struct AnimatedImageComponent: UIViewRepresentable {
    let animatedView = FLAnimatedImageView()
    
    let mood: String
    
    init(mood: String) {
        self.mood = mood
    }
    
    let happy = [
        URL(string: "https://media.giphy.com/media/l4pTfx2qLszoacZRS/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/MeIucAjPKoA120R7sN/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/xT5LMHxhOfscxPfIfm/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/artj92V8o75VPL7AeQ/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/chzz1FQgqhytWRWbp3/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/z8XtwKGIRQSBCmU4sW/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/MVDPX3gaKFPuo/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/YnBntKOgnUSBkV7bQH/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/3NtY188QaxDdC/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/1136UBdSNn6Bu8/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/DYH297XiCS2Ck/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/PPgZCwZPKrLcw75EG1/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/JltOMwYmi0VrO/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/7r5vNfdMVTVp7JkhGB/giphy.gif")!
    ]
    
    let neutral = [
        URL(string: "https://media.giphy.com/media/LMJavgUFMwM6CICHrt/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/g0UlPZuIk71uxf0o4N/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/d62kJn033NWxJTHsd0/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/d62kJn033NWxJTHsd0/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExMGM1MGFjNGRjMjQyNWUzNWFjNWNmNzFlNTM5NGFlZmZlZDVhY2RlNCZjdD1n/H47VxJRkvQU3a7FOPf/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/39lYbuIEDqiDHAD0KT/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExOTk4YmEyOGM1MDM3YmVjN2IwNTg0NjFkNGJhZWNiYzgzNzVmNTlmYSZjdD1n/1ynie3mpmzApRu2TU5/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExZDdjM2Y3NjA3ODk2OWZlYzcxNGExNjhiN2NiYjYyNWMwNzY2OTYwMSZjdD1n/HfFccPJv7a9k4/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExZmEyYmNiYWRkM2U0MmZiMGQ0NTNhYTlmODRlOTI4NzgzZjMzMjllNiZjdD1n/d3HeU0IDO2jLy/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExMWM5NmVlM2ZiYzIyOTRmZDkxZmY5MzU4YTI4ZmUxMzUyNGQ3YjgwOCZjdD1n/gpmARWm3Pwypq/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExZGE4OGNmYTI1YTM4ZDMzM2MyMjY0MmM2YjgxNjIyZDZlNTQ5YThlMSZjdD1n/CTmxnNaVPooCs/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExMDUxMzliMmIxZDdiZThjZDQwM2U1ZmI2NTJkNmE4YzRmZTExNjkxOCZjdD1n/9V3e2mxWvD89wyw5l5/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExZjhiYmVlZGIzM2JhMjc2NmUyZGE5OWZkZjA1YTIxMDIzMTZiMzk4YyZjdD1n/BIZkwFtu2xDlS/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExYTVkZjEwZDA4MjJmNzczN2RmZTg0YjQwMDI1YmZlZDY5YmM3YjhiMiZjdD1n/t0AIG7ldNyMBG/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/7TqT3vOegFkZRcbdnG/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/1iUlZloL4DiH8HL2/giphy.gif")!,
    ]
    
    let sad = [
        URL(string: "https://media.giphy.com/media/SggILpMXO7Xt6/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/hQKiGV6MG8WmsHg2yx/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/Mtqip7Jor0DgAvzn6U/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/wW95fEq09hOI8/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/nfLpqTrNPpqcE/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/1qB3EwE3c54A/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExNTU0ZmZjY2M5YzM5MmM1N2VhZWYzZDc4MTVhMDBkMWQyNzczYTU1OSZjdD1n/7XuKKmGiaxXe6EjOj4/giphy-downsized-large.gif")!,
        URL(string: "https://media.giphy.com/media/1d7F9xyq6j7C1ojbC5/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/1mIfigvZCiDXG/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExYmNkODhjZmNkNTY0ZTZkYWEzM2I2N2FjNmRmNTZjNzMzYjI0ZTFhNCZjdD1n/110F1JFzWKtiA8/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/eBQqrM0MCGJhu/giphy-downsized-large.gif")!,
        URL(string: "https://media.giphy.com/media/mFdJjYKpSII6JLeiDz/giphy.gif")!,
        URL(string: "https://media.giphy.com/media/YTJXDIivNMPuNSMgc0/giphy.gif")!,
    ]

    func makeUIView(context: UIViewRepresentableContext<AnimatedImageComponent>) -> UIView {
        let view = UIView()
        
        var gifUrl: URL? = nil
        
        switch mood {
            case "Happy":
                gifUrl = happy.randomElement()
            case "Neutral":
                gifUrl = neutral.randomElement()
            case "Sad":
                gifUrl = sad.randomElement()
        default:
            break
        }
        
        URLSession.shared.dataTask(with: gifUrl!) { data, response, error in
            if let error = error {
                print("Error loading GIF data: \(error.localizedDescription)")
                return
            }
        
            if let data = data {
                DispatchQueue.main.async {
                    let gif = FLAnimatedImage(animatedGIFData: data)
                    self.animatedView.animatedImage = gif
                    self.animatedView.contentMode = .scaleToFill

                    self.animatedView.layer.cornerRadius = 10
                    self.animatedView.layer.masksToBounds = true

                    self.animatedView.translatesAutoresizingMaskIntoConstraints = false
                    view.addSubview(self.animatedView)

                    self.animatedView.heightAnchor.constraint(equalToConstant: 250).isActive = true
                    NSLayoutConstraint.activate([
                        self.animatedView.widthAnchor.constraint(equalTo: view.widthAnchor)
                    ])
                }
            }
        }.resume()

        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<AnimatedImageComponent>) {
        
    }
}

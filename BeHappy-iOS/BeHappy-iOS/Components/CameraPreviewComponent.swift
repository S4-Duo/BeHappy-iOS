//
//  CameraView.swift
//  Prototype-AIMoodDetection-IOS
//
//  Created by Reno Muijsenberg on 27/02/2023.
//

import Foundation
import SwiftUI
import AVFoundation

struct CameraPreviewComponent: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    let cameraService: CameraService
    let didFinsishProcessingPhoto: (Result<AVCapturePhoto, Error>) -> ()
    
    static var isCameraAvailable: Bool {
        let discoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: .video,
            position: .back
        )
        return discoverySession.devices.count > 0
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        guard CameraPreviewComponent.isCameraAvailable else {
            return UIViewController()
        }
        
        cameraService.start(delegate: context.coordinator) {err in
            if let err = err as NSError? {
                didFinsishProcessingPhoto(.failure(err))
                return
            }
        }
        
        let viewController = UIViewController()
        viewController.view.backgroundColor = .black
        viewController.view.layer.addSublayer(cameraService.previewLayer)
        cameraService.previewLayer.frame = viewController.view.bounds
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, didFinsishProcessingPhoto: didFinsishProcessingPhoto)
    }

    class Coordinator: NSObject, AVCapturePhotoCaptureDelegate {
        let parent: CameraPreviewComponent
        var didFinsishProcessingPhoto: (Result<AVCapturePhoto, Error>) -> ()

        init(_ parent: CameraPreviewComponent, didFinsishProcessingPhoto: @escaping (Result<AVCapturePhoto, Error>) -> ()) {
            self.parent = parent
            self.didFinsishProcessingPhoto = didFinsishProcessingPhoto
        }
        
        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            if let error = error {
                didFinsishProcessingPhoto(.failure(error))
                return
            }
            
            didFinsishProcessingPhoto(.success(photo))
        }
    }
}

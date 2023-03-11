//
//  HeartRateComponent.swift
//  BeHappy-iOS
//
//  Created by Reno Muijsenberg on 10/03/2023.
//

import SwiftUI
import HealthKit

struct HeartRateComponent: View {
    let healthKitService = HealthKitService()
    
    @State private var hkConnected = false

    @State private var heartRate = 0.0
    @State private var hrv = 0.0
    
    var body: some View {
        VStack {
            HStack {
                Text("Heart Rate")
                    .font(.title2)
                    .bold()
                
                Spacer()
            }
            
            HStack {
                GeometryReader { geometry in
                    Image(systemName: "heart.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.red)
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                        .padding(.leading, 10)
                }
                .padding(10)
                
                Spacer()
                
                VStack {
                    if  hkConnected{
                        Text("HRV: \(hrv, specifier: "%.0f") ms")
                            .font(.title3)
                        Text("Heart Rate: \(Int(heartRate)) bpm")
                            .font(.title3)
                    }
                    else {
                        Text("Health kit is not connected!")
                    }
                }
                .padding(.trailing, 20)
            }
            .background(.white)
            .cornerRadius(10)
            
        }
        .onAppear {
            healthKitService.checkHealthKitConnection() { (connected) in
                hkConnected = connected
                
                if hkConnected {
                    healthKitService.startHeartRateQuery { (heartRate) in
                        self.heartRate = heartRate
                    }
                    
                    healthKitService.startHRVQuery { (hrv) in
                        self.hrv = hrv
                    }
                }
            }
        }
    }
}

struct HeartRateComponent_Previews: PreviewProvider {
    static var previews: some View {
        HeartRateComponent()
    }
}

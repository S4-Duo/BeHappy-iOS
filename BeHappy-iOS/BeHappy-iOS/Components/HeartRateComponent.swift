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
        HStack {
            Image(systemName: "heart.fill")
                .resizable()
                .foregroundColor(.red)
                .padding(10)
                .padding(.leading, 15)
                .padding(.trailing, -15)
                .frame(width: 70, height: 70)
                .aspectRatio(contentMode: .fit)
            
            
            Spacer()
            
            VStack {
                if  hkConnected{
                    Text("HRV: \(hrv, specifier: "%.0f")")
                        .font(.title3)
                    Text("Heart Rate: \(Int(heartRate))")
                        .font(.title3)
                }
                else {
                    Text("Health kit is not connected!")
                }
            }
            .padding(.trailing, 20)
        }
        .background(Color.gray.opacity(0.3))
        .cornerRadius(10)
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

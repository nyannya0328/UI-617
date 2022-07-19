//
//  MotionManager.swift
//  UI-617
//
//  Created by nyannyan0328 on 2022/07/19.
//

import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {
    @Published var manager : CMMotionManager = .init()
    @Published var xValue : CGFloat = 0
    @Published var currentSlider : Place = sample_places.first!
    
    @Published var isTapped :Bool = false
    
    
    func detectMotion(){
        
        if !manager.isDeviceMotionActive{
            
            manager.deviceMotionUpdateInterval = 1 / 40
            manager.startDeviceMotionUpdates(to: .main) {[weak self] motion, err in
                
                if let attitude = motion?.attitude{
                    
                    
                    self?.xValue = attitude.roll
                    print(attitude.roll)
                    
                }
            }
            
        }
        
    }
    
    func RestMotion(){
        
        manager.stopDeviceMotionUpdates()
    }
}


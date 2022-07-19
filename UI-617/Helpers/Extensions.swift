//
//  Extensions.swift
//  UI-617
//
//  Created by nyannyan0328 on 2022/07/19.
//

import SwiftUI

extension View{
    
    @ViewBuilder
    func offsetX(competion : @escaping(CGFloat) -> ()) -> some View{
        
        self
            .overlay {
                
                GeometryReader{proxy in
                    
                    let minX = proxy.frame(in: .global).minX
                    
                    Color.clear
                        .preference(key:OffsetKey.self, value:minX)
                        .onPreferenceChange(OffsetKey.self) { value in
                            competion(value)
                        }
                }
            }
        
        
    }
}

struct OffsetKey : PreferenceKey{
    
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        
        value = nextValue()
    }
}

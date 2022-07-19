//
//  Home.swift
//  UI-617
//
//  Created by nyannyan0328 on 2022/07/19.
//

import SwiftUI

struct Home: View {
    @StateObject var model : MotionManager = .init()
    
    @State var offset : CGFloat = 0
    @State var isTapped : Bool = false
    var body: some View {
        
        GeometryReader{proxy in
             let scrrenSize = proxy.size
            
            
            ZStack(alignment:.top){
                
                
                VStack{
                    
                    DyanmicFileterView(size: scrrenSize)
                    
               
                    
                    Text("Exclusive tips just for you")
                        .font(.custom("GabrielaStencilW00-Lightit", size: 25))
                        .foregroundColor(.white)
                        .padding(.vertical,15)
                    
                    
                    
                    parallaxCards(size:scrrenSize)
                     
                    
                }
                
                
             
                
                
                
                
                
                .padding(15)
                .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
                .background{
                 
                    Color("BG").ignoresSafeArea()
                }
                
             
                
                
            }
            .frame(width: scrrenSize.width,height: scrrenSize.height)
        }
    }
    
    @ViewBuilder
    func DyanmicFileterView(size : CGSize) -> some View{
        
        
        VStack(alignment:.leading,spacing: 25){
            
            Text("Dynamic Tabs")
                .font(.title3)
                .foregroundColor(.white)
            
            
            HStack(spacing:0){
                
                ForEach(sample_places){place in
                    
                    Text(place.placeName)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical,6)
                        .frame(maxWidth: .infinity,alignment: .center)
                
                }
            }
            .overlay(alignment:.leading) {
                
                
                Capsule()
                    .fill(.white)
                    .overlay(alignment:.leading) {
                        
                        
                        GeometryReader{_ in
                            
                            
                            HStack(spacing:0){
                                
                                
                                ForEach(sample_places){place in
                                    
                                    Text(place.placeName)
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity,alignment: .center)
                                        .padding(.vertical,6)
                                        .foregroundColor(.black)
                                        .onTapGesture {
                                            
                                            withAnimation(.easeInOut){
                                                
                                                model.isTapped = true
                                                model.currentSlider = place
                                                
                                                offset = -(size.width) * CGFloat(indexOffset(place: place))
                                                
                                            
                                                
                                            
                                            }
                                        }
                                
                                        
                                }
                                
                            
                            }
                            .offset(x:-TabOffset(size: size, padding: 30))
                            
                        }
                        .frame(width: size.width - 30)
                        
                    }
                    .frame(width:(size.width - 30) / CGFloat(sample_places.count))
                    .mask {
                        Capsule()
                    }
                    .offset(x:TabOffset(size: size, padding: 30))
                    
                
                
                
            }
        }
          .frame(maxWidth: .infinity,alignment: .leading)
          .padding(15)
        
        
    }
    func TabOffset(size : CGSize, padding : CGFloat) -> CGFloat{
        
        
        return (-offset / size.width) * ((size.width - padding) / CGFloat(sample_places.count))
        
        
        
        
    }
    func indexOffset(place : Place) -> Int{
        let index = sample_places.firstIndex { PLASE in
            PLASE == place
        } ?? 0
        
        return index
        
    }
    @ViewBuilder
    func parallaxCards(size : CGSize)->some View{
        
        TabView(selection: $model.currentSlider) {
            
            
            ForEach(sample_places){place in
                
                GeometryReader{proxy in
                     let size = proxy.size
                    ZStack{
                        
                        
                        Image(place.bgName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width:size.width ,height:size.height)
                            .offset(x:model.currentSlider.id == place.id ? -model.xValue * 75 : 0)
                            .clipped()
                        
                        Image(place.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width:size.width ,height:size.height)
                            .offset(x:model.currentSlider.id == place.id ? overalyOffset() : 0)
                            .clipped()
                            .scaleEffect(1.03,anchor: .bottom)
                        
                        
                        VStack(spacing:10){
                            
                            Text("Feautres")
                                .font(.callout)
                                .foregroundColor(.white)
                            
                            Text(place.placeName)
                                .font(.custom("Gabriela Stencil", size: 40))
                                .foregroundColor(.white)
                                .shadow(color :.black.opacity(0.3) ,radius: 5,x: 10,y: 10)
                                .shadow(color :.black.opacity(0.3) ,radius: 15,x: -10,y: 10)
                            
                            
                            Button {
                                
                            } label: {
                                
                                Text("EXPLORE")
                                    .font(.custom("Gabriela Stencil", size: 20))
                                    .foregroundColor(.white)
                                    .padding(.vertical,10)
                                    .padding(.horizontal,20)
                                    .background{
                                     
                                        Rectangle()
                                            .fill(.white.opacity(0.3))
                                        
                                        Rectangle()
                                            .fill(.red.opacity(0.6))
                                    }
                                
                            }
                            .padding(.top,40)

                                
                            
                            
                            
                            
                        }
                        .frame(maxHeight: .infinity,alignment: .top)
                        .padding(.top,60)
                        
                        
                        
                    }
                     .frame(width:size.width ,height:size.height)
                    .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))
                    
                    
                }
                .tag(place)
                .padding(.vertical)
                .padding(.horizontal)
                .offsetX { value in
                    if model.currentSlider == place && !isTapped{
                        
                        offset = value - (size.width * CGFloat(indexOffset(place: place)))
                        
                    }
                    
                    if value == 0 && isTapped{
                        
                        isTapped = false
                    }
                }
            }
            
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onAppear{model.detectMotion()}
        .onDisappear{model.RestMotion()}
        
        
        
        
        
    }
    func overalyOffset()->CGFloat{
        
        let offset = model.xValue * 7
        
        if offset > 0{
            
            return offset > 8 ? 8 : offset
        }
        return -offset > 8 ? 8 : offset
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

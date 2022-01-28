//
//  ContentView.swift
//  Shared
//
//  Created by Shayarneel Kundu on 1/21/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var SphereModel = Sphere()
    @State var radiusString = "1.0"
    
    var body: some View {
        
        VStack{
            Text("Radius")
                .padding(.top)
                .padding(.bottom, 0)
            TextField("Enter Radius", text: $radiusString, onCommit: {Task.init {await self.calculateCircle()}})
                .padding(.horizontal)
                .frame(width: 100)
                .padding(.top, 0)
                .padding(.bottom, 30)
            HStack {
                VStack{
            Text("Volume")
                .padding(.bottom, 0)
            TextField("", text: $SphereModel.VolumeText)
                .padding(.horizontal)
                .frame(width: 100)
                .padding(.top, 0)
                .padding(.bottom,30)
            
        }
        VStack{
            Text("Volume")
                .padding(.bottom, 0)
            Text("\(SphereModel.Volume, specifier: "%.2f")")
                .padding(.horizontal)
                .frame(width: 100)
                .padding(.top, 0)
                .padding(.bottom,30)
                
            }
            }
            HStack{
                VStack{
            Text("Surface Area")
                .padding(.bottom, 0)
            TextField("", text: ( $SphereModel.SurfaceAreaText))
                .padding(.horizontal)
                .frame(width: 100)
                .padding(.top, 0)
                .padding(.bottom, 30)
                }
                VStack{
                    Text("Surface Area")
                        .padding(.bottom, 0)
                    Text("\(SphereModel.SurfaceArea, specifier: "%.2f")")
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                        
                    }

                
                
            }
            
            Button("Calculate", action: {Task.init { await self.calculateCircle()}})
                .padding(.bottom)
                .padding()
                .disabled(SphereModel.EnableButton == false)
            
            
        }
        
    }
    
    func calculateCircle() async {
        
        SphereModel.setButtonEnable(state: false)
        
        let _ : Bool = await SphereModel.initradius(radius: Double(radiusString)!)
        
        
    

}
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}

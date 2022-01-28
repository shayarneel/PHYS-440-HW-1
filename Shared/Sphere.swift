//
//  Sphere.swift
//  HW1
//
//  Created by Shayarneel Kundu on 1/21/22.
//

import SwiftUI

class Sphere: NSObject, ObservableObject {
    
    //Declaring suff radius, coordinates of the centre of the sphere, a variable for the volume, surface area, and a string to recorde the volume anda sirface area. Lastly, we have the enable button to prevent the program from running without inputs, effectively a sanity check.
    var RadiusLength = 0.0
    var CenterOfASphere = (x:0.0, y:0.0, z:0.0)
    @Published var Volume = 1.0
    @Published var SurfaceArea = 1.0
    @Published var VolumeText = ""
    @Published var SurfaceAreaText = ""
    @Published var EnableButton = true
    
    /// initsphere Initializes the sphere and computes the volume and surface area
    /// - Parameters:
    ///   - radius: radius of sphere  (units of length)
    func initradius(radius: Double) async -> Bool {
        
        RadiusLength = radius
              
                   
        let _ = await withTaskGroup(of:  Void.self) { taskGroup in
            
    
        
            taskGroup.addTask { let _ = await self.CalculateVolume(radius: self.RadiusLength)}
            taskGroup.addTask { let _ = await self.CalculateSurfaceArea(radius: self.RadiusLength)}
        
            
            
                
                
        }
            
            await setButtonEnable(state: true)
                                                 
       
        

        return true
        
    }
    
     
    ///Calculatevolume
    ///Computes the volume for a given radius
    /// - Parameters:
    ///   - radius: radius of sphere  (units of length)
    func CalculateVolume(radius: Double) async -> Double {
        
        //Area = (4/3) * pi * r^{3}
        
        let CalculatedVolume = (4.0/3.0) * Double.pi * radius * radius * radius
        let NewVolumeTextString = String(format: "%7.5f", CalculatedVolume)
        
        await UpdateVolume(VolumeTextString: NewVolumeTextString)
        await NewVolumeValue(VolumeValue: CalculatedVolume)
        
        return CalculatedVolume
        
        
    }
    
    ///CalculateSurfaceArea
    ///Computes the Surface Area of  sphere for a given radius
    /// - Parameters:
    ///   - radius: radius of sphere  (units of length)
    func CalculateSurfaceArea(radius: Double) async -> Double {
        
        //Area = 4 * pi * r^{2}
        
        let CalculatedSurfaceArea = 4.0 * Double.pi * radius * radius
        let NewSurfaceAreaTextString = String(format: "%7.5f", CalculatedSurfaceArea)
        
        await UpdateSurfaceArea(SurfaceAreaTextString: NewSurfaceAreaTextString)
        await NewSurfaceAreaValue(SurfaceAreaValue: CalculatedSurfaceArea)
        
        return CalculatedSurfaceArea
        
        
    }
    
    /// setButton Enable
    /// Toggles the state of the Enable Button on the Main Thread
    /// - Parameter state: Boolean describing whether the button should be enabled.
    @MainActor func setButtonEnable(state: Bool){
        
        
        if state {
            
            Task.init {
                await MainActor.run {
                    
                    
                    self.EnableButton = true
                }
            }
            
            
                
        }
        else{
            
            Task.init {
                await MainActor.run {
                    
                    
                    self.EnableButton = false
                }
            }
                
        }
        
    }
    
    /// UpdateVolume and UpdateSurfaceArea
    /// Executes on the main thread
    /// - Parameter areaTextString: Text describing the value of the area
    @MainActor func UpdateVolume(VolumeTextString: String){
        
       VolumeText = VolumeTextString
        
    }
    
    @MainActor func NewVolumeValue(VolumeValue: Double){
        
        self.Volume = VolumeValue
        
    }
    
    @MainActor func NewSurfaceAreaValue(SurfaceAreaValue: Double){
        
        self.SurfaceArea = SurfaceAreaValue
        
    }
    

    @MainActor func UpdateSurfaceArea(SurfaceAreaTextString:String){
        
        SurfaceAreaText = SurfaceAreaTextString
        
        
    }
    
}

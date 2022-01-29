//
//  Sphere.swift
//  HW1
//
//  Created by Shayarneel Kundu on 1/21/22.
//

import SwiftUI

class Sphere: Ellipsoid {
    
    //Declaring suff radius, coordinates of the centre of the sphere, a variable for the volume, surface area, and a string to recorde the volume anda sirface area. Lastly, we have the enable button to prevent the program from running without inputs, effectively a sanity check.
    var RadiusLength = 0.0
    var CenterOfASphere = (x:0.0, y:0.0, z:0.0)
    @Published var BBV = 0.0
    @Published var BBSA = 0.0
    @Published var BBVText = ""
    @Published var BBSAText = ""
    
    
    /// initsphere Initializes the sphere and computes the volume and surface area
    /// - Parameters:
    ///   - radius: radius of sphere  (units of length)
    func initradius(radius: Double) async -> Bool {
        
        RadiusLength = radius
        
        
        let _ = await withTaskGroup(of:  Void.self) { taskGroup in
            
            
            
            taskGroup.addTask { let _ = await self.CalculateVolume(AxisOne: self.RadiusLength, AxisTwo: self.RadiusLength, AxisThree: self.RadiusLength)}
            taskGroup.addTask { let _ = await self.CalculateSurfaceArea(radius: self.RadiusLength)}
            taskGroup.addTask { let _ = await self.CalculateBBVolume(radius: self.RadiusLength)}
            taskGroup.addTask { let _ = await self.CalculateBBSurfaceArea(radius: self.RadiusLength)}
            
            
            
            
            
        }
        
        await setButtonEnable(state: true)
        
        
        
        
        return true
        
    }
    
    
    ///Calculatevolume
    ///Computes the volume for a given radius
    /// - Parameters:
    ///   - radius: radius of sphere  (units of length)
    //func CalculateVolume(radius: Double) async -> Double {
    
    //Area = (4/3) * pi * r^{3}
    
    //let CalculatedVolume = (4.0/3.0) * Double.pi * radius * radius * radius
    //let NewVolumeTextString = String(format: "%7.5f", CalculatedVolume)
    
    //await UpdateVolume(VolumeTextString: NewVolumeTextString)
    //await NewVolumeValue(VolumeValue: CalculatedVolume)
    
    // return CalculatedVolume
    
    
    //}
    
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
    
    
    ///CalculateBoundingBoxVolume
    ///Computes the Volume of the bounding box of a sphere for a given radius
    /// - Parameters:
    ///   - radius: radius of sphere  (units of length)
    func CalculateBBVolume(radius: Double) async -> Double {
        
        //Volume = 8 * r^{3}
        
        let CalculatedBBVolume = 8.0 * pow(radius, 3)
        let NewBBVolumeTextString = String(format: "%7.5f", CalculatedBBVolume)
        
        await UpdateBBVolume(BBVolumeTextString: NewBBVolumeTextString)
        await NewBBVolumeValue(BBVolumeValue: CalculatedBBVolume)
        
        return CalculatedBBVolume
        
        
    }
    
    ///CalculateBoundingBoxSurfaceArea
    ///Computes the Surface Area of the bounding box of a sphere for a given radius
    /// - Parameters:
    ///   - radius: radius of sphere  (units of length)
    func CalculateBBSurfaceArea(radius: Double) async -> Double {
        
        //Volume = 24 * r^{2}
        
        let CalculatedBBSurfaceArea = 24.0 * pow(radius, 2)
        let NewBBSurfaceAreaTextString = String(format: "%7.5f", CalculatedBBSurfaceArea)
        
        await UpdateBBSurfaceArea(BBSurfaceAreaTextString: NewBBSurfaceAreaTextString)
        await NewBBSurfaceAreaValue(BBSurfaceAreaValue: CalculatedBBSurfaceArea)
        
        return CalculatedBBSurfaceArea
        
        
    }
    
    @MainActor func UpdateBBVolume(BBVolumeTextString:String) {
        
        
        BBVText = BBVolumeTextString
        
        
    }
    
    @MainActor func NewBBVolumeValue(BBVolumeValue: Double){
        
        BBV = BBVolumeValue
        
    }
    
    @MainActor func UpdateBBSurfaceArea(BBSurfaceAreaTextString:String) {
        
        
        BBSAText = BBSurfaceAreaTextString
        
        
    }
    
    @MainActor func NewBBSurfaceAreaValue(BBSurfaceAreaValue: Double){
        
        BBSA = BBSurfaceAreaValue
        
    }
}
    
    
    
    
    
    
    
    
    
    
    
    
    


//
//  Ellipsoid.swift
//  HW1
//
//  Created by Shayarneel Kundu on 1/27/22.
//

import SwiftUI

class Ellipsoid: NSObject, ObservableObject {
    
    //Declaring suff radius, coordinates of the centre of the ellipsoid	, a variable for the volume, surface area, and a string to recorde the volume anda sirface area. Lastly, we have the enable button to prevent the program from running without inputs, effectively a sanity check.
    var AxisOneLength = 0.0
    var AxisTwoLength = 0.0
    var AxisThreeLength = 0.0
    var CenterOfEllipsoid = (x:0.0, y:0.0, z:0.0)
    @Published var Volume = 1.0
    @Published var SurfaceArea = 1.0
    @Published var VolumeText = ""
    @Published var SurfaceAreaText = ""
    @Published var EnableButton = true
    
    /// initsphere Initializes the ellipsoid and computes the volume and surface area
    /// - Parameters:
    ///   - AxisOneLength: length of axs of ellipsoid along x-axis  (units of length)
    ///   - AxisTwoLength: length of axs of ellipsoid along y-axis  (units of length)
    ///   - AxisThreeLength: length of axs of ellipsoid along z-axis  (units of length)
    func initradius(AxisOne: Double, AxisTwo: Double, AxisThree: Double) async -> Bool {
        
        AxisOneLength = AxisOne
        AxisTwoLength = AxisTwo
        AxisThreeLength = AxisThree
              
                   
        let _ = await withTaskGroup(of:  Void.self) { taskGroup in
            
    
        
            taskGroup.addTask { let _ = await self.CalculateVolume(AxisOne: self.AxisOneLength, AxisTwo: self.AxisTwoLength, AxisThree: self.AxisThreeLength)}
            taskGroup.addTask { let _ = await self.CalculateSurfaceArea(AxisOne: self.AxisOneLength, AxisTwo: self.AxisTwoLength, AxisThree: self.AxisThreeLength)}
        
            
            
                
                
        }
            
            await setButtonEnable(state: true)
                                                 
       
        

        return true
        
    }
    
     
    ///Calculatevolume
    ///Computes the volume for a given radius
    /// - Parameters:
    ///   - AxisOneLength: length of axs of ellipsoid along x-axis  (units of length)
    ///   - AxisTwoLength: length of axs of ellipsoid along y-axis  (units of length)
    ///   - AxisThreeLength: length of axs of ellipsoid along z-axis  (units of length)
    func CalculateVolume(AxisOne: Double, AxisTwo: Double, AxisThree: Double) async -> Double {
        
        //Area = (4/3) * pi * a * b * c
        
        let CalculatedVolume = (4.0/3.0) * Double.pi * AxisOne * AxisTwo * AxisThree
        let NewVolumeTextString = String(format: "%7.5f", CalculatedVolume)
        
        await UpdateVolume(VolumeTextString: NewVolumeTextString)
        await NewVolumeValue(VolumeValue: CalculatedVolume)
        
        return CalculatedVolume
        
        
    }
    
    ///CalculateSurfaceArea
    ///Computes the Surface Area of  sphere for a given radius
    /// - Parameters:
    ///   - AxisOneLength: length of axs of ellipsoid along x-axis  (units of length)
    ///   - AxisTwoLength: length of axs of ellipsoid along y-axis  (units of length)
    ///   - AxisThreeLength: length of axs of ellipsoid along z-axis  (units of length)
    func CalculateSurfaceArea(AxisOne: Double, AxisTwo: Double, AxisThree: Double) async -> Double {
        
        ///This is a super weird formula, taken from
        ///https://www.web-formulas.com/Math_Formulas/Geometry_Surface_of_Ellipsoid.aspx
        ///
        let powp = pow(AxisOne * AxisTwo, 1.6075) + pow(AxisTwo * AxisThree, 1.6075) + pow(AxisThree * AxisOne, 1.6075)
        let CalculatedSurfaceArea = 4.0 * Double.pi * pow(powp / 3.0, 1.0 / 1.6075)
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

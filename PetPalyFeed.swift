//
//  PetPalyFeed.swift
//  ChenxingOuyangLab 5
//
//  Created by ouyang chenxing on 3/25/17.
//  Copyright © 2017 ouyang chenxing. All rights reserved.
//

import Foundation
class PetPlayFeed{
    
    private (set)var foodLevel:Int
    private (set)var happinessLevel:Int
    private (set)var feedCount:Int
    private (set)var playCount:Int
    private (set)var growthValue:Double
    var name:String?
    
    
    init(name:String){
        self.name = name
        foodLevel = 0
        happinessLevel = 2
        feedCount = 0
        playCount = 0
        growthValue = 0
    }
    
    
    
    func feed(){
        foodLevel = foodLevel + 1
        feedCount += 1
        if (foodLevel<0){
            foodLevel = 0
        }
    }
    func play(){
        if (foodLevel > 0){
            happinessLevel = happinessLevel + 1
            playCount += 1
            foodLevel = foodLevel - 1
        }
    }
    
    func training(){
        if(foodLevel > 6 && happinessLevel > 6){
            happinessLevel = happinessLevel - 1
            foodLevel = foodLevel - 1
            growthValue = growthValue + 0.2
        }
        
    }
}

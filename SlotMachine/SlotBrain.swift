//
//  SlotBrain.swift
//  SlotMachine
//
//  Created by JoeE on 10/26/14.
//  Copyright (c) 2014 JoeE. All rights reserved.
//

import Foundation

class SlotBrain {
    

    class func unpackSlotsIntoSlotRows(slots:[[Slot]]) -> [[Slot]]{
        
        var slotRow:[Slot] = []
        var slotRow2:[Slot] = []
        var slotRow3:[Slot] = []
        
        for slotArray in slots
        {
            
            for var i = 0; i < slotArray.count; i++
            {
                let slot = slotArray[i]
                
                if i == 0
                {
                    slotRow.append(slot)
                    
                }else if i == 1{
                    slotRow2.append(slot)
                }else if i == 2{
                    slotRow3.append(slot)
                }
            }
            
        }
        var slotRows: [[Slot]] = [slotRow, slotRow2 ,slotRow3]
        return slotRows
    }
    
    
    class func computeWinnings(slots: [[Slot]]) -> Int
    {
        var slotsInRows = unpackSlotsIntoSlotRows(slots)
        var winnings = 0
        var flushWinCount = 0
        var threeOfAKindWinCount = 0
        var straightWinCount = 0
        
        for slotRow in slotsInRows
        {
     
            if checkFlush(slotRow)
            {
                winnings += 1
                flushWinCount += 1
                
            }
            
            if flushWinCount == 3 {
                winnings += 15
            }
            
            if checkThreeInARow(slotRow)
            {
                winnings += 10
                straightWinCount += 1
            }
            
            if straightWinCount == 3{
                winnings += 1000
            }
            
            if checkThreeOfaKind(slotRow)
            {
               winnings += 1
                threeOfAKindWinCount += 1
    
            }
            
            if threeOfAKindWinCount == 3
            {
                winnings += 50
            }
        }
        return winnings
        
    }
    
    class func checkFlush(slotRows: [Slot]) -> Bool
    {
        let slot1 = slotRows[0]
        let slot2 = slotRows[1]
        let slot3 = slotRows[2]
        
        if slot1.isRed && slot2.isRed && slot3.isRed
        {
            return true
        }else if !slot1.isRed && !slot2.isRed && !slot3.isRed{
            return true
        }else{
        
        return false
        }
    }
    
    class func checkThreeInARow(slotRow: [Slot]) ->Bool{
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if slot1.value == slot2.value - 1 && slot1.value ==  slot3.value - 2
        {
            return true
            
        }else if slot1.value == slot2.value + 1 && slot1.value == slot3.value + 2{
            return true
        }else{
            
            return false
        }
    }
  
    class func checkThreeOfaKind(slotRow:[Slot]) -> Bool
    {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if slot1.value == slot2.value && slot1.value == slot3.value
        {
            return true
        }else{
            return false
        }
    }
}
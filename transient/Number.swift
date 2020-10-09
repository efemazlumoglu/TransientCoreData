//
//  Number.swift
//  transient
//
//  Created by Efe Mazlumoğlu on 9.10.2020.
//

import Foundation
import CoreData

class Number: NSManagedObject {

    @NSManaged var number: NSNumber
    
    var section: String? {
        print("SECTION")
        switch number.intValue {
        case 0..<60: return "F"
        case 60..<70: return "D"
        case 70..<80: return "C"
        case 80..<90: return "B"
        case 90..<100: return "A"
        default: return "N/A"
        }
    }
}

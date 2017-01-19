//
//  CoreObj+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Phineas_Huang on 18/01/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

import Foundation
import CoreData


extension CoreObj {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreObj> {
        return NSFetchRequest<CoreObj>(entityName: "CoreObj");
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?

}

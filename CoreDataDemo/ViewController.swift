//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Phineas_Huang on 18/01/2017.
//  Copyright © 2017 SunXiaoShan. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).coreDataManager.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for _ in 0...10 {
            insert()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("first .......")
        query()
        
        print("\n\n update .......")
        update()
        print("\n\n show update .......")
        query()
        
        print("\n\n delete .......")
        delete()
        print("\n\n show delete .......")
        query()
    }

    func insert () {
        let obj = CoreObj(context: context)
        let id = Int(arc4random_uniform(100000) + 1)
        obj.id = Int32(id)
        obj.name = "Demo" + String(id)
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func query() {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreObj")
        do {
            // let filterName = "Demo"
            // fetch.predicate = NSPredicate(format: "name == %@", filterName)
            let fetchedEmployees = try context.fetch(fetch) as! [CoreObj]
        
            for obj:CoreObj in fetchedEmployees {
                print("CoreObj: id: \(obj.id)  name:\(obj.name)")
            }
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    func query(context:NSManagedObjectContext) {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreObj")
        do {
            // let filterName = "Demo"
            // fetch.predicate = NSPredicate(format: "name == %@", filterName)
            let fetchedEmployees = try context.fetch(fetch) as! [CoreObj]
            
            for obj:CoreObj in fetchedEmployees {
                print("CoreObj: id: \(obj.id)  name:\(obj.name)")
            }
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    func update() {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreObj")
        do {
            let fetchedEmployees = try context.fetch(fetch) as! [CoreObj]
            
            for obj:CoreObj in fetchedEmployees {
                if obj.id > 10000 {
                    obj.name = "u" + String(Int(arc4random_uniform(100000) + 1))
                }
                print("CoreObj: id: \(obj.id)  name:\(obj.name)")
            }
            try context.save()
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    func delete() {
        let context = CoreDataManager().getNSManagedObjectContext()
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreObj")
        do {
            let request = try context.fetch(fetch) as! [CoreObj]
            
            for obj:CoreObj in request {
                if obj.id > 100 {
                    context.delete(obj)
                }
//                print("CoreObj: id: \(obj.id)  name:\(obj.name)")
            }
            if context.hasChanges {
                try context.save()
            }
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
        print("delete end...")
        self.query(context: context)
    }
}


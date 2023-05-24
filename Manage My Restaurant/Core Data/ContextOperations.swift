//
//  ContextOperations.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 10/04/2023.
//

import Foundation
import CoreData
import CloudKit
import SwiftUI

class ContextOperations {
    
//    Common NSManagedObjectContext operations
    
    static func save(_ viewContext: NSManagedObjectContext) {
        guard viewContext.hasChanges else {return}
        
        do {
            try viewContext.save()
        }
        catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    static func delete(at offsets: IndexSet, fetchResult: FetchedResults<NSManagedObject>, viewContex: NSManagedObjectContext ) {
    
        for index in offsets {
            
            let objectToBeDeleted = fetchResult[index]
            viewContex.delete(objectToBeDeleted)
        }
        save(viewContex)
    }
    
    static func batchDelete(_ entityName: String ,_ viewContext: NSManagedObjectContext) {
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: entityName))
        deleteRequest.resultType = .resultTypeObjectIDs
        
        do {
            let deleteResult = try viewContext.execute(deleteRequest) as? NSBatchDeleteResult
            if let objectIDs = deleteResult?.result as? [NSManagedObjectID] {
        
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: objectIDs], into: [viewContext])
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        save(viewContext)
    }
}




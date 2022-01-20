//
//  CoreDataStack.swift
//  CleanMVVM
//
//  Created by Tom on 2022/01/20.
//

import Foundation
import CoreData

class CoreDataStack {
  
  static let modelName = "Model"
  
  static let model: NSManagedObjectModel = {
    let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
    return NSManagedObjectModel(contentsOf: modelURL)!
  }()
  
  lazy var viewContext: NSManagedObjectContext = {
    return self.persistentContainer.viewContext
  }()
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: CoreDataStack.modelName, managedObjectModel: CoreDataStack.model)
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()
  
  // MARK: Initialization
  init() {}
  
  fileprivate func setBackgroundContext(_ context: NSManagedObjectContext) {
    context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    context.undoManager = nil
  }
  
  func taskContext() -> NSManagedObjectContext {
    let taskContext = persistentContainer.newBackgroundContext()
    setBackgroundContext(taskContext)
    
    return taskContext
  }
  
  func performBackgroundTask(task: @escaping (NSManagedObjectContext) -> Void) {
    persistentContainer.performBackgroundTask { (context) in
      self.setBackgroundContext(context)
      task(context)
    }
  }
}

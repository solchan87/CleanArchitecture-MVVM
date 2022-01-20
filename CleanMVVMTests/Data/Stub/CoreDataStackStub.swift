//
//  CoreDataStackStub.swift
//  CleanMVVMTests
//
//  Created by Tom on 2022/01/20.
//

import CoreData
import Foundation

@testable import CleanMVVM

final class CoreDataStackStub: CoreDataStack {
  override init() {
    super.init()

    let persistentStoreDescription = NSPersistentStoreDescription()
    persistentStoreDescription.url = URL(fileURLWithPath: "/dev/null")

    let container = NSPersistentContainer(
      name: CoreDataStack.modelName,
      managedObjectModel: CoreDataStack.model)
    container.persistentStoreDescriptions = [persistentStoreDescription]

    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }

    self.persistentContainer = container
  }
}

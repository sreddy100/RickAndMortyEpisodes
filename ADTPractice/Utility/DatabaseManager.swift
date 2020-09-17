//
//  DatabaseManager.swift
//  ADTPractice
//
//  Created by Sahil Reddy on 9/10/20.
//  Copyright © 2020 S Reddy. All rights reserved.
//


import Foundation
import CoreData

class DatabaseManager{

    private init() {}

    //Returns the current Persistent Container for CoreData
    class func getContext () -> NSManagedObjectContext {
        return DatabaseManager.persistentContainer.viewContext
    }


    static var persistentContainer: NSPersistentContainer = {
        //The container that holds both data model entities
        let container = NSPersistentContainer(name: Constants.DatabaseManager.projectName)

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */

                //TODO: - Add Error Handling for Core Data

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }


        })
        return container
    }()

    // MARK: - Core Data Saving support
    class func saveContext() {
        let context = self.getContext()
        if context.hasChanges {
            do {
                try context.save()
                print(Constants.DatabaseManager.dataSaved)
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                //You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    /* Support for GRUD Operations */

    // GET / Fetch / Requests
    class func getAllEpisodes() -> Array<EpisodesEntity> {
        let all = NSFetchRequest<EpisodesEntity>(entityName: Constants.DatabaseManager.episodeEntity)
        var allEpisodes = [EpisodesEntity]()

        do {
            let fetched = try DatabaseManager.getContext().fetch(all)
            allEpisodes = fetched
            
        } catch {
            let nserror = error as NSError
            //TODO: Handle Error
            print(nserror.description)
        }

        return allEpisodes
    }

    // Get Episodes by uuid
    class func getEpisodeWith(name: String) -> EpisodesEntity? {
        let requested = NSFetchRequest<EpisodesEntity>(entityName: Constants.DatabaseManager.episodeEntity)
        requested.predicate = NSPredicate(format: "name == %@", name)
        do {
            let fetched = try DatabaseManager.getContext().fetch(requested)
            //fetched is an array we need to convert it to a single object
            if (fetched.count > 1) {
                //TODO: handle duplicate records
            } else {
                return fetched.first //only use the first object..
            }
        } catch {
            let nserror = error as NSError
            //TODO: Handle error
            print(nserror.description)
        }

        return nil
    }

    // REMOVE / Delete
    class func deleteEpisode(with uuid: String) -> Bool {
        let success: Bool = true

        let requested = NSFetchRequest<EpisodesEntity>(entityName: Constants.DatabaseManager.episodeEntity)
        requested.predicate = NSPredicate(format: "uuid == %@", uuid)


        do {
            let fetched = try DatabaseManager.getContext().fetch(requested)
            for ep in fetched {
                DatabaseManager.getContext().delete(ep)
            }
            return success
        } catch {
            let nserror = error as NSError
            //TODO: Handle Error
            print(nserror.description)
        }

        return !success
    }

    
    // Delete ALL Episodes From CoreData
    class func deleteAllEpisodes() {
        do {
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.DatabaseManager.episodeEntity)
            let deleteALL = NSBatchDeleteRequest(fetchRequest: deleteFetch)

            try DatabaseManager.getContext().execute(deleteALL)
            DatabaseManager.saveContext()
        } catch {
            print ("There is an error in deleting records")
        }
    }
    
    //Add to Core Data
    class func addEpisodesToCoreData(_ shows: [Episodes]) {
        
        for show in shows {
            let entity = NSEntityDescription.entity(forEntityName: Constants.DatabaseManager.episodeEntity, in: DatabaseManager.getContext())
            let newShow = NSManagedObject(entity: entity!, insertInto: DatabaseManager.getContext())

//            // Create a unique ID for the Show.
//            let uuid = UUID()
            // Set the data to the entity
            newShow.setValue(show.name, forKey: "name")
            newShow.setValue(show.airDate, forKey: "airDate")
            newShow.setValue(show.created, forKey: "created")
            newShow.setValue(show.characters, forKey: "characters")
            newShow.setValue(show.episode, forKey: "episode")
            newShow.setValue(show.id, forKey: "id")
            
            DatabaseManager.saveContext()
        }
    }
    
    class func addCharactersToCoreData(chars: Characters) {
        let entity = NSEntityDescription.entity(forEntityName: Constants.DatabaseManager.charEntity , in: DatabaseManager.getContext())
        let newCharacter = NSManagedObject(entity: entity!, insertInto: DatabaseManager.getContext())
        
        newCharacter.setValue(chars.created, forKey: "created")
        newCharacter.setValue(chars.episode, forKey: "episode")
        newCharacter.setValue(chars.gender, forKey: "gender")
        newCharacter.setValue(chars.id, forKey: "id")
        newCharacter.setValue(chars.image, forKey: "image")
        newCharacter.setValue(chars.location, forKey: "location")
        newCharacter.setValue(chars.name, forKey: "name")
        newCharacter.setValue(chars.species, forKey: "species")
        newCharacter.setValue(chars.status, forKey: "status")
        newCharacter.setValue(chars.type, forKey: "type")
        newCharacter.setValue(chars.url, forKey: "url")
        
        DatabaseManager.saveContext()

    }
}



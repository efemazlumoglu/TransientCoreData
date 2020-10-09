//
//  AppDelegate.swift
//  transient
//
//  Created by Efe Mazlumoğlu on 9.10.2020.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
            self.saveContext()
    }

    lazy var applicationDocumentsDirectory: NSURL = {
            // The directory the application uses to store the Core Data store file. This code uses a directory named "com.MacCDevTeam.SegueDemo" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return urls[urls.count-1] as NSURL
        }()

        lazy var managedObjectModel: NSManagedObjectModel = {
            // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
            let modelURL = Bundle.main.url(forResource: "Data", withExtension: "momd")
            print(Bundle.main.url(forResource: "Data", withExtension: "momd"))
            return NSManagedObjectModel(contentsOf: modelURL!)!
        }()

        lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
            // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
            // Create the coordinator and store
            var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
            let url = self.applicationDocumentsDirectory.appendingPathComponent("Data.sqlite")
            var error: NSError? = nil
            var failureReason = "There was an error creating or loading the application's saved data."
            do {
                if try coordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil) == nil {
                    coordinator = nil
                    // Report any error we got.
                    let dict = NSMutableDictionary()
                    dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
                    dict[NSLocalizedFailureReasonErrorKey] = failureReason
                    dict[NSUnderlyingErrorKey] = error
                    error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict as? [String : Any])
                    // Replace this with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    NSLog("Unresolved error \(String(describing: error)), \(error!.userInfo)")
                    abort()
                }
            } catch {
                print(error)
            }
            
            return coordinator
        }()

        lazy var managedObjectContext: NSManagedObjectContext? = {
            // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
            let coordinator = self.persistentStoreCoordinator
            if coordinator == nil {
                return nil
            }
            var managedObjectContext = NSManagedObjectContext()
            managedObjectContext.persistentStoreCoordinator = coordinator
            return managedObjectContext
        }()

        // MARK: - Core Data Saving support
        func saveContext () {
            if let moc = self.managedObjectContext {
                let error: NSError? = nil
                if moc.hasChanges {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    NSLog("Unresolved error \(String(describing: error)), \(error!.userInfo)")
                    abort()
                }
            }
        }
    
}


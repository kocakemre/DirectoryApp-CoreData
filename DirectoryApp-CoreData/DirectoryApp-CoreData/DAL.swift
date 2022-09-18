//
//  DAL.swift
//  DirectoryApp-CoreData
//
//  Created by Emre Kocak on 17.09.2022.
//

import Foundation
import CoreData
import UIKit

class DAL {
    
    static func getContext() -> NSManagedObjectContext {
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    static func addPerson(uuid: UUID, name: String, surname: String, numbers: [PersonNumber]) {
        
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)
        
        let person = NSManagedObject(entity: entity!, insertInto: context)
        
        person.setValue(uuid, forKey: "id")
        person.setValue(name, forKey: "name")
        person.setValue(surname, forKey: "surname")
        
      /*  let entityT = NSEntityDescription.entity(forEntityName: "PersonNumber", in: context)
        
        for t in numbers {
           let telefon = NSManagedObject(entity: entityT!, insertInto: context)
           telefon.setValue(uuid, forKey: "personId")
           telefon.setValue(t.number, forKey: "number")
        } */
        
        do {
            try context.save()
        }catch {
            
        }
    }
    
    static func allBringContacts() -> [Person]? {
        
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        do {
            return try getContext().fetch(fetchRequest)
        }catch {
            
        }
        return nil
    }
    
    static func updatePerson() {
        try? getContext().save()
    }
    
    static func deletePerson(person: Person) {
        getContext().delete(person)
        try? getContext().save()
    }
    
    static func createNumber(personId: UUID, no: String) -> PersonNumber {
        
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "PersonNumber", in: context)
        
        let number = NSManagedObject(entity: entity!, insertInto: context) as! PersonNumber
        
        number.setValue(personId, forKey: "personId")
        number.setValue(no, forKey: "number")
        
        return number
    }
    
    static func deleteNumber(number: PersonNumber) {
        getContext().delete(number)
        //try? getContext().save()
    }
    
    static func bringPersonNumber(uuid: UUID) -> [PersonNumber]? {
       
        let fetchRequest : NSFetchRequest<PersonNumber> = PersonNumber.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "personId == %@", uuid as CVarArg)
        
        do
        {
            return try getContext().fetch(fetchRequest)
        }
        catch
        {
            
        }
        
        return nil
    }
    
    static func deletePersonNumber(numberList : [PersonNumber])
    {
        for number in numberList
        {
            deleteNumber(number: number)
        }
    }
    
}

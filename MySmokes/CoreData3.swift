import Foundation
import UIKit
import CoreData

//Запись в CoreData budge

//Создание переменной
var budgeVariable = 0

class mySmokesCoreData3: NSObject {
    
    static let shared = mySmokesCoreData3()
    
    //Данный класс реализует помимо актуализации глобальной переменной реализацию функции budge tabBar Controller. При n = 1 происходит увеличение на 1, n = 2 - уменьшение на единицу, при 0 - наполнение глобальной переменной
    
    func changeBudge(_ n: Int) {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let viewContext = appdelegate.persistentContainer.viewContext
        if let entEntity = NSEntityDescription.entity(forEntityName: "Entity3", in: viewContext){
            if n == 1 {
                budgeVariable += 1
            let entit = NSManagedObject(entity: entEntity, insertInto: viewContext)
            entit.setValue(budgeVariable, forKey: "budge")
            try? viewContext.save()
            }
            if n == 2 {
                delete()
                budgeVariable -= 1
                let entit = NSManagedObject(entity: entEntity, insertInto: viewContext)
                entit.setValue(budgeVariable, forKey: "budge")
                try? viewContext.save()
            }
        }
        if n == 0 {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entity3")
            let request = try! viewContext.fetch(fetchRequest)
            for (_, data) in request.enumerated() {
                if let value = data.value(forKey: "budge") as? Int {
                    budgeVariable = value
                }
        }
        }
    }
    
    //Удаление  всех элементов
    func delete() {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let viewContex = appdelegate.persistentContainer.viewContext
        let fetchRequestEntity = NSFetchRequest<NSManagedObject>(entityName: "Entity3")
        let request = try! viewContex.fetch(fetchRequestEntity)
        for entit in request {
            viewContex.delete(entit)
        }
        try? viewContex.save()
    }
}

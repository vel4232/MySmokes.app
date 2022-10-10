import Foundation
import UIKit
import CoreData

//Запись в CoreData лайков первого уровня

//Создание глобальных переменных, возвращающих значения из coredata
var likeBool: [Bool] = []


class mySmokesCoreData0: NSObject {
    
    static let shared = mySmokesCoreData0()
    
    //Добавление элемента, где при n=1 происходит запись в coreData и наполнение массива, а при n=0 происходит выгрузка из coreData
    
    func addLike(_ like: Bool, _ n: Int) {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let viewContext = appdelegate.persistentContainer.viewContext
        if let entEntity = NSEntityDescription.entity(forEntityName: "Entity0", in: viewContext){
            if n == 1 {
            //Удаление данных, чтобы они не дублировали друг друга
            delete()
            let entit = NSManagedObject(entity: entEntity, insertInto: viewContext)
            entit.setValue(like, forKey: "likes")
                likeBool.append(false)
                try? viewContext.save()
            }
            }
        if n == 0 {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entity0")
            let request = try! viewContext.fetch(fetchRequest)
            for (_, data) in request.enumerated() {
                if let value = data.value(forKey: "likes") as? Bool {
                    likeBool.append(value)
                }
            }
        }
    }
    
    //Изменение значения
    func change(_ i: Int) {
        //Очистка сущности
        delete()
        //Удаление индекса массива, так как массивы  сущности нельзя удалять по номерам
        likeBool[i] = !likeBool[i]
        //Перезапись на основании очищенного массива от требуемого индекса i
        for (k, _) in likeBool.enumerated() {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let viewContext = appdelegate.persistentContainer.viewContext
        if let entEntity = NSEntityDescription.entity(forEntityName: "Entity0", in: viewContext){
            let entit = NSManagedObject(entity: entEntity, insertInto: viewContext)
            entit.setValue(likeBool[k], forKey: "likes")
            try? viewContext.save()
        }
        }
    }
    
    func delete() {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let viewContex = appdelegate.persistentContainer.viewContext
        let fetchRequestEntity = NSFetchRequest<NSManagedObject>(entityName: "Entity0")
        let request = try! viewContex.fetch(fetchRequestEntity)
        for entit in request {
            viewContex.delete(entit)
        }
        try? viewContex.save()
    }
}

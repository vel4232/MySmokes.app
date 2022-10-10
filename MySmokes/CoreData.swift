import Foundation
import UIKit
import CoreData

//Запись в CoreData данных Профиля в целях оперативной загрузки во вкладку Профиль (делегат работает медленнее загрузки во  ViewDidLoad)

//Создание глобальных переменных, возвращающих значения из coredata
var firstName = ""
var secondName = ""
var imageArr = ""
var totalPurchasesCD = ""
var scores = ""
var storiesCountVar = ""
var likeCountVar = ""

class mySmokesCoreData: NSObject {
    
    static let shared = mySmokesCoreData()
    
    //Добавление элемента, где при n=1 происходит запись в coreData и наполнение массива, а при n=0 происходит выгрузка из coreData
    
    func addProfile(_ first: String,_ second: String,_ image: String,_ purch: String,_ scor: String,_ stor: String,_ like: String, _ n: Int) {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let viewContext = appdelegate.persistentContainer.viewContext
        if let entEntity = NSEntityDescription.entity(forEntityName: "Entity", in: viewContext){
            if n == 1 {
            //Удаление данных, чтобы они не дублировали друг друга
            delete()
            let entit = NSManagedObject(entity: entEntity, insertInto: viewContext)
            entit.setValue(first, forKey: "first")
            entit.setValue(second, forKey: "second")
            entit.setValue(image, forKey: "image")
            entit.setValue(purch, forKey: "purchases")
            entit.setValue(scor, forKey: "scores")
            entit.setValue(stor, forKey: "storiesCount")
            entit.setValue(like, forKey: "likeCount")
                try? viewContext.save()
            }
            }
        if n == 0 {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entity")
            let request = try! viewContext.fetch(fetchRequest)
            for (_, data) in request.enumerated() {
                if let value = data.value(forKey: "first") as? String {
                    firstName = value
                }
                if let value = data.value(forKey: "second") as? String {
                    secondName = value
                }
                if let value = data.value(forKey: "image") as? String {
                    imageArr = value
                }
                if let value = data.value(forKey: "purchases") as? String {
                    totalPurchasesCD = value
                }
                if let value = data.value(forKey: "scores") as? String {
                    scores = value
                }
                if let value = data.value(forKey: "storiesCount") as? String {
                    storiesCountVar = value
                }
                if let value = data.value(forKey: "likeCount") as? String {
                    likeCountVar = value
                }
            }
        }

    }
    
    func delete() {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let viewContex = appdelegate.persistentContainer.viewContext
        let fetchRequestEntity = NSFetchRequest<NSManagedObject>(entityName: "Entity")
        let request = try! viewContex.fetch(fetchRequestEntity)
        for entit in request {
            viewContex.delete(entit)
        }
        try? viewContex.save()
    }
}

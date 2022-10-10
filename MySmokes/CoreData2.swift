import Foundation
import UIKit
import CoreData

//Запись в CoreData данных корзины

//Создание глобальных переменных, возвращающих значения из coredata
var tobaccoName: [String] = []
var flavourName: [String] = []
var weightName: [String] = []
var quantityName: [Int] = []
var imageMain: [String] = []
var priceMain: [String] = []

class mySmokesCoreData2: NSObject {
    
    static let shared = mySmokesCoreData2()
    
    //Добавление элемента, где при n=1 происходит запись в coreData и наполнение массива, а при n=0 происходит выгрузка из coreData
    
    func addProfile(_ name: String,_ flavour: String,_ weight: String,_ image: String,_ price: String,_ n: Int) {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let viewContext = appdelegate.persistentContainer.viewContext
        if let entEntity = NSEntityDescription.entity(forEntityName: "Entity2", in: viewContext){
            if n == 1 {
            var check = 0
            let entit = NSManagedObject(entity: entEntity, insertInto: viewContext)
                //Условие увеличения quantity
                for (i,_) in tobaccoName.enumerated() {
                    // При совпадении табака, вкуса и веса
                    if  tobaccoName.count != 0 && name == tobaccoName[i] && flavour == flavourName[i] && weight == weightName[i] {
                        //Изменяем значение массива количества
                            quantityName[i] += 1
                        //Удаляем все сущности
                            delete()
                        //И перезаписываем
                        for (i,_) in tobaccoName.enumerated() {
                            guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                            let viewContext = appdelegate.persistentContainer.viewContext
                            if let entEntity = NSEntityDescription.entity(forEntityName: "Entity2", in: viewContext){
                                let entit = NSManagedObject(entity: entEntity, insertInto: viewContext)
                            entit.setValue(tobaccoName[i], forKey: "tobaccoName")
                            entit.setValue(flavourName[i], forKey: "flavourName")
                            entit.setValue(weightName[i], forKey: "weight")
                            entit.setValue(imageMain[i], forKey: "picture")
                            entit.setValue(priceMain[i], forKey: "price")
                            entit.setValue(quantityName[i], forKey: "quantity")
                            try? viewContext.save()
                            }
                        }
                        //Переменная запрета на сохранение глобальных переменных
                        check = 1
                    }
                }
                if check == 0 {
                        //Не только наполнение глубокой памяти, но и корректировка уже существующих массивов, загруженных на ViewController1
                        entit.setValue(name, forKey: "tobaccoName")
                            tobaccoName.append(name)
                        entit.setValue(flavour, forKey: "flavourName")
                            flavourName.append(flavour)
                        entit.setValue(weight, forKey: "weight")
                            weightName.append(weight)
                        entit.setValue(image, forKey: "picture")
                            imageMain.append(image)
                        entit.setValue(price, forKey: "price")
                            priceMain.append(price)
                        entit.setValue(1, forKey: "quantity")
                            quantityName.append(1)
                            try? viewContext.save()
                }
            }
        if n == 0 {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entity2")
            let request = try! viewContext.fetch(fetchRequest)
            for (_, data) in request.enumerated() {
                if let value = data.value(forKey: "tobaccoName") as? String {
                    tobaccoName.append(value)
                }
                if let value = data.value(forKey: "flavourName") as? String {
                    flavourName.append(value)
                }
                if let value = data.value(forKey: "weight") as? String {
                    weightName.append(value)
                }
                if let value = data.value(forKey: "picture") as? String {
                    imageMain.append(value)
                }
                if let value = data.value(forKey: "price") as? String {
                    priceMain.append(value)
                }
                if let value = data.value(forKey: "quantity") as? Int {
                    quantityName.append(value)
                }
            }
        }
        }
    }
    
    //Уменьшение количества на 1
    func decreaseQuant(_ k: Int) {
        //Изменяем значение массива количества
            quantityName[k] -= 1
        //Удаляем все сущности
            delete()
        //И перезаписываем
        for (i,_) in tobaccoName.enumerated() {
            guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let viewContext = appdelegate.persistentContainer.viewContext
            if let entEntity = NSEntityDescription.entity(forEntityName: "Entity2", in: viewContext){
                let entit = NSManagedObject(entity: entEntity, insertInto: viewContext)
            entit.setValue(tobaccoName[i], forKey: "tobaccoName")
            entit.setValue(flavourName[i], forKey: "flavourName")
            entit.setValue(weightName[i], forKey: "weight")
            entit.setValue(imageMain[i], forKey: "picture")
            entit.setValue(priceMain[i], forKey: "price")
            entit.setValue(quantityName[i], forKey: "quantity")
            try? viewContext.save()
            }
        }
    }
    
    //Удаление элемента с индексом i
    func deleteWithIndex(_ i: Int) {
        //Очистка сущности
        delete()
        //Удаление индекса массива, так как массивы  сущности нельзя удалять по номерам
        tobaccoName.remove(at: i)
        flavourName.remove(at: i)
        weightName.remove(at: i)
        imageMain.remove(at: i)
        priceMain.remove(at: i)
        quantityName.remove(at: i)
        //Перезапись на основании очищенного массива от требуемого индекса i
        for (i, _) in tobaccoName.enumerated() {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let viewContext = appdelegate.persistentContainer.viewContext
        if let entEntity = NSEntityDescription.entity(forEntityName: "Entity2", in: viewContext){
            let entit = NSManagedObject(entity: entEntity, insertInto: viewContext)
            entit.setValue(tobaccoName[i], forKey: "tobaccoName")
            entit.setValue(flavourName[i], forKey: "flavourName")
            entit.setValue(weightName[i], forKey: "weight")
            entit.setValue(imageMain[i], forKey: "picture")
            entit.setValue(priceMain[i], forKey: "price")
            entit.setValue(quantityName[i], forKey: "quantity")
            try? viewContext.save()
        }
        }
        
    }
    
    //Удаление  всех элементов
    func delete() {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let viewContex = appdelegate.persistentContainer.viewContext
        let fetchRequestEntity = NSFetchRequest<NSManagedObject>(entityName: "Entity2")
        let request = try! viewContex.fetch(fetchRequestEntity)
        for entit in request {
            viewContex.delete(entit)
        }
        try? viewContex.save()
    }
}


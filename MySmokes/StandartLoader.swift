import Foundation

//Главная: 1,2,3 уровни

//протокол 1 уровня
protocol CategoriesLoaderDelegate {
    func loaded(categories: [FirstLevel])
}

//создание глобальной переменной для rating
var myRating1 = 0

// Парсинг 1 уровня
class StandartLoader {
    //делегат категорий
    var delegate: CategoriesLoaderDelegate?
    
    var tobaccoURL = "https://vk.com/doc70963297_646833541?hash=cHYCQI6ALCEZ2XXwjJfWX4fMQOtmUtHqoGYxIhDEs6z&dl=a3AR99m97kDnIovDmyq8E83ZUEcQhiiwMuB9XMfIT18"
    var coalURL = "https://vk.com/doc70963297_646832601?hash=CTB6nJT3ZcDJT5v3RWJKAaZBgqXbCYA957xDFsgJPuT&dl=q6ATHXXtDyE11EVdaEg71IA6yDzE2DY8MiAot0UrXPL"
 
    // Парсинг категорий
    func standartloadCategories(_ k: Int) {
        var changeURL = ""
        switch k {
        case 0 :
        //Табак
        changeURL = tobaccoURL
        case 1:
        //Уголь
        changeURL = coalURL
        default: changeURL = "" }
        let url = URL(string:changeURL)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? NSDictionary {
                var categories: [FirstLevel] = []
                for (_, data) in jsonDict {
                    if let category = FirstLevel(data: data as! NSDictionary) {
                        categories.append(category)
                    }
                }
                DispatchQueue.main.async {
                self.delegate?.loaded(categories: categories)
                }
            }
    }
        task.resume()
    }
    
    //Парсинг отзывов. k - наименование товара (main section), n - IndexPath первый уровень, o - IndexPath.section второй уровень, l -  IndexPath третий
    func reviewsRating(_ k: Int,_ n: Int,_ o: Int, _ l: Int) {
        var changeURL = ""
        switch k {
        case 0 :
        //Табак
        changeURL = tobaccoURL
        case 1:
        //Уголь
        changeURL = coalURL
        default: changeURL = "" }
        let url = URL(string:changeURL)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? NSDictionary {
                var categories: [FirstLevel] = []
                var lines: [SecondLevel] = []
                var flavours: [ThirdLevel] = []
                for (_, data) in jsonDict {
                    if let category = FirstLevel(data: data as! NSDictionary) {
                        categories.append(category)
                    }
                }
                for (_,data) in categories[n].lines.enumerated() {
                if let subcategory = SecondLevel(data: data as! NSDictionary) {
                    lines.append(subcategory)
            }
                }
                for (_,data) in lines[o].flavours.enumerated() {
                    if let subsubcategory = ThirdLevel(data: data as! NSDictionary) {
                flavours.append(subsubcategory)
            }
                }
                DispatchQueue.main.async {
                    myRating1 = Int(flavours[l].myrating)!
                }
            }
    }
        task.resume()
    }
}

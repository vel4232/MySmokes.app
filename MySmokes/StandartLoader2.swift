import Foundation

//Профиль:  главная, заказы, избранное

//протокол 1 уровня
protocol CategoriesLoaderDelegateProfile {
    func loaded(profile: [MainMenu])
}

// Парсинг 1 и 2 уровней
class StandartLoader2 {
    //делегат категорий
    var delegate: CategoriesLoaderDelegateProfile?
 
    var profileURL = "https://vk.com/doc70963297_646832603?hash=uYIRZ33uyUzNpdX1jMlcshaBOVWFbSQi2QSNZQBeUoz&dl=SlpeYLylbeVmDSS0EA6jJH80mv4qdFPezYjc0eS9a4P"
    
    // Парсинг категорий, подкатегорий
    func standartloadCategories() {
        let url = URL(string: profileURL)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? NSDictionary {
                var profile: [MainMenu] = []
                    for (_, data) in jsonDict {
                        if let profil = MainMenu(data: data as! NSDictionary) {
                            profile.append(profil)
                        }
                }
                DispatchQueue.main.async {
                    mySmokesCoreData.shared.addProfile(profile[0].firstname, profile[0].secondname, profile[0].picture, profile[0].totalpurchases, profile[0].loyalty, String(profile[0].stories.count),String(profile[0].liked.count), 1)
                self.delegate?.loaded(profile: profile)
                }
            }
    }
        task.resume()
    }
}

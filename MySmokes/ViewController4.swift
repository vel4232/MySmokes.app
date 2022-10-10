import UIKit
import SDWebImage

class ViewController4: UIViewController {
    
    var profile: [MainMenu] = []
    var like: [Liked] = []
    var story: [Story] = []
 
    @IBOutlet weak var mainName: UILabel!
    
    @IBOutlet weak var secondMainName: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var purchsasesLabel: UILabel!
    
    @IBOutlet weak var scoresLabel: UILabel!
    
    @IBOutlet weak var profileTableView: UITableView!
    
    struct PROF {
        var picture: [UIImage] = []
        var label1: [String] = []
    }
    
    class prof {
        static func prof1() -> [PROF] {
            return [
                PROF(picture: [UIImage(named: "profile1")!, UIImage(named: "profile2")!,  UIImage(named: "profile3")!, UIImage(named: "profile4")!], label1: ["Мои заказы", "Избранное", "Программа лояльности",  "Центр поддержки"])
            ]
        }
    }
    
    var prof2 = prof.prof1()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loader = StandartLoader2()
        loader.delegate = self
        loader.standartloadCategories()
        profileTableView.isScrollEnabled = false
        mySmokesCoreData.shared.addProfile("", "", "", "", "","","", 0)
        mainName.text = "\(firstName) \(secondName)"
        secondMainName.text = "\(firstName) \(secondName)"
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.sd_setImage(with: URL(string:imageArr))
        purchsasesLabel.text = totalPurchasesCD
        scoresLabel.text = scores
    }
    

}

extension ViewController4: CategoriesLoaderDelegateProfile{
    func loaded(profile: [MainMenu]) {
        self.profile = profile
        profileTableView.reloadData()
    }
}

extension ViewController4: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prof2[0].picture.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Profile") as! TableViewCell2
        let dataProfile: [String] = ["Всего \(storiesCountVar) заказа", "\(likeCountVar) позиций", "Имеется \(scores) баллов", "Ваше пожелание или проблема"]
        cell.layer.cornerRadius = 15
        cell.profileCell.image = prof2[0].picture[indexPath.row]
        cell.profileCellLabel1.text = prof2[0].label1[indexPath.row]
        cell.profileCellLabel2.text = dataProfile[indexPath.row]
        cell.layer.borderWidth = 3
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  90
    }
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        //История
        if indexPath.row == 0 {
        //Переход с container view по navigation controller на View Controller 4.2
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "ViewController4.3") as! ViewController43
        self.navigationController?.pushViewController(viewController, animated: true)
        //Передача данных нажатой ячейки на View Controller 43
        //Передача данных Истории
            // Запрет на дублирование массива
            if story.count == 0 && profile.count != 0 {
        for (_,data) in profile[0].stories.enumerated() {
            if let storyy = Story(data: data as! NSDictionary) {
        story.append(storyy)
    }
        }
            }
        viewController.story1 = story
    }
        
        //Лайки
        if indexPath.row == 1 {
        //Переход с container view по navigation controller на View Controller 4.2
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "ViewController4.2") as! ViewController42
        self.navigationController?.pushViewController(viewController, animated: true)
        //Передача данных нажатой ячейки на View Controller 42
        //Передача данных Избранного
            // Запрет на дублирование массива
            if like.count == 0 && profile.count != 0 {
        for (_,data) in profile[0].liked.enumerated() {
            if let likee = Liked(data: data as! NSDictionary) {
        like.append(likee)
    }
        }
            }
        viewController.like1 = like
    }
        
        //Лояльность
        if indexPath.row == 2 {
        //Переход с container view по navigation controller на View Controller 4.4
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "ViewController4.4") as! ViewController44
        self.navigationController?.pushViewController(viewController, animated: true)
        //Передача данных нажатой ячейки на View Controller 44
    }
        
        //Поддержка
        if indexPath.row == 3 {
        //Переход с container view по navigation controller на View Controller 4.5
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "ViewController4.5") as! ViewController45
        self.navigationController?.pushViewController(viewController, animated: true)
        //Передача данных нажатой ячейки на View Controller 45
    }
    }
    
    //Переход к настройкам
    
    @IBAction func installButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segue41", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let detailVC = segue.destination as! ViewController41
            detailVC.profile = profile
      }
}


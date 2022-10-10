import UIKit
import SDWebImage

class ViewController1: UIViewController {

    
    @IBOutlet weak var firstLevelTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var segmentedControl1: UISegmentedControl!
    
    //новая кнопка лайков
    var newlikeBool: [Bool] = []
    //работа SearchBar
    //Вышел ли за пределы наименований
    var searchActive : Bool = false
    //Новые массивы
    //Имя
    var filtered:[String] = []
    //Картинка
    var newPicture: [String] = []
    //Позиция
    var newPosition: [String] = []
    //Трансформация FirstLevel -> String
    var data: [String] = []
    //Новые индексы
    var newIndex: [Int] = []
    //Новые lines
    var newLines: [Int] = []
    //Новые quantity
    var newQuantity: [Int] = []
    
    //Старые lines
    var oldLines: [Int] = []
    //Старые quantity
    var oldQuantity: [Int] = []
    
    //Для метода Делегата
    var indexRow = -1
    
    //Определяет какая секция выбрана: табак, уголь, прочее
    var mainSection = 0
    
    // Коррекция  String
    var correct = ""
    
    
    var categories: [FirstLevel] = []
    var lines: [SecondLevel] = []
    var flavStrong: [ThirdLevel] = []
    var flavoursQuantity: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mySmokesCoreData0.shared.addLike(false, 0)
        //Вызов данных из сети и реализация метода делегата
        let loader = StandartLoader()
        loader.delegate = self
        loader.standartloadCategories(mainSection)
        
        //Наполнение CoreData Профиля
        let loader2 = StandartLoader2()
        loader2.standartloadCategories()
        
        //Оформление SegmentedControl
        segmentedControl1.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl1.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        
        //Наполнение массивов Корзины (для отражения индекса количества товара в корзине)
        mySmokesCoreData2.shared.addProfile("", "", "", "", "", 0)
        //Наполнение массива баджа
        mySmokesCoreData3.shared.changeBudge(0)
        budgeApply()
        
        //Оформление searchBar
        searchBar.searchTextField.textColor = .gray
        searchBar.barTintColor  = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Placeholder search bar
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Поиск...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
    func budgeApply() {
        let tabBar = tabBarController?.tabBar
        let budgeTapBar = tabBar?.items![2]
        if budgeVariable != 0 {
        budgeTapBar!.badgeValue = "\(budgeVariable)"
        budgeTapBar!.badgeColor = UIColor.red
        } else {
            budgeTapBar!.badgeValue = nil
            budgeTapBar!.badgeColor = nil
        }
    }
    
    @IBAction func segmentControl1(_ sender: UISegmentedControl) {
        sender.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        sender.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        switch sender.selectedSegmentIndex {
        case 0:
            let loader = StandartLoader()
            loader.delegate = self
            mainSection = 0
            loader.standartloadCategories(mainSection)
        case 1:
            let loader = StandartLoader()
            loader.delegate = self
            mainSection = 1
            loader.standartloadCategories(mainSection)
        default:
            let loader = StandartLoader()
            loader.delegate = self
            mainSection = 1
            loader.standartloadCategories(mainSection)
        }
    }
}

extension ViewController1: CategoriesLoaderDelegate, indexPathLike2 {
    //Реализация метода делегата получения данных парсинга
    func loaded(categories: [FirstLevel]) {
        self.categories = categories
        firstLevelTableView.reloadData()
    }
    //Получения номера нажатой ячейки
    func buttonClickAtIndexLike(indexRow: Int) {
        self.indexRow = indexRow
        //Действие кнопки лайков
        mySmokesCoreData0.shared.change(indexRow)
        firstLevelTableView.reloadData()
    }
}

extension ViewController1: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if filtered.count == 0 {
            searchActive = false;
        } else {
            searchActive = true;
            newlikeBool = []
            newIndex = []
            newPicture = []
            newLines = []
            newQuantity = []
            newPosition = []
            for (i, _) in categories.enumerated() {
                for k in 0..<filtered.count {
                    if filtered[k] == categories[i].name1 {
                        newIndex.append(i)
                    }
                }
            }
            //Запись новой картинки
            for (_,data) in newIndex.enumerated() {
                newPicture.append(categories[data].picture1)
                newLines.append(oldLines[data])
                newQuantity.append(oldQuantity[data])
                newPosition.append(categories[data].position1)
                newlikeBool.append(likeBool[data])
            }
        }
        firstLevelTableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive == true {
            return filtered.count
        }
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstLevel") as! TableViewCell1
        let model = categories [indexPath.row]
        //Наполнение первого уровня для searchBar - наполнение data
        if data.count == 0 {
        for i in 0..<categories.count {
            data.append(categories[i].name1)
        }
        }
        //Наполнение второго и третьего уровней каждого табака для определения количества линеек и вкусов
        lines = []
        flavStrong = []
        flavoursQuantity = []
        for (_,data) in categories[indexPath.row].lines.enumerated() {
        if let subcategory = SecondLevel(data: data as! NSDictionary) {
            lines.append(subcategory)
    }
        }
        oldLines.append(lines.count)
        for i in 0...lines.count - 1 {
            for (_,data) in lines[i].flavours.enumerated() {
                if let subsubcategory = ThirdLevel(data: data as! NSDictionary) {
            flavStrong.append(subsubcategory)
        }
            }
            for _ in 0...flavStrong.count - 1 {
                flavoursQuantity.append(1)
            }
        }
        cell.delegate = self
        cell.indexRow = indexPath.row
        oldQuantity.append(flavoursQuantity.count)
        if likeBool.count != categories.count {
        mySmokesCoreData0.shared.addLike(false, 1)
        }
        //При использовании search bar
        if searchActive == true {
        cell.layer.cornerRadius = 15
            if newlikeBool[indexPath.row] == true {
            cell.likeButton.setImage(UIImage(named: "like1"), for: .normal)
            } else {
                cell.likeButton.setImage(UIImage(named: "unlike1"), for: .normal)
            }
        cell.firstlevelImage.layer.cornerRadius = cell.firstlevelImage.frame.size.width/2
        cell.firstNumberLabel.text = "\(newLines[indexPath.row]) линеек / \(newQuantity[indexPath.row]) вкусов"
        cell.firstNameLabel.text = filtered[indexPath.row]
            cell.firstTotalRatingLabel.text = "#\(newPosition[indexPath.row])"
        cell.layer.borderWidth = 3
        cell.firstlevelImage.sd_setImage(with: URL(string:newPicture[indexPath.row]))
        } else {
        //Дефолтные значения
            if likeBool[indexPath.row] == true {
            cell.likeButton.setImage(UIImage(named: "like1"), for: .normal)
            } else {
                cell.likeButton.setImage(UIImage(named: "unlike1"), for: .normal)
            }
            cell.layer.cornerRadius = 15
            cell.firstNumberLabel.text = "\(lines.count) линеек / \(flavoursQuantity.count) вкусов"
            cell.firstlevelImage.layer.cornerRadius = cell.firstlevelImage.frame.size.width/2
            cell.firstTotalRatingLabel.text = "#\(model.position1)"
            cell.firstNameLabel.text = model.name1
            cell.layer.borderWidth = 3
            cell.firstlevelImage.sd_setImage(with: URL(string:model.picture1))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  90
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if let indexPath = sender as? Int {
            //Переписываем на "язык" фильтации
            var newIndexPath = 0
            if searchActive == true {
            for (i, _) in categories.enumerated() {
                if filtered[indexPath] == categories[i].name1 {
                        newIndexPath = i
                    }
            }
            } else {newIndexPath = indexPath}
            let detailVC = segue.destination as! ViewController2
            //Номер ячейки
            detailVC.indexPath2 = newIndexPath
            //Массив данных уровня 1
            detailVC.categories = categories
            //Категоря товара - секция
            detailVC.mainSection = mainSection
            //Название Марки табака
            detailVC.tobaccoName1 = categories[newIndexPath].name1
            //WebSite
            detailVC.webSite1 = categories[newIndexPath].website1
          }
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        performSegue(withIdentifier: "segue1", sender: indexPath.row)
    }
}

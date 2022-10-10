
import UIKit
import SDWebImage

class ViewController2: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var flavoursLabel: UILabel!
    
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var secondlevelTableView: UITableView!
    
    @IBOutlet weak var segmentedControl2: UISegmentedControl!
    
    //1 уровень
    var tobaccoName1 = ""
    var webSite1 = ""
    
    //2,3 уровни
    var lines: [SecondLevel] = []
    var flavours: [ThirdLevel] = []
    var flavours2: [ThirdLevel] = []
    var mainSection = 0
    
    //загружаем данные с первого уровня и индекс  пас
    var categories: [FirstLevel] = []
    var indexPath2 = 0
    
    //для Segmented control
    var n = 0
    
    //Для подробности
    var prof2 = prof.prof1()
    struct PROF {
        var label1: [String] = []
    }
    
    //Для "Подробности"
    //Крепкость
    var avstrong: [Int] = []
    //Страна
    var country = ""
    //Количество вкусов
    var flavoursQuantity: [Int] = []
    var flavStrong: [ThirdLevel] = []
    
    class prof {
        static func prof1() -> [PROF] {
            return [
                PROF(label1: ["Рейтинг"]),
                PROF(label1: ["Крепкость", "Страна", "Количество линеек",  "Количество вкусов"]),
                PROF(label1: ["Описание"])
            ]
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Убрать сепаратор между ячейками
        secondlevelTableView.separatorStyle = .none
        //Первичный данные
        image2.sd_setImage(with: URL(string:categories[indexPath2].picture1))
        nameLabel.text = categories[indexPath2].name1
        flavoursLabel.text = "\(categories[indexPath2].lines.count)" +  " " + "линеек"
        //Настройка графики сегментед  контрол
        segmentedControl2.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl2.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        //Наполнение lines - второго уровня
        for (_,data) in categories[indexPath2].lines.enumerated() {
        if let subcategory = SecondLevel(data: data as! NSDictionary) {
            lines.append(subcategory)
    }
        }
        // Наполнение переменных "Подробности"
        for i in 0...lines.count - 1 {
            for (_,data) in lines[i].flavours.enumerated() {
                if let subsubcategory = ThirdLevel(data: data as! NSDictionary) {
            flavStrong.append(subsubcategory)
        }
            }
            country = flavStrong[0].country
            for i in 0...flavStrong.count - 1 {
                avstrong.append (Int(flavStrong[i].strong) ?? 0)
                flavoursQuantity.append(1)
            }
        }
    }
}


extension ViewController2: UITableViewDataSource, UITableViewDelegate {
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            n = 0
            secondlevelTableView.separatorStyle = .none
            secondlevelTableView.reloadData()
        } else {
            n = 1
            secondlevelTableView.separatorStyle = .singleLine
            secondlevelTableView.reloadData()
        }
    }
    
    //Таблица второго уровня
    
    //Количество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        if n == 0 {return prof2.count}
        else {return lines.count}
    }
    //Разбивка по секциям
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if n == 0 {return prof2[section].label1.count}
        else {return lines[section].flavours.count}
    }
    //Высота ячеек
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Ставим автоматическое определение
        return  UITableView.automaticDimension
    }
    //Определение всех параметров Header (view, title) - управление Header, за исключением Высоты
    func  tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if n == 0 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0))
            view.backgroundColor = .black
            return view
        }
        else {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
        view.backgroundColor = .black
            let  subview = UIView(frame: CGRect(x: 0, y: 25, width: tableView.frame.width, height: 0.3))
        subview.backgroundColor = .white
        let  title = UILabel(frame: CGRect(x: 20, y: 5, width: tableView.frame.width, height: 15))
        title.text = lines[section].line
        title.backgroundColor = .black
        title.textColor = .white
        view.addSubview(subview)
        view.addSubview(title)
        return view
        }
    }
    //Определение высоты Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if n == 0 {return 0}
        else {
            return 25
        }
    }
    //Добавляем footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height))
        if section != 2 {
            let  subview = UIView(frame: CGRect(x: 20, y: 1, width: tableView.frame.width, height: 0.3))
        subview.backgroundColor = .white
            view.addSubview(subview)
        }
            return view
    }
    //Высота footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if n == 0 {return 0}
        else {
            return 10
        }
    }
    //Определение самих ячеек
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Значение для Подробностей
        if n == 0 {
            let menu = prof2[indexPath.section].label1[indexPath.row]
            var menu2: [String] = []
            if avstrong.min() == avstrong.max() {
            menu2 = ["\(avstrong.min() ?? 0) из 10","\(country)","\(lines.count)","\(flavoursQuantity.count)"]
            } else {
            menu2 = ["\(avstrong.min() ?? 0) - \(avstrong.max() ?? 0) из 10","\(country)","\(lines.count)","\(flavoursQuantity.count)"]
            }
            switch menu {
            case "Рейтинг": let cell = tableView.dequeueReusableCell(withIdentifier: "SecondLabelDescription3") as! TableViewCell1
                cell.selectionStyle = .none
                return cell
            case "Крепкость", "Страна", "Количество линеек", "Количество вкусов" : let cell = tableView.dequeueReusableCell(withIdentifier: "SecondLabelDescriprion") as! TableViewCell1
                cell.label1.text = menu
                cell.label2.text = menu2[indexPath.row]
                cell.selectionStyle = .none
                return cell
            default: let cell = tableView.dequeueReusableCell(withIdentifier: "SecondLabelDescription2") as! TableViewCell1
                cell.descLabel.text = categories[indexPath2].description1
                cell.selectionStyle = .none
                    return cell
            }
        }
        else {
        //Значение для Вкусов
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondLevel") as! TableViewCell1
        flavours = []
        //Загружаем 3 уровень на основании indexPath.section второго уровня
        for (_,data) in lines[indexPath.section].flavours.enumerated() {
            if let subsubcategory = ThirdLevel(data: data as! NSDictionary) {
        flavours.append(subsubcategory)
    }
        }
        // Передаем в tableviewCell значения 3 уровня на основании Header 2 уровня
        let model = flavours[indexPath.row]
        cell.secondNameLabel.text = model.flavour
        cell.secondHashTagLabel.text = model.hashtag
        cell.totalRatingLabel.text = model.totalrating
        cell.totalRatingLabel.layer.cornerRadius = 7
        cell.secondFrame.layer.cornerRadius = 3
        cell.secondNumberLabel.text = "\(indexPath.row + 1)"
        return cell
        }
    }
    //Команда при  нажатии на ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        if n == 0 {}
        else {
            //Загружаем 3 уровень на основании indexPath.section второго уровня
            flavours2 = []
            for (_,data) in lines[indexPath.section].flavours.enumerated() {
                if let subsubcategory = ThirdLevel(data: data as! NSDictionary) {
            flavours2.append(subsubcategory)
        }
            }
        performSegue(withIdentifier: "segue2", sender: indexPath)
        }
    }
//    Передача данных
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if let indexPath = sender as? IndexPath {
                let detailVC = segue.destination as! ViewController3
                detailVC.flavours = flavours2
                detailVC.indexPath3 = indexPath.row
                detailVC.indexPath2 = indexPath2
                detailVC.tobaccoName2 = tobaccoName1
                detailVC.webSite2 = webSite1
                detailVC.mainSection = mainSection
                detailVC.indexPathSection = indexPath.section
                myRating1 = Int(flavours[indexPath.row].myrating)!
              }
          }
    
}


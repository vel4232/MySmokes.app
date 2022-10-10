import UIKit
import SDWebImage

class ViewController43: UIViewController {
    
    //История уровень 1, история уровень 2
    var story1: [Story] = []
    var story2: [Story2] = []
    
    //Для метода делегата 1
    var indexRow = -1
    var indexSection = -1
    
    //Для метода делегата 2
    var indexRow2 = -1
    var indexSection2 = -1
    
    //Для суммы
    var summSumm: [Int] = []
    var story5: [Story2] = []
    
    @IBOutlet weak var likeTableView: UITableView!
    
    
    //Действие кнопки покупки всего заказа
    @IBAction func reBuyButton(_ sender: Any) {
        var story4: [Story2] = []
        for (_,data) in story1[indexSection2].story.enumerated() {
            if let storyy = Story2(data: data as! NSDictionary) {
        story4.append(storyy)
    }
        }
        for i in 0..<story4.count {
            for _ in 0..<Int(story4[i].quantity)! {
                mySmokesCoreData2.shared.addProfile(story4[i].tobacco, story4[i].flavour, story4[i].weight, story4[i].picture, story4[i].price, 1)
                mySmokesCoreData3.shared.changeBudge(1)
                budgeApply()
            }
        }
    }
    
    //Действие  кнопки покупки части заказа
    @IBAction func reBuyItemButton(_ sender: Any) {
        var story3: [Story2] = []
        for (_,data) in story1[indexSection].story.enumerated() {
            if let storyy = Story2(data: data as! NSDictionary) {
        story3.append(storyy)
    }
        }
        for _ in 0..<Int(story3[indexRow-1].quantity)! {
            mySmokesCoreData2.shared.addProfile(story3[indexRow-1].tobacco, story3[indexRow-1].flavour, story3[indexRow-1].weight, story3[indexRow-1].picture, story3[indexRow-1].price, 1)
            mySmokesCoreData3.shared.changeBudge(1)
            budgeApply()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Мои заказы"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        summSumm = []
        for i in 0..<story1.count {
            story5 = []
        for (_,data) in story1[i].story.enumerated() {
            if let storyy = Story2(data: data as! NSDictionary) {
        story5.append(storyy)
    }
        }
            var summ1 = 0
            for i in 0..<story5.count {
                summ1 += Int(story5[i].quantity)! * Int(story5[i].price)!
            }
            summSumm.append(summ1)
        }
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
}

//Extension делегата 1,2
extension ViewController43: indexPathStories, indexPathStories2 {
    func buttonClickAtIndex(indexRow: Int, indexSection: Int) {
        self.indexRow=indexRow
        self.indexSection = indexSection
    }
    func buttonClickAtIndex2(indexRow2: Int, indexSection2: Int) {
        self.indexRow2=indexRow2
        self.indexSection2 = indexSection2
    }
}

extension ViewController43: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return story1[section].story.count + 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return story1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = story1[indexPath.section].story.count
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Sum") as! TableViewCell2
            cell.summLabel.text = "ИТОГО \(summSumm[indexPath.section]) ₽"
            cell.selectionStyle = .none
            return cell
        case 1..<index + 1:
        let cell = tableView.dequeueReusableCell(withIdentifier: "Stories") as! TableViewCell2
        story2 = []
        //Загружаем 2 уровень истории на основании indexPath.section первого уровня
        for (_,data) in story1[indexPath.section].story.enumerated() {
            if let storyy = Story2(data: data as! NSDictionary) {
        story2.append(storyy)
    }
        }
//         Передаем в tableviewCell значения 2 уровня истории на основании Header 1 уровня
        let model = story2[indexPath.row-1]
        cell.storyImage.layer.cornerRadius = 10
        cell.nameStoryLabel.text = model.tobacco + ", Вкус " + model.flavour
        cell.quantityLabel.text = model.quantity + " шт."
        cell.weightLabel.text = "уп." + model.weight + " гр"
            cell.delegate = self
            cell.indexRow = indexPath.row
            cell.indexSection = indexPath.section
        cell.storyImage.sd_setImage(with: URL(string:model.picture))
        cell.selectionStyle = .none
        return cell
        default: let cell = tableView.dequeueReusableCell(withIdentifier: "Button") as! TableViewCell2
            cell.delegate2 = self
            cell.indexRow2 = indexPath.row
            cell.indexSection2 = indexPath.section
        return cell
        }
    }
    //Определение всех параметров Header (view, title) - управление Header, за исключением Высоты
    func  tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //Создаем цвет
        let myGray = UIColor(named: "myGray")
        let myGreen = UIColor(named: "myGreen")
        // Основной view
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height))
        view.backgroundColor = .black
        //Нижний subview
        let subview1 = UIView(frame: CGRect(x: 0, y: 15, width: tableView.frame.width, height: 30))
        subview1.backgroundColor = myGray
        subview1.layer.cornerRadius = 7
        view.addSubview(subview1)
        //Нижний subview
        //Закрытие нижних границ при cornerRadius
        let subview2 = UIView(frame: CGRect(x: 0, y: 40, width: tableView.frame.width, height: 40))
        subview2.backgroundColor = myGray
        view.addSubview(subview2)
        //Title 1
        let  title1 = UILabel(frame: CGRect(x: 20, y: 25, width: tableView.frame.width, height: 15))
        title1.text = "Заказ № \(story1[section].order)"
        title1.backgroundColor = myGray
        title1.textColor = .white
        view.addSubview(title1)
        //Title2
        let  title2 = UILabel(frame: CGRect(x: 20, y: 50, width: tableView.frame.width, height: 15))
        title2.text = "Дата доставки \(story1[section].date)"
        title2.backgroundColor = myGray
        title2.textColor = myGreen
        view.addSubview(title2)
        //Добавить subview к view
        return view
    }
    //Определение высоты Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 70
    }
    //Добавляем footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let myGray = UIColor(named: "myGray")
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height))
        view.backgroundColor = .black
        let  subview2 = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
        subview2.backgroundColor = myGray
        view.addSubview(subview2)
        let  subview1 = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
        subview1.backgroundColor = myGray
        subview1.layer.cornerRadius = 7
        view.addSubview(subview1)
        return view
    }
    //Высота footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}



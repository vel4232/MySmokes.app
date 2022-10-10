import UIKit
import SDWebImage

class ViewController5: UIViewController {
    
    
    @IBOutlet weak var confirmButton2: UIButton!
    
    //UILabels
    @IBOutlet weak var totalQuantity: UILabel!
    
    @IBOutlet weak var totalSumm: UILabel!
    
    @IBOutlet weak var totalLoyalty: UILabel!
    
    @IBOutlet weak var totalLoyalty2: UILabel!
    
    @IBOutlet weak var superSumm: UILabel!
    
    @IBOutlet weak var binTableView: UITableView!
    
    @IBOutlet weak var basicLoyalty: UILabel!
    
    @IBOutlet weak var switch2: UISwitch!
    
    //ContainerView
    @IBOutlet weak var bin2ContainerView: UIView!
    
    //Кнопка перехода к оформлению
    @IBAction func confirmButton(_ sender: Any) {
        performSegue(withIdentifier: "Confirm", sender: sender)
    }
    
    //UISwitch
    @IBAction func binSwitch(_ sender: UISwitch) {
        if sender.isOn {
            totalSummInt = priceMainInt - (Int(scores) ?? 0)
            superSumm.text = "\(totalSummInt)" + " ₽"
            totalLoyalty.alpha = 1
            totalLoyalty2.alpha = 1
            loyaltyBool = true
        } else {
            totalSummInt = priceMainInt
            superSumm.text = "\(totalSummInt)" + " ₽"
            totalLoyalty.alpha = 0
            totalLoyalty2.alpha = 0
            loyaltyBool = false
        }
    }
    
    //Загрузка данных профиля
    var profile: [MainMenu] = []
    
    //Для определения первой суммы
    var priceMainInt = 0
    
    //Для определения второй суммы
    var totalSummInt = 0
    
    //Количество
    var quantity = 0
    
    //Для метода делегате
    var index = -1
    
    //Лояльность
    var loyaltyBool = true
    
    //Для Баджа
    var budgeNumber = 0
    
    // UIButton
    @IBAction func plusButton(_ sender: Any) {
        //Вызов функции добавления элемента
        mySmokesCoreData2.shared.addProfile(tobaccoName[index], flavourName[index], weightName[index], imageMain[index], priceMain[index], 1)
        calc()
        mySmokesCoreData3.shared.changeBudge(1)
        budgeApply()
    }
    @IBAction func minusButton(_ sender: Any) {
        if quantityName[index] != 1 {
        //Вызов функции удаления элемента
        mySmokesCoreData2.shared.decreaseQuant(index)
        }
        calc()
        if budgeVariable != 1 {
        mySmokesCoreData3.shared.changeBudge(2)
        budgeApply()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton2.layer.cornerRadius = 5
        //Вызов функции парсинга
        let loader = StandartLoader2()
        loader.delegate = self
        loader.standartloadCategories()
        //Изменение размеров UISwitch
        switch2.transform = CGAffineTransform(scaleX: 1.2, y: 1.0)
        navigationItem.hidesBackButton =  true
        binTableView.reloadData()
    }
    
    //viewWillAppear вызывается каждый раз, когда представление вот-вот появится, независимо  от  того, находится ли оно уже в памяти или нет. В данном случае прогрузка ViewController5 уже находится в памяти при первичной загрузке и при каждом появление данного окна происходит операция  внутри viewWIllAppear, то есть в нашем случае обновление TableView
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mySmokesCoreData.shared.addProfile("", "", "", "", "","","", 0)
        calc()
        containerView()
        binTableView.reloadData()
    }
    
    //Функция счетчика
    func calc() {
        quantity = 0
        for (_,data) in quantityName.enumerated() {
            quantity += data
        }
        totalQuantity.text = "\(quantity)" + " шт."
        //Счетчик первой суммы c обнулением
        priceMainInt = 0
        for (i, _) in priceMain.enumerated() {
            priceMainInt += (Int(priceMain[i]) ?? 0) * quantityName[i]
        }
        totalSumm.text = "\(priceMainInt)" + " ₽"
        //Определить через JSON!!!!
        basicLoyalty.text = "В наличии \(scores) баллов"
        //Надо сделать if пересчета лояльности с  учетом суммы  купленного товара!!!
        if (Int(scores) ?? 0) < priceMainInt {
        totalLoyalty.text = scores + " ₽"
        totalSummInt = priceMainInt - (Int(scores) ?? 0)
        } else {
            totalLoyalty.text = "\(String(priceMainInt)) ₽"
            totalSummInt = priceMainInt - priceMainInt
        }
        superSumm.text = "\(totalSummInt)" + " ₽"
        binTableView.reloadData()
    }
    
    //Функция баджа
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
    //Функция containerView
    func containerView() {
        if tobaccoName.count == 0 {
            self.bin2ContainerView.isHidden = false
        } else {
            self.bin2ContainerView.isHidden = true
        }
    }
}

//Extension делегата кнопки
extension ViewController5: indexPath {
    func buttonClickAtIndex(index: Int) {
        self.index=index
    }
}

//Extension делегата данных профиля
extension ViewController5: CategoriesLoaderDelegateProfile{
    func loaded(profile: [MainMenu]) {
        self.profile = profile
    }
}

extension ViewController5: UITableViewDataSource, UITableViewDelegate {
    
    //Количество ячеек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tobaccoName.count
    }
    //Высота ячеек
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
    //Определение самих ячеек
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "binTable") as! TableViewCell3
        cell.mainImage.sd_setImage(with: URL(string:imageMain[indexPath.row]))
        cell.tobaccoLabel.text = "Табак: " +  tobaccoName[indexPath.row]
        cell.flavourLabel.text = "Вкус: " + flavourName[indexPath.row]
        cell.weightLabel.text = "Вес: " + weightName[indexPath.row] + " гр."
        cell.quantityLabel.text = "Количество: " + "\(quantityName[indexPath.row])" + " шт."
        cell.priceLabel.text = priceMain[indexPath.row] + " ₽"
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 5
        cell.layer.borderColor = UIColor.black.cgColor
        //Передача по методу делегата индекс ячейки
        cell.delegate = self
        cell.index = indexPath.row
        return cell
    }
    //Команда при  нажатии на ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        navigationController?.navigationBar.topItem?.title = ""
    }
    //Изменение название при удалении посредством слайдинга
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Удалить"
    }
    //Удаление при слайдинге
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Действие бадж
            for _ in 0..<quantityName[indexPath.row] {
                mySmokesCoreData3.shared.changeBudge(2)
                budgeApply()
            }
            //  Удалить элемент  из Core Data
            mySmokesCoreData2.shared.deleteWithIndex(indexPath.row)
            //Обновить инфу ниже таблицы
            calc()
            containerView()
        }
    }
    
    //Переход на VC51
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Confirm" {
            let detailVC = segue.destination as! ViewController51
            detailVC.profile = profile
            detailVC.quantity =  quantity
                detailVC.quantitySumm = priceMainInt
            if loyaltyBool == true {
                if (Int(scores) ?? 0) < priceMainInt {
                    detailVC.loyalty = (Int(scores) ?? 0)
                } else {
                    detailVC.loyalty = priceMainInt
                }
            } else {
                detailVC.loyalty = 0
            }
                detailVC.totalSumm = totalSummInt
      }
    }
}




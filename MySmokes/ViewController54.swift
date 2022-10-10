import UIKit

class ViewController54: UIViewController {
    
    //Данные профиля
    var profile1: [MainMenu] = []
    var address: [Address] = []
    var indexPath = 0
    
    //Данные заказа
    var quantity = 0
    var quantitySumm = 0
    var loyalty = 0
    var totalSumm = 0
    
    @IBOutlet weak var finalConfirmButton2: UIButton!
    
    
    //Галочка
    var yesBool = [false, false]
    
    @IBOutlet weak var confirm4TableView: UITableView!
    
    //Данные  View
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var quantitySummLabel: UILabel!
    
    @IBOutlet weak var deliveryLabel: UILabel!
    
    @IBOutlet weak var loyaltyLabel: UILabel!
    
    @IBOutlet weak var totalSummLabel: UILabel!
    
    //Кнопка подтверждения
    @IBAction func finalConfirmButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "ConfirmationVC") as! ViewController55
        mySmokesCoreData2.shared.delete()
        tobaccoName = []
        flavourName = []
        weightName = []
        quantityName = []
        imageMain = []
        priceMain = []
        mySmokesCoreData3.shared.delete()
        budgeVariable = 0
        budgeApply()
        self.navigationController?.pushViewController(viewController, animated: true)
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
    
    
    //Наполнение таблицы
    var label1 = ["Оплата при получении","Оплата онлайн-картой"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        finalConfirmButton2.layer.cornerRadius = 5
        navigationController?.navigationBar.topItem?.title = ""
        confirm4TableView.isScrollEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        quantityLabel.text = "\(quantity) шт."
        quantitySummLabel.text = "\(quantitySumm) ₽"
        deliveryLabel.text = "0 ₽"
        loyaltyLabel.text = "\(loyalty) ₽"
        totalSummLabel.text = "\(totalSumm) ₽"
    }
}

extension ViewController54: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return label1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Confirm4") as! TableViewCell3
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 3
        cell.buyMethodLabel.text = label1[indexPath.row]
        if yesBool[indexPath.row] == true {
            cell.yesImageView.image = UIImage(named: "profile6")
        } else {
            cell.yesImageView.image = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        if indexPath.row == 0 {
        yesBool[0] = !yesBool[0]
        yesBool[1] = false
        } else {
            yesBool[1] = !yesBool[1]
            yesBool[0] = false
        }
        
        confirm4TableView.reloadData()
    }
    
}

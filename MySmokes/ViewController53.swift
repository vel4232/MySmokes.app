import UIKit

class ViewController53: UIViewController {
    
    //Данные профиля
    var profile1: [MainMenu] = []
    var address: [Address] = []
    var indexPath = 0
    
    //Данные заказа
    var quantity = 0
    var quantitySumm = 0
    var loyalty = 0
    var totalSumm = 0
    
    //Наполнение таблицы 1
    var label1 = ["Город","Улица","Дом","Квартира"]
    var label2 = ["","","",""]
    
    @IBAction func nextButton2(_ sender: Any) {
        performSegue(withIdentifier: "Confirm4", sender: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = ""
        //Наполнение таблицы 2
        if indexPath != 0 {
            label2 = [address[indexPath-1].city,address[indexPath-1].street,address[indexPath-1].streetnumber,address[indexPath-1].apartmentnumber]
        } else {
            label2 = ["","","",""]
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Далее", style: .plain, target: self, action: #selector(nextButton2(_:)))
    }
}

extension ViewController53: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return label1.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Confirm31") as! TableViewCell3
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 3
        cell.categoryLabel.text = label1[indexPath.row]
        cell.subjectLabel.text = label2[indexPath.row]
        return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Confirm32") as! TableViewCell3
            cell.layer.cornerRadius = 15
            cell.layer.borderWidth = 3
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    //Переход на VC53
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Confirm4" {
            let detailVC = segue.destination as! ViewController54
            detailVC.profile1 = profile1
            detailVC.address = address
            detailVC.indexPath = indexPath
            detailVC.quantity = quantity
            detailVC.quantitySumm = quantitySumm
            detailVC.loyalty = loyalty
            detailVC.totalSumm = totalSumm
      }
    }
    
}

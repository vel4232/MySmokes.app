import UIKit

class ViewController51: UIViewController {
    
    //Данные профиля
    var profile: [MainMenu] = []
    var address: [Address] = []
    
    //Данные заказа
    var quantity = 0
    var quantitySumm = 0
    var loyalty = 0
    var totalSumm = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = ""
        for (_,data) in profile[0].address.enumerated() {
            if let subprofile = Address(data: data as! NSDictionary) {
        address.append(subprofile)
    }
        }
    }
}

extension ViewController51: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + address.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Confirm1") as! TableViewCell3
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 3
        if indexPath.row == 0 {
            cell.addressLabel.text = "Новый адрес"
        } else {
        cell.addressLabel.text = "\(address[indexPath.row-1].street),\(address[indexPath.row-1].streetnumber), г. \(address[indexPath.row-1].city)"
        cell.imageConfirmImage.image = UIImage(named: "profile5")!
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Confirm2" {
        if let indexPath = sender as? Int {
            let detailVC1 = segue.destination as! ViewController52
            print(indexPath)
            detailVC1.indexPath = indexPath
            detailVC1.profile1 = profile
            detailVC1.address = address
            detailVC1.indexPath = indexPath
            detailVC1.quantity = quantity
            detailVC1.quantitySumm = quantitySumm
            detailVC1.loyalty = loyalty
            detailVC1.totalSumm = totalSumm
          }
        }
      }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        navigationController?.navigationBar.topItem?.title = ""
        performSegue(withIdentifier: "Confirm2", sender: indexPath.row)
    }
    
}


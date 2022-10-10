import UIKit

class ViewController42: UIViewController {
    
    var like1: [Liked] = []
    var like2: [Liked2] = []
    
    @IBOutlet weak var likeTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ViewController42: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return like1[section].like.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return like1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Likes") as! TableViewCell2
        like2 = []
        //Загружаем 2 уровень лайков на основании indexPath.section первого уровня
        for (_,data) in like1[indexPath.section].like.enumerated() {
            if let likee = Liked2(data: data as! NSDictionary) {
        like2.append(likee)
    }
        }
//         Передаем в tableviewCell значения 2 уровня лайков на основании Header 1 уровня
        let model = like2[indexPath.row]
        cell.layer.cornerRadius = 15
        cell.likeImage.layer.cornerRadius = 10
        cell.likeMainNameLabel.text = model.name
        cell.likeHashtagLabel.text = model.hashtag
        cell.likeImage.sd_setImage(with: URL(string:model.picture))
        cell.layer.borderWidth = 3
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        like1[section].kind
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.tintColor = UIColor.black
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}


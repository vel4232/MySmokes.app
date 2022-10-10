import UIKit

class ViewController55: UIViewController {
    
    
    @IBOutlet weak var acceptButton2: UIButton!
    
    @IBAction func acceptButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "ViewController5") as! ViewController5
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        acceptButton2.layer.cornerRadius = 5
        navigationItem.title = "Оформление заказа"
        navigationItem.hidesBackButton =  true
    }
}

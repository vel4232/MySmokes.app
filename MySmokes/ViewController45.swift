import UIKit

class ViewController45: UIViewController {

    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var helpField: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helpField.layer.borderColor = UIColor.white.cgColor
        helpField.layer.borderWidth = 1
        helpField.layer.cornerRadius = 5
        addButton.layer.cornerRadius = 2
        
    }
    

   
}

import UIKit

//Протокол для передачи значения indexPath ячейки
protocol indexPath {
    func buttonClickAtIndex(index: Int)
}

class TableViewCell3: UITableViewCell {
    
    //Вспомогательные переменные метода протокола
    var delegate: indexPath?
    var index = -1

    //Ячейка товара
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var tobaccoLabel: UILabel!
    
    @IBOutlet weak var flavourLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
   //Кнопки для реализации метода делегата
    
    func buttonClick(_ sender: UIButton) {
        self.delegate?.buttonClickAtIndex(index: sender.tag)
    }
    
    @IBAction func plusButton2(_ sender: Any) {
        delegate?.buttonClickAtIndex(index: index)
    }
    
    @IBAction func minusButton2(_ sender: Any) {
        delegate?.buttonClickAtIndex(index: index)
    }
    
    //Оформление Шаг 1
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var imageConfirmImage: UIImageView!
    
    //Оформление Шаг 2
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var subjectLabel: UILabel!
    
    //Делегат свитч
    @IBOutlet weak var switchUIswitch: UISwitch!
    
    //Оформление Шаг 3
    @IBOutlet weak var category2Label: UILabel!
    
    @IBOutlet weak var subject2Label: UILabel!
    
    //Делегат
    @IBOutlet weak var textfield: UITextField!
    
    //Оформление Шаг 4
    @IBOutlet weak var buyMethodLabel: UILabel!
    @IBOutlet weak var yesImageView: UIImageView!
    
    
}

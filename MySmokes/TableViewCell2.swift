import UIKit

//Протокол для передачи значения indexPath (row и section) ячейки 1
protocol indexPathStories {
    func buttonClickAtIndex(indexRow: Int,indexSection: Int)
}

//Протокол для передачи значения indexPath (row и section) ячейки 2
protocol indexPathStories2 {
    func buttonClickAtIndex2(indexRow2: Int,indexSection2: Int)
}

class TableViewCell2: UITableViewCell {
    
    //Вспомогательные переменные метода протокола 1
    var delegate: indexPathStories?
    var indexRow = -1
    var indexSection = -1
    
    //Вспомогательные переменные метода протокола 2
    var delegate2: indexPathStories2?
    var indexRow2 = -1
    var indexSection2 = -1
    
    //Профиль - Главное

    @IBOutlet weak var profileCell: UIImageView!
    
    @IBOutlet weak var profileCellLabel1: UILabel!
    
    
    @IBOutlet weak var profileCellLabel2: UILabel!
    
    
    //Профиль - Избранное
    
    
    @IBOutlet weak var likeImage: UIImageView!
    
    @IBOutlet weak var likeMainNameLabel: UILabel!

    @IBOutlet weak var likeHashtagLabel: UILabel!
    
    
    //Профиль - Истории
    
    //Отображение 1
    
    @IBOutlet weak var storyImage: UIImageView!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var nameStoryLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    
    //Отображение 2
    @IBOutlet weak var summLabel: UILabel!
    
    //Метод делегата кнопок 1
    func buttonClick(_ sender: UIButton) {
        self.delegate?.buttonClickAtIndex(indexRow: sender.tag, indexSection: sender.tag)
    }
    
    //Метод делегата кнопок 2
    func buttonClick2(_ sender: UIButton) {
        self.delegate2?.buttonClickAtIndex2(indexRow2: sender.tag, indexSection2: sender.tag)
    }
    
    //Делегат кнопки покупки всего заказа
    @IBAction func reBuyButton2(_ sender: Any) {
        delegate2?.buttonClickAtIndex2(indexRow2: indexRow2, indexSection2: indexSection2)
    }
    
    //Делега кнопки покупки единицы заказа
    @IBAction func reBuyItemButton2(_ sender: Any) {
        delegate?.buttonClickAtIndex(indexRow: indexRow, indexSection: indexSection)
    }
    
    
    // Настройки
      
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var subLabel: UILabel!
    
    
}

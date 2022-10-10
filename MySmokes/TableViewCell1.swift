import UIKit

//Протокол для передачи значения indexPath.row
protocol indexPathLike2{
    func buttonClickAtIndexLike(indexRow: Int)
}

//Главная

class TableViewCell1: UITableViewCell {
    
    //Метод протокола
    var delegate: indexPathLike2?
    var indexRow = -1

    //Первый уровень
    
    @IBOutlet weak var firstlevelImage: UIImageView!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var firstNumberLabel: UILabel!
    
    @IBOutlet weak var firstTotalRatingLabel: UILabel!
    
    //Делегат кнопки лайков
    
    func buttonClickLike(_ sender: UIButton) {
        self.delegate?.buttonClickAtIndexLike(indexRow: sender.tag)
    }
    
    @IBAction func firstLevelLikeButtonDelegate(_ sender: Any) {
        delegate?.buttonClickAtIndexLike(indexRow: indexRow)
    }
    
    //Кнопка для изменения картинки
    @IBOutlet weak var likeButton: UIButton!
    
    
    //Второй уровень
    
    //Таблица  Вкусов
    @IBOutlet weak var secondLikeImage: UIImageView!
    
    @IBOutlet weak var secondNumberLabel: UILabel!
    
    @IBOutlet weak var secondNameLabel: UILabel!
    
    @IBOutlet weak var secondHashTagLabel: UILabel!
    
    @IBOutlet weak var totalRatingLabel: UILabel!
    
    @IBOutlet weak var secondFrame: UIView!
    
    //Таблица Подробностей
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    
    //Третий уровень
    
    //TableViewCell 1
    
    @IBOutlet weak var thirdLevelHashtagLabel: UILabel!
    
    @IBOutlet weak var msRatingLabel: UILabel!
    
    @IBOutlet weak var myRatingLabel: UILabel!
    
    
    @IBOutlet weak var numberLabel: UILabel!
    
    // Вьюшки
    
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var view3: UIView!
    
    //Кнопки для делегата
    
    
    @IBOutlet weak var ratingChoice2: UIButton!
    
    
    @IBOutlet weak var reviewsButton2: UIButton!
    
    //TableViewCell 2
    
    @IBOutlet weak var strongLable: UILabel!
    
    //TableViewCell 3
    
    @IBOutlet weak var countryLabel: UILabel!
    
    //TableViewCell 4
    
    @IBOutlet weak var webSiteLabel: UILabel!
    
    
    @IBOutlet weak var reviewLabel: UILabel!
    
    //TableViewCell 5
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //Делегат Collection View
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Делегат кнопки покупки
    @IBOutlet weak var buyButton: UIButton!
    
    
    @IBOutlet weak var pwLabel: UILabel!
    
    //Четвертый уровень
    
    @IBOutlet weak var reviewsImage: UIImageView!
    
    @IBOutlet weak var commentInfoLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    //Рейтинг
    
    @IBOutlet weak var myOwnRatingLabel: UILabel!
    
    @IBOutlet weak var myRatingCancelLabel: UILabel!
    
    
}

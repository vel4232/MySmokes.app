import UIKit
import SDWebImage

class ViewController3: UIViewController {
    
    @IBOutlet weak var thirdLevelTableView: UITableView!
    
    @IBOutlet weak var thirdLevelImage: UIImageView!
    
    //Переход на определение моего рейтинга
    @IBAction func ratingButton(_ sender: Any) {
        performSegue(withIdentifier: "ratingChoice", sender: nil)
    }
    
    
    //Для определения действия
    @IBAction func buyButton2(_ sender: Any) {
//        Наполнение массива CoreData2 -  корзина
        for i in 0...specialPrice.count - 1 {
        mySmokesCoreData2.shared.addProfile(tobaccoName2, flavours[indexPath3].flavour, specialWeight[i], flavours[indexPath3].picture2, specialPrice[i], 1)
            mySmokesCoreData3.shared.changeBudge(1)
            budgeApply()
        }
    }
    
    //Для перехода на Отзывы
    @IBAction func reviewsButton(_ sender: Any) {
        performSegue(withIdentifier: "reviewsSegue", sender: nil)
    }
    
    
    //Название табака и website
    var tobaccoName2 = ""
    var webSite2 = ""
    
    //Перенос данных с предыдущего уровня и загрузка TableView и CollectionView
    var flavours: [ThirdLevel] = []
    var order: [FourthLevel] = []
    //Третий уровень
    var indexPath3 = 0
    //Второй уровень
    var indexPathSection = 0
    //Первый уровень
    var indexPath2 = 0
    //Категория товара
    var mainSection = 0
    
    //Для количества и цены нажатия CollvetionView
    var specialWeight: [String] = []
    var specialPrice: [String] = []
    
    //Для определения общей суммы
    var priceSum = 0
    var weightSum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = flavours[indexPath3].flavour
        thirdLevelTableView.rowHeight = UITableView.automaticDimension
        thirdLevelTableView.estimatedRowHeight = UITableView.automaticDimension
        thirdLevelImage.sd_setImage(with: URL(string:flavours[indexPath3].picture2))
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        //Загрузка  веса и цены
        for (_, data) in flavours[indexPath3].order.enumerated() {
            if let order1 = FourthLevel(data: data as! NSDictionary) {
                order.append(order1)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        thirdLevelTableView.reloadData()
    }
    
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
}

extension ViewController3: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdLevel1") as! TableViewCell1
            cell.thirdLevelHashtagLabel.text = flavours[indexPath3].hashtag
            cell.reviewLabel.text = "\(flavours[indexPath3].review.count)"
            cell.msRatingLabel.text = flavours[indexPath3].totalrating
            if myRating1 == 0 {
            cell.myRatingLabel.text = "-"
            } else {
                cell.myRatingLabel.text = "\(myRating1)"
            }
            //Необходимо создать счеткик на сервере
            cell.numberLabel.text = "344 оценки"
            cell.view1.layer.cornerRadius = 10
            cell.view2.layer.cornerRadius = 10
            cell.view3.layer.cornerRadius = 10
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdLevel2") as! TableViewCell1
            //Определение крепкости
            switch flavours[indexPath3].strong {
            case "1","2","3","4":
                cell.strongLable.text = "Низкая крепкость (\(flavours[indexPath3].strong) из 10)"
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
            case "5","6","7":
                cell.strongLable.text = "Средняя крепкость (\(flavours[indexPath3].strong) из 10)"
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
            default:
                cell.strongLable.text = "Высокая крепкость (\(flavours[indexPath3].strong) из 10)"
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdLevel3") as! TableViewCell1
            cell.countryLabel.text = flavours[indexPath3].country
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdLevel4") as! TableViewCell1
            cell.webSiteLabel.text =  webSite2
            cell.tintColor = UIColor.white
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdLevel5") as! TableViewCell1
            cell.descriptionLabel.text = flavours[indexPath3].description
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.collectionView.delegate = self
            cell.buyButton.layer.cornerRadius = 10
            cell.pwLabel.text = "Стоимость \(priceSum) рублей за \(weightSum) грамм табака"
            return cell
        }
    }
    
    //Добавляем footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height))
        if section != 4 {
            let  subview = UIView(frame: CGRect(x: 20, y: 0.3, width: 400, height: 0.3))
        subview.backgroundColor = .white
            view.addSubview(subview)
        }
            return view
    }
    //Высота footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 5
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
}

extension ViewController3: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  order.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Buy1", for:  indexPath) as! CollectionViewCell1
        cell.weightLabel.text = order[indexPath.row].weight
        cell.priceLabel.text =  order[indexPath.row].price
        cell.backgroundColor = .darkGray
        cell.layer.cornerRadius = 3
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath)?.backgroundColor == .darkGray {
            //Случай при  первом нажатии
            collectionView.cellForItem(at: indexPath)?.backgroundColor = .systemBlue
            specialWeight.append(order[indexPath.row].weight)
            specialPrice.append(order[indexPath.row].price)
        }
        else {
            //Случай при втором нажатии
            collectionView.cellForItem(at: indexPath)?.backgroundColor = .darkGray
            for (i, data) in specialPrice.enumerated() {
                if data == order[indexPath.row].price {
                    specialPrice.remove(at: i)
                }
            }
            for (i, data) in specialWeight.enumerated() {
                if data == order[indexPath.row].weight{
                    specialWeight.remove(at: i)
                }
            }
        }
        priceSum = 0
        weightSum = 0
        for (i,_) in specialPrice.enumerated() {
            priceSum += Int(specialPrice[i]) ?? 0
            weightSum += Int(specialWeight[i]) ?? 0
        }
        thirdLevelTableView.reloadData()
    }
    
    //    Передача данных
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if let detailVC = segue.destination as? ViewController31 {
                    detailVC.indexPath4 = indexPath3
                    detailVC.flavours2 = flavours
                }
                //Делегат протокола VC32
                if let detailVC2 = segue.destination as? ViewController32 {
                    detailVC2.delegate = self
                }
            }
}

//Метод делегата от  ViewController32
extension ViewController3: reviewsProtocol {
    func ratingValue(_ value: Int) {
        myRating1 = value
        let loader = StandartLoader()
        loader.reviewsRating(mainSection, indexPath2, indexPathSection, indexPath3)
        thirdLevelTableView.reloadData()
    }
}


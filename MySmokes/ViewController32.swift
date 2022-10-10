import UIKit

//Идея с рейтингом следующая: ViewController3 загружает с помощью функции с сервера актуальное значение рэйтинга и записывает ее в глобальную переменную для выведения в таблицу. После изменения данного значения во ViewController32 данные передаются по делегату во ViewController3 с изменением самого джисона в части рейтинга. Далее в VC3 обновляются значения рейтинга динамически вметоде делегата, происходит перезаписывание глобальной переменной и её вывод на в таблицу и далее при измененении по аналогии.


//Протокол передачи данных
protocol reviewsProtocol {
    func ratingValue(_ value: Int)
}

class ViewController32: UIViewController {
    
    
    @IBOutlet weak var myRatingTablveView: UITableView!
    
    //Делегат
    var delegate: reviewsProtocol?
    
    // Состав контроллера
    var myRatingInt: [Int] = [5,4,3,2,1,0]
    var myRatingString: [String] = ["Мой рейтинг", "5 (Пять)", "4 (Четыре)","3 (Три)","2 (Два)","1 (Один)","Без рейтинга"]

    override func viewDidLoad() {
        super.viewDidLoad()
        myRatingTablveView.isScrollEnabled = false
        //Прозрачный темный экран controller
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
    }

}

extension ViewController32: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
        return myRatingString.count
        } else {
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRating") as! TableViewCell1
        cell.myOwnRatingLabel.text = myRatingString[indexPath.row]
        cell.myOwnRatingLabel.layer.cornerRadius = cell.myOwnRatingLabel.frame.size.width/2
//        if indexPath.row == 0 {
//        cell.selectionStyle = UITableViewCell.SelectionStyle.none
//        } else {
//            cell.selectionStyle = UITableViewCell.SelectionStyle.default
//        }
        return cell
        } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cancel") as! TableViewCell1
            cell.myRatingCancelLabel.text =  "Отменить"
        return cell
        }
    }
    
    func  tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //Создаем цвет
        let myDarkGray = UIColor(named: "myDarkGray")
        // Основной view
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        //Нижний subview
        let subview1 = UIView(frame: CGRect(x: 0, y: 2, width: tableView.frame.width, height: 10))
        subview1.backgroundColor = myDarkGray
        subview1.layer.cornerRadius = 7
        view.addSubview(subview1)
        //Нижний subview
        //Закрытие нижних границ при cornerRadius
        let subview2 = UIView(frame: CGRect(x: 0, y: 7, width: tableView.frame.width, height: 3))
        subview2.backgroundColor = myDarkGray
        view.addSubview(subview2)
        return view
        }
    //Определение высоты Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  10
    }
    //Добавляем footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //Создаем цвет
        let myDarkGray = UIColor(named: "myDarkGray")
        // Основной view
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        //Нижний subview
        let subview1 = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 5))
        subview1.backgroundColor = myDarkGray
        view.addSubview(subview1)
        //Нижний subview
        //Закрытие нижних границ при cornerRadius
        let subview2 = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
        subview2.backgroundColor = myDarkGray
        subview2.layer.cornerRadius = 7
        view.addSubview(subview2)
        return view
    }
    //Высота footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            if indexPath.row != 0 {
                //Добавить действие изменения json рэйтинга
                delegate?.ratingValue(myRatingInt[indexPath.row - 1])
            dismiss(animated: true, completion: nil)
            }
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}

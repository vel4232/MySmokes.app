import UIKit

class ViewController41: UIViewController {

    
    @IBOutlet weak var settingsTableView: UITableView!
    
    //Массив profile (передача)
    var profile: [MainMenu] = []
    
    //Вспомогательный массив для данных  из profile
    var profileSettings: [String] = []
    
    //Название Title
    var titleSettings = ["", "Мои данные", "Профиль"]
    
    //Наполнение ячеек настроек
    var prof2 = prof.prof1()
    struct PROF {
        var label1: [String] = []
    }
    
    class prof {
        static func prof1() -> [PROF] {
            return [
                //Заголовки
                PROF(label1: [""]),
                //Мои данные
                PROF(label1: ["Имя", "Фамилия", "Отчество", "E-mail", "Мобильный телефон", "Пол", "Дата рождения", "Город"]),
                //Профиль
                PROF(label1: ["Сменить пароль", "Выйти"])
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.isScrollEnabled = false
        if profile.count != 0 {
        profileSettings = [profile[0].firstname, profile[0].secondname,profile[0].patronymic,profile[0].email,profile[0].phonenumber,profile[0].gender,profile[0].birth,profile[0].city]
        } else {prof2 = []}
    }
    
}

extension ViewController41: UITableViewDataSource, UITableViewDelegate {
    
    //Таблица Настроек
    
    //Количество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        return prof2.count
    }
    //Разбивка по секциям
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prof2[section].label1.count
    }
    //Определение всех параметров Header (view, title) - управление Header, за исключением Высоты
    func  tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
        view.backgroundColor = .black
        let  title = UILabel(frame: CGRect(x: 20, y: 4, width: tableView.frame.width, height: 15))
        title.text = titleSettings[section]
        title.backgroundColor = .black
        title.textColor = .white
        view.addSubview(title)
        return view
    }
    //Высота ячеек
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
    //Определение высоты Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {return 20}
        else {
            return 30
        }
    }
    //Добавляем footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height))
        return view
    }
    //Определение самих ячеек
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //создание вспомогательной константы
        let  help = prof2[indexPath.section].label1[indexPath.row]
        switch help {
        case "" : let cell = tableView.dequeueReusableCell(withIdentifier: "settings1") as! TableViewCell2
            cell.label1.text = "Оформление"
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 5
            cell.layer.borderColor = UIColor.black.cgColor
            return cell
        case "Сменить пароль", "Выйти":
        let cell = tableView.dequeueReusableCell(withIdentifier: "settings3") as! TableViewCell2
        cell.label3.text = prof2[2].label1[indexPath.row]
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 5
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
        default :
        let cell = tableView.dequeueReusableCell(withIdentifier: "settings2") as! TableViewCell2
        cell.subLabel.text = prof2[1].label1[indexPath.row]
        cell.label2.text = profileSettings[indexPath.row]
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 5
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
        }
    }
    //Команда при  нажатии на ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}


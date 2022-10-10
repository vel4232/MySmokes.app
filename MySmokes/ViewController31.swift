import UIKit
import SDWebImage

class ViewController31: UIViewController {
    
    //Для отзывов
    var review: [Comments] =  []
    var flavours2: [ThirdLevel] = []
    var indexPath4 = 0
    
    //Фото
    
    @IBOutlet weak var myPhotoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for (_, data) in flavours2[indexPath4].review.enumerated() {
            if let review1 = Comments(data: data as! NSDictionary) {
                review.append(review1)
            }
        }
        mySmokesCoreData.shared.addProfile("", "", "", "", "", "", "", 0)
        myPhotoImageView.layer.cornerRadius = myPhotoImageView.frame.size.width/2
        myPhotoImageView.sd_setImage(with: URL(string: imageArr))
    }

}

extension ViewController31: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return review.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reviews") as! TableViewCell1
        let model = review [indexPath.row]
        cell.reviewsImage.layer.cornerRadius = cell.reviewsImage.frame.size.width/2
        cell.reviewsImage.sd_setImage(with: URL(string: "\(model.photo)"))
        cell.commentInfoLabel.text = "\(model.data1)" + "  " + "\(model.nick)"
        cell.commentLabel.text = "\(model.comment)"
        return cell
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

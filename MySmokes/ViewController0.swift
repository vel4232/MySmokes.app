import UIKit

class ViewController0: UIViewController {
    
    var time: Float = 0.0
    var timer: Timer?
    
    @IBOutlet weak var progressView0: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        progressView0.setProgress(0, animated: false)
    }
    
    @objc func updateProgress() {
        time += 0.001
        progressView0.setProgress(time / 3, animated: true)
        if time >= 3 {
            timer!.invalidate()
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let viewController = storyboard.instantiateViewController(identifier: "TabBarController") as! UITabBarController
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

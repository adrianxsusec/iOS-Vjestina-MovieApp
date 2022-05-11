import Foundation
import UIKit

class ErrorViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let errorLabel = UILabel()
        errorLabel.text = "No internet connection!"
        errorLabel.font = UIFont(name: "ProximaNova-Bold", size: 18)
        errorLabel.textColor = UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 1)
        errorLabel.numberOfLines = 0
        
        view.addSubview(errorLabel)
        
        errorLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}

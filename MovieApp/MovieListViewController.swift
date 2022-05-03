import Foundation
import UIKit
import SnapKit

class MovieListViewController: UIViewController {
    
    let searchBarView = SearchBarView()
    let searchBarSelectedViewController = SearchBarSelectedViewController()
    let searchBarNotSelectedViewController = SearchBarNotSelectedViewController()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        buildInitialViews()
        
        searchBarView.searchInputTextField.delegate = self
        
    }
    
    func buildInitialViews() {
        
        view.addSubview(searchBarView)
        view.addSubview(searchBarNotSelectedViewController.view)
        view.addSubview(searchBarSelectedViewController.view)
        searchBarSelectedViewController.view.isHidden = true
        
        buildInitialConstraints()
        
    }
    
    func buildInitialConstraints () {
        
        searchBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        searchBarNotSelectedViewController.view.snp.makeConstraints {
            $0.top.equalTo(searchBarView.snp.bottom).offset(5)
            $0.leading.equalTo(searchBarView).offset(-5)
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        searchBarSelectedViewController.view.snp.makeConstraints {
            $0.top.equalTo(searchBarView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview() //(view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
}

extension MovieListViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchBarView.isSelected()
        searchBarNotSelectedViewController.view.isHidden = true
        searchBarSelectedViewController.view.isHidden = false
        
        searchBarView.grayBackground.snp.remakeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(85)
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchBarView.notSelected()
        searchBarNotSelectedViewController.view.isHidden = false
        searchBarSelectedViewController.view.isHidden = true
    }
}

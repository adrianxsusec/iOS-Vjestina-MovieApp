import Foundation
import UIKit
import SnapKit

class MovieListViewController: UIViewController {
    
    let searchBarView = SearchBarView()
    let searchBarNotSelectedViewController = SearchBarNotSelectedViewController()
    var searchBarSelectedViewController: SearchBarSelectedViewController!
    var titleItem: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        searchBarSelectedViewController = SearchBarSelectedViewController()
        
        searchBarNotSelectedViewController.setNavigationController(self)
        
        view.backgroundColor = .white
        
        searchBarView.searchInputTextField.delegate = self
        
        //searchBarNotSelectedViewController.unselectedTableView.
        
        //self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 1)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 1)
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        titleItem = UIImageView(image: UIImage(named: "tmdbtitleview.pdf"))
        navigationItem.titleView = titleItem
        
        buildInitialViews()
        
        
    
//        let movieDetailsVC = MovieDetailsViewController()
//        self.navigationController?.pushViewController(movieDetailsVC, animated: false)
        
        
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
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom) 
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

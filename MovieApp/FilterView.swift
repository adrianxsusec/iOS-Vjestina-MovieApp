import Foundation
import UIKit
import SnapKit
import MovieAppData

class FilterView: UIView {
    
//    var filterScroll = UIScrollView()
    var filterStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.clipsToBounds = true
        
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews() {
        
//        filterScroll.isDirectionalLockEnabled = true
//        addSubview(filterScroll)
        
        filterStack.axis = .horizontal
        filterStack.alignment = .fill
        
        //filterStack.distribution = .fillProportionally
        //filterStack.spacing = 25
        
        //filterScroll.
        addSubview(filterStack)
        
        createConstraints()
    }
    
    func clearFilters() {
        
        for views in filterStack.subviews {
            views.removeFromSuperview()
        }
        
    }
    
    func fetchFilters(_ filterNames: [String]) {
        setFilterLabels(filterNames)
    }
    
    func setFilterLabels(_ filterNames: [String]) {
        
        clearFilters()
        
        for name in filterNames {
            let filterLabel = UILabel()
            filterLabel.text = name
            filterLabel.textAlignment = .center
            filterStack.addArrangedSubview(filterLabel)
        }
    }
    
    func createConstraints() {
        
//        filterScroll.snp.makeConstraints {
//            $0.leading.trailing.bottom.top.equalToSuperview()
//        }
//        
        filterStack.snp.makeConstraints {
            $0.leading.trailing.bottom.top.equalToSuperview()
        }
    }
}

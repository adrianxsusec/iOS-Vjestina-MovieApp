import Foundation
import UIKit
import SnapKit
import MovieAppData

class FilterView: UIView {
    
    var filterScroll = UIScrollView()
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
        
        filterScroll.isDirectionalLockEnabled = true
        addSubview(filterScroll)
        
        filterStack.axis = .horizontal
        filterStack.alignment = .fill
        
        filterStack.distribution = .fillProportionally
        filterStack.spacing = 20
        
        filterScroll.showsHorizontalScrollIndicator = false
        filterScroll.showsVerticalScrollIndicator = false
        
        filterScroll.addSubview(filterStack)
        
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
            let filterButton = UIButton()
            filterButton.setTitle(name, for: .normal)
            
            let regularAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "ProximaNova-Regular", size: 16) as Any,
                  .foregroundColor: UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1),
            ]
            
            let attributedString = NSMutableAttributedString(
                string: (filterButton.titleLabel?.text!)!,
                    attributes: regularAttributes
                 )
            
            filterButton.setAttributedTitle(attributedString, for: .normal)
            
            filterButton.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
    
            filterStack.addArrangedSubview(filterButton)
        }
        if let btn = filterStack.arrangedSubviews[0] as? UIButton {
            
            let underlinedAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "ProximaNova-Bold", size: 16) as Any,
                  .foregroundColor: UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 1),
                    .underlineStyle: NSUnderlineStyle.thick.rawValue
            ]
            
            let attributedString = NSMutableAttributedString(
                string: (btn.titleLabel?.text!)!,
                    attributes: underlinedAttributes
                 )
            
            btn.setAttributedTitle(attributedString, for: .normal)
            
            //btn.setTitleColor(UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 1), for: .normal)
        }
    }
    
    func createConstraints() {
        
        filterScroll.snp.makeConstraints {
            $0.leading.trailing.bottom.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(60)
            
        }
       
        filterStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
    
    @objc
    func filterButtonTapped(_ sender: UIButton) {
        for view in filterStack.arrangedSubviews as [UIView] {
            if let btn = view as? UIButton {
                let regularAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont(name: "ProximaNova-Regular", size: 16) as Any,
                      .foregroundColor: UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1),
                ]
                
                let attributedString = NSMutableAttributedString(
                    string: (btn.titleLabel?.text!)!,
                        attributes: regularAttributes
                     )
                
                btn.setAttributedTitle(attributedString, for: .normal)
            }
        }
        
        
        let underlinedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "ProximaNova-Bold", size: 16) as Any,
              .foregroundColor: UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 1),
                .underlineStyle: NSUnderlineStyle.thick.rawValue
        ]
        
        let attributedString = NSMutableAttributedString(
            string: (sender.titleLabel?.text!)!,
                attributes: underlinedAttributes
             )
        
        sender.setAttributedTitle(attributedString, for: .normal)
    }
    
}

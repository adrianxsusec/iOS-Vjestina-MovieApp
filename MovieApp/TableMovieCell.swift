import Foundation
import SnapKit
import UIKit
import MovieAppData

class TableMovieCell: UITableViewCell {
    
    var pic = UIImageView()
    var title = UILabel()
    var desc = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(pic)
        contentView.addSubview(title)
        contentView.addSubview(desc)

        createConstraints()
        styleCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillWithContent(movie: MovieModel) {
        
        let url = URL(string: movie.imageUrl)!
        
        if let data = try? Data(contentsOf: url) {
            self.pic.image = UIImage(data: data)
        }
        
        let attributedTitleConfig = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
        let attributedTitle = NSMutableAttributedString(string: movie.title, attributes: attributedTitleConfig)
        
        self.title.attributedText = attributedTitle
        self.desc.text = movie.description
        self.desc.numberOfLines = 0
    
    }
    
    func createConstraints () {
        
        pic.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalTo(pic.snp.height).multipliedBy(0.7)
        }
        
        title.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(pic.snp.trailing).offset(20)
            $0.height.equalTo(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        desc.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(5)
            $0.leading.equalTo(title)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
        }
    
    }
    
    func styleCell() {
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 20
        
        self.layer.shadowOffset = CGSize(width: 10,
                                          height: 10)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.15
        
//        self.shadowLayer.layer.masksToBounds = false
//        self.shadowLayer.layer.shadowOffset = CGSizeMake(0, 0)
//        self.shadowLayer.layer.shadowOpacity = 0.23
//        cell.shadowLayer.layer.shadowRadius = 4
    }
    
}


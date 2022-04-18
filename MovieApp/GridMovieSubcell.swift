import Foundation
import UIKit
import SnapKit
import MovieAppData

class GridMovieSubcell: UICollectionViewCell {
    
    var picture = UIImageView()
    var movie: MovieModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func fillWithContent(_ moviePassed: MovieModel) {
        

        
        let url = URL(string: moviePassed.imageUrl)!
        
        if let data = try? Data(contentsOf: url) {
            self.picture.image = UIImage(data: data)
        }
        
        self.contentView.backgroundColor = .systemGray
        
        contentView.addSubview(picture)
        
        picture.contentMode = .scaleToFill
        picture.clipsToBounds = true
        picture.layer.cornerRadius = 8
        
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createConstraints() {
        picture.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
}

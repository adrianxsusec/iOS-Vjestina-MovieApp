import Foundation
import UIKit
import SnapKit
import MovieAppData

class GridMovieSubcell: UICollectionViewCell {
    
    var picture = UIImageView()
    var movie: Movie!
    var heart: UIButton!
    var heartBackground = UIImageView(image: UIImage(systemName: "circle.fill"))
    
    var navController: UIViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        picture.contentMode = .scaleToFill
        picture.clipsToBounds = true
        picture.layer.cornerRadius = 8
        contentView.addSubview(picture)
        
        heartBackground.layer.cornerRadius = heartBackground.bounds.height / 2
        heartBackground.clipsToBounds = true
        heartBackground.tintColor = UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 0.6)
        contentView.addSubview(heartBackground)
        
        heart = UIButton()
        heart.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        heart.tintColor = .white
        heartBackground.addSubview(heart)
        
        createConstraints()
    }
    
//    func fillWithContent(_ moviePassed: MovieModel) {
//        let url = URL(string: moviePassed.imageUrl)!
//
//        if let data = try? Data(contentsOf: url) {
//            self.picture.image = UIImage(data: data)
//        }
//    }
    
    func setNavController (_ vc: UIViewController) {
        self.navController = vc
    }
    
    func fillWithContent(_ moviePassed: Movie) {
        
        movie = moviePassed
        
        let url = URL(string: "https://image.tmdb.org/t/p/original" + moviePassed.poster_path)!

        DispatchQueue.main.async {
            if let data = try? Data(contentsOf: url) {
                self.picture.image = UIImage(data: data)
            }

        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createConstraints() {
        picture.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        heartBackground.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(7)
            $0.height.width.equalTo(38)
        }
    
        heart.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

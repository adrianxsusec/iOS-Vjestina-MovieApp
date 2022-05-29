import Foundation
import SnapKit
import UIKit

class MovieDetailsViewController: UIViewController {
    
    var backgroundColor: UIColor!
    var movieForDisplay: Movie!
    var movieFetched: MovieAccurate!
    
    init(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init() {
        self.init(backgroundColor: .white)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let id_string = String(movieForDisplay.id)
        
        let url_string = "https://api.themoviedb.org/3/movie/" + id_string + "?language=en-US&page=1&api_key=" + api_key
        
        fetchMovieDetails(url_string)
        
        view.backgroundColor = .white
        buildViews()
        
        let titleItem = UIImageView(image: UIImage(named: "tmdbtitleview.pdf"))
        navigationItem.titleView = titleItem
        
        let movieDatabaseDataSource = MovieDatabaseDataSource()
        
        print(movieDatabaseDataSource.fetchMovies())
    }
    
    func setMovieForDisplay(_ moviePassed: Movie) {
        movieForDisplay = moviePassed
    }
    
    func fetchMovieDetails(_ url_string: String) {
        
        let networkService = NetworkService()
        
        guard let url = URL(string: url_string) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print(request)
        
        networkService.executeUrlRequest(request) { (result: Result<MovieAccurate, RequestError>) in
            
            switch result {
            case .success(_):
                do {
                    self.movieFetched = try result.get()
                    print("Movies details")
                } catch {
                    print ("Error while fetching movie details")
                }
            case .failure(_):
                print("error")
                return
            }
        }
    }
    
    func buildViews() {
        
        //upper part
        let movieImage = UIImage(named: "ironmanposter.png")
        let movieImageView = UIImageView(image: movieImage)
        let overviewView = UIView()
        let percentage = UILabel()
        let userScore = UILabel()
        let movieName = UILabel()
        let movieReleaseDate = UILabel()
        let movieDetails = UILabel()
        let star = UIImage(systemName: "star")
        let favourite = UIImageView(image: star)
        
        
        //lower part
        let overviewTitle = UILabel()
        let movieDescription = UILabel()
        let character1 = UILabel()
        let character2 = UILabel()
        let director = UILabel()
        let screenplay1 = UILabel()
        let screenplay2 = UILabel()
        let screenplay3 = UILabel()
        
//        let scrollView = UIScrollView()
//        scrollView.backgroundColor = .clear
        
        let contentView = UIView()
        contentView.backgroundColor = .clear
        
        
        //movie image view setup
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.clipsToBounds = true
        
        var gradientView = UIView(frame: movieImageView.frame)
        var gradient = CAGradientLayer()
        gradient.frame = gradientView.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 0.4]
        gradientView.layer.insertSublayer(gradient, at: 0)
        movieImageView.addSubview(gradientView)
        movieImageView.bringSubviewToFront(gradientView)
        
        
        //percentage setup
        
        //let percentageNumber = "76"
        let percentageNumber = String(describing: movieForDisplay.vote_average)
        let attrsPN = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: movieImageView.frame.height * 0.016)]
        let attributedPN = NSMutableAttributedString(string: percentageNumber, attributes: attrsPN)
        
//        let percentageSign = "%"
//        let attrsPS = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: movieImageView.frame.height * 0.008)]
//        let attributedPS = NSMutableAttributedString(string: percentageSign, attributes: attrsPS)
        
        //attributedPN.append(attributedPS)
        
        percentage.attributedText = attributedPN
        percentage.textColor = .white
        percentage.backgroundColor = .clear
        
        //user score setup
        userScore.text = "User score"
        userScore.textColor = .white
        userScore.font = UIFont.boldSystemFont(ofSize: movieImageView.frame.height * 0.014)
        userScore.backgroundColor = .clear
        
        //movie name setup
        //let movieNameTitle = "Iron man"
        let movieNameTitle = movieForDisplay.title
        let attrsMNT = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: movieImageView.frame.height * 0.018)]
        let attributedMNT = NSMutableAttributedString(string: movieNameTitle, attributes: attrsMNT)
        
        //let movieNameYear = " (2008)"
//        let attrsMNY = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: movieImageView.frame.height * 0.018)]
//        let attributedMNY = NSMutableAttributedString(string: movieNameYear, attributes: attrsMNY)
        
        //attributedMNT.append(attributedMNY)
        
        movieName.attributedText = attributedMNT
        movieName.textColor = .white
        movieName.backgroundColor = .clear
        movieName.numberOfLines = 0
        
        //movie release date
        //movieReleaseDate.text = "05/02/2008"
        movieReleaseDate.text = movieForDisplay.release_date
        movieReleaseDate.textColor = .white
        movieReleaseDate.font = UIFont.systemFont(ofSize: movieImageView.frame.height * 0.01)
        movieReleaseDate.backgroundColor = .clear
        
        
        
        //movie details setup
        //let movieDetailsText = "Action, Science Fiction, Adventure"
        var movieDetailsText = ""
        if movieFetched != nil {
            movieFetched.genres?.forEach {
                movieDetailsText.append(contentsOf: $0.name + " ")
            }
            
            let attrsMDT = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: movieImageView.frame.height * 0.01)]
            let attributedMDT = NSMutableAttributedString(string: movieDetailsText, attributes: attrsMDT)
            
            let movieDetailsDuration = movieFetched.runtime
            let attrsMDD = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: movieImageView.frame.height * 0.01)]
            let attributedMDD = NSMutableAttributedString(string: String(movieDetailsDuration!), attributes: attrsMDD)
            
            attributedMDT.append(attributedMDD)
            movieDetails.attributedText = attributedMDT
        } else {
            movieDetailsText = "Action genre"
        }
        
        movieDetails.textColor = .white
        movieDetails.backgroundColor = .clear
        
        //favourite setup
        favourite.backgroundColor = .systemGray
        favourite.clipsToBounds = true
        favourite.layer.borderWidth = 1
        favourite.layer.masksToBounds = false
        favourite.layer.borderColor = UIColor.systemGray.cgColor
        favourite.layer.cornerRadius = favourite.frame.height
        favourite.clipsToBounds = true
        
        //overview title
        overviewTitle.text = "Overview"
        overviewTitle.textColor = .black
        overviewTitle.font = UIFont.boldSystemFont(ofSize: movieImageView.frame.height * 0.016)
        
        //movie description
//        movieDescription.text = "After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized suit of armor to fight evil."
        
        movieDescription.text = movieForDisplay.overview
        movieDescription.textColor = .black
        movieDescription.font = UIFont.systemFont(ofSize: movieImageView.frame.height * 0.011)
        movieDescription.numberOfLines = 0
        movieDescription.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        //character 1
        //let char1name = "Don Heck\n\n"
        let char1name = movieForDisplay.release_date + "\n"
        let attrsC1N = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: movieImageView.frame.height * 0.01)]
        let attributedC1N = NSMutableAttributedString(string: char1name, attributes: attrsC1N)
        
//        let char1role = "Characters"
        let char1role = "Release date"
        let attrsC1R = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: movieImageView.frame.height * 0.01)]
        let attributedC1R = NSMutableAttributedString(string: char1role, attributes: attrsC1R)
        
        attributedC1N.append(attributedC1R)
        
        character1.attributedText = attributedC1N
        character1.textColor = .black
        character1.backgroundColor = .clear
        character1.numberOfLines = 0
        
        //character 2
//        let char2name = "Jack Kirby\n\n"
        let char2name = { () -> String in
            switch self.movieForDisplay.adult {
            case true: return "Adult" + "\n"
            case false: return "Non-adult" + "\n"
            }
        }
        let attrsC2N = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: movieImageView.frame.height * 0.01)]
        let attributedC2N = NSMutableAttributedString(string: char2name(), attributes: attrsC2N)
        
//        let char2role = "Characters"
        let char2role = "Type"
        let attrsC2R = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: movieImageView.frame.height * 0.01)]
        let attributedC2R = NSMutableAttributedString(string: char2role, attributes: attrsC2R)
        
        attributedC2N.append(attributedC2R)
        
        character2.attributedText = attributedC2N
        character2.textColor = .black
        character2.backgroundColor = .clear
        character2.numberOfLines = 0
        
        //director
//        let directorName = "Jon Favreau\n\n"
        let directorName = movieForDisplay.original_language + "\n"
        let attrsDN = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: movieImageView.frame.height * 0.01)]
        let attributedDN = NSMutableAttributedString(string: directorName, attributes: attrsDN)
        
//      let directorRole = "Director"
        let directorRole = "Original language"
        let attrsDR = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: movieImageView.frame.height * 0.01)]
        let attributedDR = NSMutableAttributedString(string: directorRole, attributes: attrsDR)
        
        attributedDN.append(attributedDR)
        
        director.attributedText = attributedDN
        director.textColor = .black
        director.backgroundColor = .clear
        director.numberOfLines = 0
        
        //screenplay 1
//        let screenplay1name = "Don Heck\n\n"
        let screenplay1name = String(movieForDisplay.vote_count) + "\n"
        let attrsS1N = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: movieImageView.frame.height * 0.01)]
        let attributedS1N = NSMutableAttributedString(string: screenplay1name, attributes: attrsS1N)
        
//        let screenplay1role = "Screenplay"
        let screenplay1role = "Vote count"
        let attrsS1R = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: movieImageView.frame.height * 0.01)]
        let attributedS1R = NSMutableAttributedString(string: screenplay1role, attributes: attrsS1R)
        
        attributedS1N.append(attributedS1R)
        
        screenplay1.attributedText = attributedS1N
        screenplay1.textColor = .black
        screenplay1.backgroundColor = .clear
        screenplay1.numberOfLines = 0
        
        //screenplay 2
//        let screenplay2name = "Jack Marcum\n\n"
        let screenplay2name = String(movieForDisplay.popularity) + "\n"
        let attrsS2N = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: movieImageView.frame.height * 0.01)]
        let attributedS2N = NSMutableAttributedString(string: screenplay2name, attributes: attrsS2N)
        
//        let screenplay2role = "Screenplay"
        let screenplay2role = "Popularity"
        let attrsS2R = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: movieImageView.frame.height * 0.01)]
        let attributedS2R = NSMutableAttributedString(string: screenplay2role, attributes: attrsS2R)
        
        attributedS2N.append(attributedS2R)
        
        screenplay2.attributedText = attributedS2N
        screenplay2.textColor = .black
        screenplay2.backgroundColor = .clear
        screenplay2.numberOfLines = 0
        
        //screenplay 3
//        let screenplay3name = "Jack Marcum\n\n"
        let screenplay3name = String(movieForDisplay.id) + "\n"
        let attrsS3N = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: movieImageView.frame.height * 0.01)]
        let attributedS3N = NSMutableAttributedString(string: screenplay3name, attributes: attrsS3N)
        
//        let screenplay3role = "Screenplay"
        let screenplay3role = "ID"
        let attrsS3R = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: movieImageView.frame.height * 0.01)]
        let attributedS3R = NSMutableAttributedString(string: screenplay3role, attributes: attrsS3R)
        
        attributedS3N.append(attributedS3R)
        
        screenplay3.attributedText = attributedS3N
        screenplay3.textColor = .black
        screenplay3.backgroundColor = .clear
        screenplay3.numberOfLines = 0
        
        //adding subviews
        //top subviews
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
        view.addSubview(contentView)
        contentView.addSubview(movieImageView)
        contentView.addSubview(overviewView)
        contentView.addSubview(percentage)
        contentView.addSubview(userScore)
        contentView.addSubview(movieName)
        contentView.addSubview(movieReleaseDate)
        contentView.addSubview(movieDetails)
        contentView.addSubview(favourite)
        //overview subviews
        contentView.addSubview(overviewTitle)
        contentView.addSubview(movieDescription)
        contentView.addSubview(character1)
        contentView.addSubview(character2)
        contentView.addSubview(director)
        contentView.addSubview(screenplay1)
        contentView.addSubview(screenplay2)
        contentView.addSubview(screenplay3)
        
        //samo overwriteanje punjenja
        let url = URL(string: "https://image.tmdb.org/t/p/original" + movieForDisplay.poster_path)!

        if let data = try? Data(contentsOf: url) {
            movieImageView.image = UIImage(data: data)
        }
        
        
        
        gradientView = UIView(frame: movieImageView.frame)
        gradient = CAGradientLayer()
        gradient.frame = gradientView.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 0.4]
        gradientView.layer.insertSublayer(gradient, at: 0)
        movieImageView.addSubview(gradientView)
        movieImageView.bringSubviewToFront(gradientView)
        
        
        //overview constraints
        
//        scrollView.snp.makeConstraints{
//            $0.leading.top.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
//            $0.width.equalToSuperview()
//        }
        
        contentView.snp.makeConstraints{
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        movieImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.55)
        }
        
        overviewView.snp.makeConstraints {
            $0.top.equalTo(movieImageView.snp.bottom)
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom)
        }
        
        percentage.snp.makeConstraints {
            $0.centerY.equalTo(movieImageView)
            $0.leading.equalTo(movieImageView.snp.leading).offset(movieImageView.frame.width * 0.03)
        }
        
        userScore.snp.makeConstraints {
            $0.leading.equalTo(percentage.snp.trailing).offset(movieImageView.frame.width * 0.01)
            $0.bottom.equalTo(percentage.snp.bottom)
        }
        
        movieName.snp.makeConstraints {
            $0.leading.equalTo(percentage.snp.leading)
            $0.top.equalTo(percentage.snp.bottom).offset(movieImageView.frame.height * 0.012)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
        
        movieReleaseDate.snp.makeConstraints {
            $0.leading.equalTo(percentage.snp.leading)
            $0.top.equalTo(movieName.snp.bottom).offset(movieImageView.frame.height * 0.005)
        }
        
        movieDetails.snp.makeConstraints {
            $0.leading.equalTo(percentage.snp.leading)
            $0.top.equalTo(movieReleaseDate.snp.bottom).offset(movieImageView.frame.height * 0.0005)
        }
        
        favourite.snp.makeConstraints {
            $0.leading.equalTo(percentage.snp.leading)
            $0.bottom.equalTo(movieImageView.snp.bottom).inset(movieImageView.frame.height * 0.01)
            $0.height.width.equalTo(movieImageView).multipliedBy(0.1)
        }
        
        //overview section details
        overviewTitle.snp.makeConstraints {
            $0.top.equalTo(movieImageView.snp.bottom).offset(movieImageView.frame.height * 0.015)
            $0.leading.equalTo(view.snp.leading).offset(movieImageView.frame.width * 0.02)
        }
        
        movieDescription.snp.makeConstraints {
            $0.top.equalTo(overviewTitle.snp.bottom).offset(movieImageView.frame.height * 0.01)
            $0.leading.equalToSuperview().offset(movieImageView.frame.width * 0.02)
            $0.trailing.equalToSuperview().inset(movieImageView.frame.width * 0.02)
        }
        
        character1.snp.makeConstraints {
            $0.top.equalTo(movieDescription.snp.bottom).offset(movieImageView.frame.height * 0.022)
            $0.leading.equalToSuperview().offset(movieImageView.frame.width * 0.02)
        }
        
        character2.snp.makeConstraints {
            $0.top.equalTo(movieDescription.snp.bottom).offset(movieImageView.frame.height * 0.022)
            $0.leading.equalTo(character1.snp.trailing).offset(movieImageView.frame.width * 0.055)
            
        }
        
        director.snp.makeConstraints {
            $0.top.equalTo(movieDescription.snp.bottom).offset(movieImageView.frame.height * 0.022)
            $0.trailing.equalTo(view.snp.trailing).inset(movieImageView.frame.width * 0.02)
        }
        
        screenplay1.snp.makeConstraints {
            $0.top.equalTo(character1.snp.bottom).offset(movieImageView.frame.height * 0.022)
            $0.leading.equalToSuperview().offset(movieImageView.frame.width * 0.02)
        }
        
        screenplay2.snp.makeConstraints {
            $0.top.equalTo(character1.snp.bottom).offset(movieImageView.frame.height * 0.022)
            $0.leading.equalTo(screenplay1.snp.trailing).offset(movieImageView.frame.width * 0.055)
        }
        
        screenplay3.snp.makeConstraints {
            $0.top.equalTo(character1.snp.bottom).offset(movieImageView.frame.height * 0.022)
            $0.leading.equalTo(director.snp.leading)
        }
        
    }
    
}

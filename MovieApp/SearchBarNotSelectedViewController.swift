import Foundation
import UIKit
import SnapKit
import MovieAppData

class SearchBarNotSelectedViewController: UIViewController {
    
        let cellIdentifier = "cellId"
        let headerIdentifier = "headerId"
        var groupNames: [String] = []
        var filterSubgroups: [[String]] = []
        var movieSubgroups: [[MovieModel]] = []
        let movieCategories: [MovieCategory] = [.popular, .trending, .topRated, .recommended]
        var genres: [Genre] = []
        var moviesByCategory: [[Movie]] = []
    
        var navController: UIViewController!
    
        let unselectedTableView = UITableView(
            frame: .zero
        )
    
        override func viewDidLoad() {
    
            super.viewDidLoad()
            // bolje radit sa stack viewom -- mozd??
            
            unselectedTableView.rowHeight = 300
            unselectedTableView.separatorStyle = .none
            unselectedTableView.showsLargeContentViewer = false
            unselectedTableView.showsHorizontalScrollIndicator = false
            unselectedTableView.showsVerticalScrollIndicator = false
            view.addSubview(unselectedTableView)
            
            unselectedTableView.register(GridMovieCell.self, forCellReuseIdentifier: cellIdentifier)
            unselectedTableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerIdentifier)
            unselectedTableView.dataSource = self
            unselectedTableView.delegate = self
            
            unselectedTableView.snp.makeConstraints {
                $0.leading.top.bottom.equalToSuperview()
                $0.trailing.equalToSuperview()
            }
            
            //appendGroupNames()
            //getMoviesForGroup()
            
            
            fetchGenres()
            
            movieCategories.forEach {
                fetchMoviesByCategory($0.self)
            }
            
            DispatchQueue.main.async {
                self.unselectedTableView.reloadData()
            }
            
        }
        
//    func appendGroupNames () {
//
//        for group in MovieGroup.allCases {
//            groupNames.append(group.groupName)
//            filterSubgroups.append(group.filterGroup)
//        }
//    }
    
//    func getMoviesForGroup () {
//        var i = 0
//        for group in MovieGroup.allCases {
//            var movieSubgroup: [MovieModel] = []
//            for movie in Movies.all() {
//                if movie.group.contains(group) {
//                    movieSubgroup.append(movie)
//                }
//            }
//            movieSubgroups.append(movieSubgroup)
//            i += 1
//        }
//    }
    
    func setNavigationController (_ vc: UIViewController) {
        self.navController = vc
    }
    
    func fetchGenres(){
        
        let networkService = NetworkService()
        
        guard let url = URL(string: url_genres) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print(request)
        
        networkService.executeUrlRequest(request) { (result: Result<Genres, RequestError>) in
            switch result {
            case .success(_):
                do {
                    self.genres = try result.get().genres
                    print("Genres fetched")
                } catch {
                    print("Genre fetching error")
                }
            
            case .failure(let error):
                print(error)
                return
            }
        }
    }
    
    func fetchMoviesByCategory(_ category: MovieCategory) {
        
        let networkService = NetworkService()
        var url_string: String
        
        switch category {
        case .popular:
            url_string = url_popular
        case .trending:
            url_string = url_trending
        case .topRated:
            url_string = url_topRated
        case .recommended:
            url_string = url_recommended
        }
        
        guard let url = URL(string: url_string) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print(request)
        
        networkService.executeUrlRequest(request) { (result: Result<MoviesInGroup, RequestError>) in
            
            switch result {
            case .success(_):
                do {
                    self.moviesByCategory.append(try result.get().results)
                    print("Movies for category \(category) fetched")
                } catch {
                    print ("Error while fetching movies for \(category)")
                }
            case .failure(_):
                print("error")
                return
            }
        }
    }
}

extension SearchBarNotSelectedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GridMovieCell
        
        
        let filters = self.genres.map {
            $0.name
        }
        
        let category = movieCategories[indexPath.row].description
        
        //let currentGroupName = groupNames[indexPath.row]
        //let currentFilterGroup = filterSubgroups[indexPath.row]
        //let currentMovieGroup =
    
        
        let movies = moviesByCategory[indexPath.row]
    
        cell.prepareForReuse()
        cell.fillWithContent(category, filters, movies)
        
        cell.setNavController(navController)
        
        //cell.fillWithContent(currentGroupName, currentFilterGroup, currentMovieGroup)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
}

extension SearchBarNotSelectedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let header = tableView.dequeueReusableCell(withIdentifier: headerIdentifier)
            else { return nil }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
    }

    
}

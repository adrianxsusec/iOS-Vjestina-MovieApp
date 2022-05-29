import Foundation
import UIKit
import SnapKit
import MovieAppData

class SearchBarSelectedViewController: UIViewController {
    
    let headerIdentifier = "sectionId"
    var moviesForSearch: [Movie] = []
    var selectedTableView: UITableView!
    var movieViewModelsForSearch: [MovieViewModel] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        selectedTableView = UITableView(frame: .zero)
        
        selectedTableView.separatorStyle = .none
        selectedTableView.showsLargeContentViewer = false
        selectedTableView.showsHorizontalScrollIndicator = false
        selectedTableView.showsVerticalScrollIndicator = false
        selectedTableView.rowHeight = 142
        
        view.addSubview(selectedTableView)
        
        selectedTableView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.trailing.equalToSuperview() //.inset(10)
        }

        selectedTableView.register(TableMovieCell.self, forCellReuseIdentifier: TableMovieCell.reuseIdentifier)
        selectedTableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerIdentifier)
        selectedTableView.dataSource = self
        selectedTableView.delegate = self
        
        fetchMoviesForSearch()
                
    }
    
    func fetchMoviesForSearch() {
        
        let networkService = NetworkService()
        
//        guard let url = URL(string: url_popular) else { return }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        print(request)
        
        networkService.get(url: url_popular) { [weak self] (result: Result<MoviesInGroup, RequestError>) in
            
            switch result {
            case .success(_):
                do {
                    self?.moviesForSearch = try result.get().results
                    DispatchQueue.main.async {
                        self?.selectedTableView.reloadData()
                    }
                    print("Movies for search fetched")
                } catch {
                    print ("Error while fetching movies for search")
                }
            case .failure(_):
                print("error")
                return
            }
        }
    }
}

extension SearchBarSelectedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Movies.all().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: TableMovieCell.reuseIdentifier, for: indexPath) as? TableMovieCell,
            let movieForDisplay = moviesForSearch.at(indexPath.section)
        else { return UITableViewCell() }
        
//        while moviesForSearch == nil {
//
//        }
        
        //let movieForDisplay = moviesForSearch[indexPath.section]
    
        //let movie = Movies.all()[indexPath.section]
        
        //cell.prepareForReuse()
        
        
        
        //cell.fillWithContent(movie: movie)
        
        cell.fillWithContent2(moviePassed: movieForDisplay)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
}

extension SearchBarSelectedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let header = tableView.dequeueReusableCell(withIdentifier: headerIdentifier)
            else { return nil }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

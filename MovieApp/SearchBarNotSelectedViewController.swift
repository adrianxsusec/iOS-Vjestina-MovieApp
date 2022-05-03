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
    
        override func viewDidLoad() {
    
            super.viewDidLoad()
            // bolje radit sa stack viewom -- mozd??

            let unselectedTableView = UITableView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: view.bounds.width,
                    height: view.bounds.height)
            )
            
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
            
            appendGroupNames()
            getMoviesForGroup()
       }
        
    func appendGroupNames () {
        
        for group in MovieGroup.allCases {
            groupNames.append(group.groupName)
            filterSubgroups.append(group.filterGroup)
        }
    }
    
    func getMoviesForGroup () {
        var i = 0
        for group in MovieGroup.allCases {
            var movieSubgroup: [MovieModel] = []
            for movie in Movies.all() {
                if movie.group.contains(group) {
                    movieSubgroup.append(movie)
                }
            }
            movieSubgroups.append(movieSubgroup)
            i += 1
        }
    }
}

extension SearchBarNotSelectedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MovieGroup.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GridMovieCell
        
        let currentGroupName = groupNames[indexPath.row]
        let currentFilterGroup = filterSubgroups[indexPath.row]
        //let currentMovieGroup = movieSubgroups[indexPath.section]
        
        let currentMovieGroup = movieSubgroups[indexPath.row]
        
        cell.prepareForReuse()
        cell.fillWithContent(currentGroupName, currentFilterGroup, currentMovieGroup)
        
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

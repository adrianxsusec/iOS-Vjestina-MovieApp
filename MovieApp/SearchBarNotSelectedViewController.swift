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
            view.addSubview(unselectedTableView)
            
            unselectedTableView.register(GridMovieCell.self, forCellReuseIdentifier: cellIdentifier)
            unselectedTableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerIdentifier)
            unselectedTableView.dataSource = self
            unselectedTableView.delegate = self
            
            appendGroupNames()
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
            for movie in Movies.all() {
                if movie.group.contains(group) {
                    movieSubgroups[i].append(movie)
                }
            }
            i += 1
        }
    }
}

extension SearchBarNotSelectedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        MovieGroup.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GridMovieCell
        
        let currentGroupName = groupNames[indexPath.section]
        let currentFilterGroup = filterSubgroups[indexPath.section]
        //let currentMovieGroup = movieSubgroups[indexPath.section]
        
        let currentMovieGroup = Movies.all()
        
        
        cell.prepareForReuse()
        cell.fillWithContent(currentGroupName, currentFilterGroup, currentMovieGroup)
        
        cell.backgroundColor = .systemBlue
        
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
    
}

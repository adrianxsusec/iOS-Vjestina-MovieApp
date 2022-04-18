import Foundation
import UIKit
import SnapKit
import MovieAppData

class SearchBarSelectedViewController: UIViewController {
    
    
    let cellIdentifier = "cellId"
    let headerIdentifier = "sectionId"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let selectedTableView = UITableView(
                    frame: CGRect(
                        x: 0,
                        y: 0,
                        width: view.bounds.width,
                        height: view.bounds.height)
        )
        
        selectedTableView.separatorStyle = .none
        selectedTableView.showsLargeContentViewer = false
        selectedTableView.showsHorizontalScrollIndicator = false
        selectedTableView.showsVerticalScrollIndicator = false
        selectedTableView.rowHeight = 200
        
        view.addSubview(selectedTableView)
        
        selectedTableView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
        }

        selectedTableView.register(TableMovieCell.self, forCellReuseIdentifier: cellIdentifier)
        selectedTableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerIdentifier)
        selectedTableView.dataSource = self
        selectedTableView.delegate = self
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableMovieCell
    
        let movie = Movies.all()[indexPath.section]
        
        cell.prepareForReuse()
        
        cell.fillWithContent(movie: movie)
        
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

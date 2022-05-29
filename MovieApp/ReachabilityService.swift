import Foundation
import Network

protocol ReachabilityDelegate: AnyObject {
    func handle(hasConnection: Bool)
}

class ReachabilityService {
    
    let monitor = NWPathMonitor()
    weak var delegate: ReachabilityDelegate?
    
    init () {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.delegate?.handle(hasConnection: path.status == .satisfied)
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}

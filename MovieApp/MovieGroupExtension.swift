import Foundation
import MovieAppData

extension MovieGroup {
    
    public var groupName: String {
        switch self {
        case .popular:
            return "What's popular?"
        case .freeToWatch:
            return "Free to watch"
        case .trending:
            return "Currently trending"
        case .topRated:
            return "Top ratings"
        case .upcoming:
            return "Upcoming"
        }
    }
    
    public var filterGroup: [String] {
            switch self {
            case .popular:
                return ["streaming", "onTv", "forRent", "inTheaters"]
            case .freeToWatch:
                return ["drama", "thriller", "horror", "comedy", "romanticComedy", "sport", "action", "sciFi", "war"]
            case .trending:
                return ["day", "week", "month", "allTime"]
            case .topRated:
                return ["day", "week", "month", "allTime"]
            case .upcoming:
                return ["drama", "thriller", "horror", "comedy", "romanticComedy", "sport", "action", "sciFi", "war"]
            }
        }
    
}

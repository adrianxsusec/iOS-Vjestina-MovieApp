import Foundation
import MovieAppData

extension MovieGroup {
    
    public var groupName: String {
        switch self {
        case .popular:
            return "What's popular"
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
                return ["Streaming", "On TV", "For Rent", "In Theaters"]
            case .freeToWatch:
                return ["Drama", "Thriller", "Horror", "Comedy", "Romantic Comedy", "Sport", "Action", "Sci Fi", "War"]
            case .trending:
                return ["Day", "Week", "Month", "All Time"]
            case .topRated:
                return ["Day", "Week", "Month", "All Time"]
            case .upcoming:
                return ["Drama", "Thriller", "Horror", "Comedy", "Romantic Comedy", "Sport", "Action", "Sci Fi", "War"]
            }
        }
}

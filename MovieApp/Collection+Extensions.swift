import Foundation

extension Collection {
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    func at(_ index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

import Foundation

protocol GifCellViewModelProtocol {
    var title: String { get }
    var gifURLString: String { get }
}

final class GifCellViewModel: GifCellViewModelProtocol {
    
    private let gifViewModel: GifViewModel
    private let reactionTag: ReactionTag?
    
    init(viewModel: GifViewModel, reactionTag: ReactionTag?) {
        self.gifViewModel = viewModel
        self.reactionTag = reactionTag ?? nil
    }
    
    var title: String {
        if let tag = reactionTag {
            return tag.tag
        } else {
            return gifViewModel.title
        }
    }
    
    var gifURLString: String {
        return gifViewModel.gifUrl
    }
}

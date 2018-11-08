protocol DetailsShowable {
    func showDetails(gif: String)
}

extension DetailsShowable where Self: FlowController, Self: PopularViewControllerFlowDelegate {
    func showDetails(gif: String) {
        let detailsViewController = DetailsViewController(gif: gif)
        // TODO: - Set flowDelegate in case it pushes to more View Controllers
        navigationController.show(detailsViewController, sender: nil)
    }
}

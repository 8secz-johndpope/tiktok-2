import UIKit

enum Filter: String, CaseIterable {
    case date = "create_time"
    case views = "plays"
    case likes = "likes"
    case comments = "comments"
    case shares = "shares"
    
    var title: String {
        switch self {
        case .date: return "Date"
        case .views: return "Views"
        case .likes: return "Likes"
        case .comments: return "Comments"
        case .shares: return "Shares"
        }
    }
}

class FilterViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 7.0
            containerView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var filtersTableView: UITableView! {
        didSet {
            filtersTableView.isScrollEnabled = false
            filtersTableView.delegate = self
            filtersTableView.dataSource = self
            filtersTableView.tableFooterView = UIView()
        }
    }
    
    @IBOutlet weak var applyButton: HighlightedButton! {
        didSet {
            applyButton.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
        }
    }
    
    var coordinator: AppCoordinator?
    var filter: Filter = .date
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapBehind))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let index = Filter.allCases.firstIndex(of: filter) else { return }
        filtersTableView.selectRow(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .none)
    }
    
    @objc private func applyFilter() {
        guard let indexPath = filtersTableView.indexPathForSelectedRow else { return }
        dismiss(animated: true)
        coordinator?.filterSelected(Filter.allCases[indexPath.row])
    }
    
    @objc func handleTapBehind(_ sender: UITapGestureRecognizer) {
        let location: CGPoint = sender.location(in: contentView)
        guard sender.state == .ended,
            !contentView.point(inside: location, with: nil) else {
                return
        }
        applyFilter()
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Filter.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(FilterTableViewCell.self)", for: indexPath) as? FilterTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = Filter.allCases[indexPath.row].title
        cell.separatorInset = indexPath.row == Filter.allCases.count - 1 ? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: CGFloat.greatestFiniteMagnitude) :
            UIEdgeInsets(top: 0, left: 30.0, bottom: 0, right: 30.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
}

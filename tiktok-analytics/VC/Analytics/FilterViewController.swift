import UIKit

enum Filter: String, CaseIterable {
    case date
    case views
    case likes
    case comments
    case shares
}

class FilterViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let index = Filter.allCases.firstIndex(of: coordinator!.selectedFilter) else { return }
        filtersTableView.selectRow(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .none)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @objc private func applyFilter() {
        guard let indexPath = filtersTableView.indexPathForSelectedRow else { return }
        dismiss(animated: true)
        coordinator?.filterSelected(Filter.allCases[indexPath.row])
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Filter.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(FilterTableViewCell.self)", for: indexPath) as? FilterTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = Filter.allCases[indexPath.row].rawValue
        cell.separatorInset = indexPath.row == Filter.allCases.count - 1 ? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: CGFloat.greatestFiniteMagnitude) :
            UIEdgeInsets(top: 0, left: 30.0, bottom: 0, right: 30.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
}

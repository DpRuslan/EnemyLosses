//
//  DetailController.swift
//

import UIKit
import CoreData

class DetailController: UIViewController {
    var viewModel: DetailViewModel
    private var tableView = UITableView(frame: .zero, style: .plain)
    
    init() {
        viewModel = DetailViewModel()
        
        super.init(nibName: nil, bundle: nil)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let backButton = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
    
        viewModel.findCategoryType()
        view.addSubview(tableView)
        setupConstraints()
    }
}

extension DetailController {
    private func setup() {
        tableView.register(DetailCell.self, forCellReuseIdentifier: "DetailCell")
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension DetailController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
}

extension DetailController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.configure(titleText: viewModel.itemTitleAt(at: indexPath.row), valueText: viewModel.itemValueAt(at: indexPath.row))
        return cell
    }
}

extension DetailController {
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

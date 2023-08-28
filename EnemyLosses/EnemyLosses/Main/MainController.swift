//
//  MainController.swift
//  

import UIKit

class MainController: UIViewController {
    var viewModel: MainViewModel
    private var tableView = UITableView(frame: .zero, style: .plain)
    
    init() {
        self.viewModel = MainViewModel()
        
        super.init(nibName: nil, bundle: nil)
        
        tableView.register(EquipmentCell.self, forCellReuseIdentifier: "EquipmentCell")
        tableView.backgroundColor = .clear
        tableView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.equipmnentRequest()
        view.addSubview(tableView)
        
        setupContraints()
    }
}

extension MainController {
    private func setupContraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EquipmentCell", for: indexPath) as! EquipmentCell
        cell.backgroundColor = .clear
        cell.configure(text: viewModel.itemAt(at: indexPath.row)?.day)
    }
}


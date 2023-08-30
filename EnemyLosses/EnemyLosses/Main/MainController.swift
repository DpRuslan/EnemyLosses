//
//  MainController.swift
//  

import UIKit

class MainController<ViewModel: ViewModelProtocol>: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var viewModel: ViewModel
    
    private var tableView = UITableView(frame: .zero, style: .grouped)
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        setupContraints()
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        switch viewModel.itemAt(at: indexPath.row) {
        case let equipment as Equipment:
            cell.configure(text: equipment.date ?? "None")
        case let personnel as Personnel:
            cell.configure(text: personnel.date ?? "None")
        case let equipmentOryx as EquipmentOryx:
            cell.configure(text: equipmentOryx.model ?? "None")
        case let equipmentCorrection as EquipmentCorrection:
            cell.configure(text: equipmentCorrection.date ?? "None")
        default:
            break
        }
        
        return cell
    }
    
    // MARK: UITableView Sections
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.fetchedResultsController().sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionInfo = viewModel.fetchedResultsController().sections?[section]
        return sectionInfo?.name
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectAt(at: indexPath.row)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainController {
    private func setup() {
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension MainController {
    private func setupContraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
        ])
    }
}



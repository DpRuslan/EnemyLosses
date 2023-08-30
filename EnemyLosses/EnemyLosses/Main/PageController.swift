//
//  PageController.swift
//

import UIKit

class PageController: UIPageViewController {
    weak var coordinator: LoadingCoordinatorProtocol?
    private var pageControl = UIPageControl()
    var pages = [UIViewController]()
    let initialPage = 0
    var currentIndex: Int = 0
    var titles: [String] = ["Equipment Losses", "Personnel Losses" , "Equipment Correction Losses", " Equipment Oryx Losses"]
    lazy var navView = NavView(titleText: titles[currentIndex])
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPages()
        setup()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
        
        view.addSubview(navView)
        view.addSubview(pageControl)
        setupContraints()
    }
}

extension PageController {
    private func setupContraints() {
        NSLayoutConstraint.activate([
            navView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            navView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navView.heightAnchor.constraint(equalToConstant: 80),
            
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension PageController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex != 0 {
            return pages[currentIndex - 1]
        }
        
        return nil
    }
}

extension PageController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        self.currentIndex = currentIndex
        navView.titleLabel.text = titles[currentIndex]
        pageControl.currentPage = currentIndex
    }
}

extension PageController {
    private func setup() {
        self.delegate = self
        self.dataSource = self
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
    }
}

extension PageController {
    private func addPages() {
        pages.append(MainController(viewModel: EquipmentViewModel(coordinator: coordinator!)))
        pages.append(MainController(viewModel: PersonnelViewModel(coordinator: coordinator!)))
        pages.append(MainController(viewModel: EquipmentCorrectionViewModel(coordinator: coordinator!)))
        pages.append(MainController(viewModel: EquipmentOryxViewModel(coordinator: coordinator!)))
    }
}

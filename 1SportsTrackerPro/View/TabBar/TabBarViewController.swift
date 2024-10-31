//
//  TabBarViewController.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import UIKit
import TrackerProViewModel
import SnapKit

class TabBarViewController: UITabBarController {

    var viewModel: ViewModel?

    private let createButton = UIButton(type: .system)
    private let createdButton = TeamView()
    private let addTeamButton = UIButton(type: .system)
    private let settingsButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupUI()
        makeButtonActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = true

        let name: String? = self.viewModel?.appStorageService.getData(key: .teamName)
        let imageData: Data? = self.viewModel?.appStorageService.getData(key: .teamImage)

        if let name = name, let imageData = imageData, let image = UIImage(data: imageData) {
            self.addSubviewTeam()
            self.createdButton.setup(with: image, name: name)
        } else if let name = name {
            self.createdButton.setup(with: UIImage(named: "dashboard")!, name: name)
        }
    }

    //MARK: Setup View Controllers
    private func setupViewControllers() {
        lazy var dashboardViewController = self.createNavigation(title: "Dashboard",
                                                                 image: "dashboard",
                                                                 vc: ViewControllerFactory.makeDashboardViewController())

        lazy var matchViewController = self.createNavigation(title: "Matches",
                                                             image: "matches",
                                                             vc: ViewControllerFactory.makeMatchViewController())

        lazy var eventViewController = self.createNavigation(title: "Events/plans",
                                                             image: "events",
                                                             vc: ViewControllerFactory.makeEventViewController())

        lazy var statisticViewController = self.createNavigation(title: "Stats",
                                                                 image: "statistic",
                                                                 vc: ViewControllerFactory.makeStatisticViewController())

        lazy var playersViewController = self.createNavigation(title: "Players",
                                                               image: "players",
                                                               vc: ViewControllerFactory.makePlayersViewController())

        self.setViewControllers([dashboardViewController, matchViewController, eventViewController, statisticViewController, playersViewController], animated: true)
        NotificationCenter.default.addObserver(self, selector: #selector(setCurrentPageToTeam), name: Notification.Name("ResetCompleted"), object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setStatisticPage),
            name: Notification.Name("AllStatistic"),
            object: nil
        )

        dashboardViewController.delegate = self
        matchViewController.delegate = self
        eventViewController.delegate = self
        statisticViewController.delegate = self
        playersViewController.delegate = self
    }

    @objc func setCurrentPageToTeam() {
        self.selectedIndex = 0
    }

    @objc func setStatisticPage() {
        self.selectedIndex = 3
    }

    private func createNavigation(title: String, image: String, vc: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: vc)
        self.tabBar.backgroundColor = UIColor(hex: "#001724")?.withAlphaComponent(0.5)
        self.tabBar.barTintColor = UIColor(hex: "#001724")?.withAlphaComponent(0.5)
        self.tabBar.isTranslucent = false

        _ = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
        let selectedImage = UIImage(named: image)?.withTintColor(.white, renderingMode: .alwaysTemplate)

        navigation.tabBarItem.image = UIImage(named: image)
        navigation.tabBarItem.selectedImage = selectedImage
        navigation.tabBarItem.title = title

        let nonselectedTitleColor: UIColor = UIColor.white.withAlphaComponent(0.2)
        let selectedTitleColor: UIColor = UIColor(hex: "#00A2FF")!

        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: nonselectedTitleColor
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: selectedTitleColor
        ]

        navigation.tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
        navigation.tabBarItem.setTitleTextAttributes(normalAttributes, for: .normal)

        self.tabBar.tintColor = UIColor(hex: "#00A2FF")!

        self.tabBar.unselectedItemTintColor = UIColor.white.withAlphaComponent(0.2)


        return navigation
    }

    //MARK: Setup UI elements
    private func setupUI() {
        settingsButton.setImage(UIImage(named: "settingsButton"), for: .normal)
        addTeamButton.setImage(UIImage(named: "addButton"), for: .normal)

        createButton.backgroundColor = .white
        createButton.setTitle("Create team", for: .normal)
        createButton.setTitleColor(.black, for: .normal)
        createButton.layer.cornerRadius = 18
        createButton.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 17)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification(_:)),
            name: Notification.Name("TeamInfo"),
            object: nil
        )

        self.view.addSubview(settingsButton)
        self.view.addSubview(createButton)
        self.view.addSubview(addTeamButton)
        setupConstraints()
    }

    private func addSubviewTeam() {
        self.view.addSubview(createdButton)

        createdButton.snp.makeConstraints { view in
            view.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(156)
            view.height.equalTo(48)
        }
    }

    private func setupConstraints() {

        createButton.snp.makeConstraints { view in
            view.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(156)
            view.height.equalTo(48)
        }

        addTeamButton.snp.makeConstraints { view in
            view.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            view.leading.equalTo(createButton.snp.trailing).offset(8)
            view.width.equalTo(48)
            view.height.equalTo(48)
        }

        settingsButton.snp.makeConstraints { view in
            view.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(48)
            view.width.equalTo(48)
        }
    }

    // MARK: - Deinit
    deinit {
        #if DEBUG
        print("deinit \(String(describing: self))")
        NotificationCenter.default.removeObserver(self)
        #endif
    }
}

extension TabBarViewController: IViewModelableController {
    typealias ViewModel = ITabBarViewModel
}

//MARK: Button actions
extension TabBarViewController {
    private func makeButtonActions() {
        self.settingsButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        self.addTeamButton.addTarget(self, action: #selector(addTeam), for: .touchUpInside)
        self.createButton.addTarget(self, action: #selector(editTeam), for: .touchUpInside)
        self.createdButton.addTarget(self, action: #selector(editTeam), for: .touchUpInside)
    }

    @objc private func handleNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo,
           let text = userInfo["text"] as? String,
           let image = userInfo["image"] as? UIImage {
            self.addSubviewTeam()
            self.createdButton.setup(with: image, name: text)
            if let imageData = image.pngData() {
                self.viewModel?.appStorageService.saveData(key: .teamImage, value: imageData)
            }
            self.viewModel?.appStorageService.saveData(key: .teamName, value: text)
        }
    }

    @objc func editTeam() {
        guard let navigationController = self.navigationController else { return }
        TabBarRouter.showChooseTeamViewController(in: navigationController)
    }

    @objc func addTeam() {
        guard let navigationController = self.navigationController else { return }
        TabBarRouter.showTeamViewController(in: navigationController)
    }

    @objc func settingsTapped() {
        guard let navigationController = self.navigationController else { return }
        TabBarRouter.showSettingsViewController(in: navigationController)
    }
}

//MARK: Navigation & TabBar Hidden
extension TabBarViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController.hidesBottomBarWhenPushed {
            self.tabBar.isHidden = true
        } else {
            self.tabBar.isHidden = false
        }
    }
}

//MARK: Preview
import SwiftUI

struct TabBarViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let tabBarViewController = TabBarViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarViewControllerProvider.ContainerView>) -> TabBarViewController {
            return tabBarViewController
        }

        func updateUIViewController(_ uiViewController: TabBarViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<TabBarViewControllerProvider.ContainerView>) {
        }
    }
}


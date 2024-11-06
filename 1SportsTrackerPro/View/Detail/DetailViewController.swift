//
//  DetailViewController.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 06.11.24.
//

import UIKit
import TrackerProViewModel
import SnapKit
import StoreKit

class DetailViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    var collectionView: UICollectionView!
    private let bottomView = UIView()
    private let header = UILabel(text: "",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    private let descriptionLabel = UILabel(text: "",
                                           textColor: .white.withAlphaComponent(0.2),
                                      font: UIFont(name: "SFProText-Regular", size: 17))
    private let continueButton = UIButton(type: .system)
    private var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#001724")

        self.bottomView.layer.borderWidth = 1
        self.bottomView.layer.borderColor = UIColor.white.cgColor
        self.bottomView.backgroundColor = UIColor(hex: "#001724")

        header.textAlignment = .center
        header.numberOfLines = 2

        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 2

        self.continueButton.setTitle("Next", for: .normal)
        self.continueButton.layer.cornerRadius = 25
        self.continueButton.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 17)
        self.continueButton.setTitleColor(.white, for: .normal)
        self.continueButton.backgroundColor = UIColor(hex: "#00A2FF")

        let mylayout = UICollectionViewFlowLayout()
        mylayout.itemSize = sizeForItem()
        mylayout.scrollDirection = .horizontal
        mylayout.minimumLineSpacing = 0
        mylayout.minimumInteritemSpacing = 0

        self.header.numberOfLines = 2

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: mylayout)
        setupConstraints()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear

        collectionView.register(DetailCell.self)
        collectionView.backgroundColor = UIColor(hex: "#021F48")
        collectionView.isScrollEnabled = false
    }

    override func setupViewModel() {
        super.setupViewModel()
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel?.loadData()
    }

    func sizeForItem() -> CGSize {
        let deviceType = UIDevice.currentDeviceType

        switch deviceType {
        case .iPhone:
            let width = self.view.frame.size.width
            let heightt = self.view.frame.size.height - 300
            return CGSize(width: width, height: heightt)
        case .iPad:
            let scaleFactor: CGFloat = 1.5
            let width = 550 * scaleFactor
            let height = 1100 * scaleFactor
            return CGSize(width: width, height: height)
        }
    }

    func setupConstraints() {
        self.view.addSubview(bottomView)
        self.view.addSubview(collectionView)
        self.view.addSubview(header)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(continueButton)

        bottomView.snp.makeConstraints { view in
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(294)
        }

        collectionView.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalTo(bottomView.snp.top)
        }

        header.snp.makeConstraints { view in
            view.top.equalTo(bottomView.snp.top).offset(43)
            view.leading.equalToSuperview().offset(24)
            view.trailing.equalToSuperview().inset(24)
            view.height.equalTo(68)
        }

        descriptionLabel.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(24)
            view.trailing.equalToSuperview().inset(24)
            view.height.equalTo(20)
        }

        continueButton.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(70)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(50)
        }
    }

}

//MARK: Make buttons actions
extension DetailViewController {
    
    private func makeButtonsAction() {
        continueButton.addTarget(self, action: #selector(continueButtonTaped), for: .touchUpInside)
    }

    @objc func continueButtonTaped() {
        guard let navigationController = self.navigationController else { return }

        let numberOfItems = self.collectionView.numberOfItems(inSection: 0)
        let nextRow = self.currentIndex + 1

        if nextRow < numberOfItems {
            let nextIndexPath = IndexPath(item: nextRow, section: 0)
            self.collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            self.currentIndex = nextRow
            self.rate()
        } else {
            DetailRouter.showFilterViewController(in: navigationController)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleItems = collectionView.indexPathsForVisibleItems.sorted()
        if let visibleItem = visibleItems.first {
            currentIndex = visibleItem.item
        }
    }

    private func rate() {
        guard let scene = view.window?.windowScene else { return }
        if #available(iOS 14.0, *) {
            SKStoreReviewController.requestReview()
        } else {
            let alertController = UIAlertController(
                title: "Enjoying the app?",
                message: "Please consider leaving us a review in the App Store!",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Go to App Store", style: .default) { _ in
                if let appStoreURL = URL(string: "https://apps.apple.com/us/app/1-sports-tracker-pro/id6737613539") {
                    UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
                }
            })
            present(alertController, animated: true, completion: nil)
        }
    }
}

extension DetailViewController: IViewModelableController {
    typealias ViewModel = IDetailViewModel
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel?.detailsItems.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DetailCell = collectionView.dequeueReusableCell(for: indexPath)
        descriptionLabel.text = viewModel?.detailsItems[indexPath.row].description
        header.text = viewModel?.detailsItems[indexPath.row].header
        cell.setup(image: viewModel?.detailsItems[indexPath.row].image ?? "")
        return cell
    }
}

//MARK: Preview
import SwiftUI

struct DetailViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let detailViewController = DetailViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<DetailViewControllerProvider.ContainerView>) -> DetailViewController {
            return detailViewController
        }

        func updateUIViewController(_ uiViewController: DetailViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<DetailViewControllerProvider.ContainerView>) {
        }
    }
}
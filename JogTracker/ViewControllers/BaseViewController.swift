//
//  BaseViewController.swift
//  JogTracker
//
//  Created by Ольга Бычок on 07/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class BaseViewController: ViewController {
    
    let bannerView = BannerView()
    private let fillingView = UIView()
    
    private func setupBannerView() {
        self.bannerView.translatesAutoresizingMaskIntoConstraints = false
        self.bannerView.backgroundColor = UIColor(red:0.49, green:0.83, blue:0.13, alpha:1.0)
        self.view.addSubview(self.bannerView)
        self.bannerView.setupSubviews()
        self.bannerView.menuButton.addTarget(self, action: #selector(menuAction), for: .touchUpInside)
    }
    
    private func setupFillingView() {
        self.fillingView.translatesAutoresizingMaskIntoConstraints = false
        self.fillingView.backgroundColor = UIColor(red:0.49, green:0.83, blue:0.13, alpha:1.0)
        self.view.addSubview(self.fillingView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBannerView()
        self.setupFillingView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.doLayout()
    }
    
    private func doLayout() {
        let guide = view.safeAreaLayoutGuide
        self.bannerView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        self.bannerView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        self.bannerView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        self.bannerView.heightAnchor.constraint(equalToConstant: 77).isActive = true
        self.bannerView.doLayout()
        self.fillingView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        self.fillingView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        self.fillingView.bottomAnchor.constraint(equalTo: self.bannerView.topAnchor).isActive = true
        self.fillingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    @objc func addNewJog() {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        guard let addVC  = storyboard.instantiateViewController(withIdentifier: "AddJogViewController") as? AddJogViewController else {return}
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
}

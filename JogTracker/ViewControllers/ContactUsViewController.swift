//
//  ContactUsViewController.swift
//  JogTracker
//
//  Created by Ольга Бычок on 10/03/2020.
//  Copyright © 2020 Ольга Бычок. All rights reserved.
//

import UIKit

class ContactUsViewController: BaseViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textTextField: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let viewModel = ContactViewModel()

    @IBAction func sendMessageButton(_ sender: UIButton) {
        self.viewModel.sendFeedback(text: textTextField.text ?? "", title: titleTextField.text ?? "", handler: self.handler)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bannerView.menuButton.isHidden = true
        addKeyboardNotificationObserver()
        addTapGestureToScrollView()
        scrollView.delegate = self
    }
    
    override func navigateToNextController() {
        self.showMessage(title: "", error: "Your message is succesfully sent", withHandler: { () in
            self.openMainMenu()
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension ContactUsViewController: UIScrollViewDelegate {
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func addTapGestureToScrollView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tap)
    }
    
    private func addKeyboardNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func keyboardDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrameSizeValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            else {return}
        let keyboardFrameSize = keyboardFrameSizeValue.cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardFrameSize.height)
    }
    
    @objc func keyboardDidHide() {
        scrollView.contentOffset = CGPoint.zero
    }
}



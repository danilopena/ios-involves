//
//  ViewController.swift
//  ios-involves
//
//  Created by Danilo Pena on 20/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit
import TraktKit
import SafariServices

class HomeViewController: UIViewController {

    @IBOutlet weak var buttonSignIn: RoundedButton!
    @IBOutlet weak var jamesPicture: UIImageView! {
        didSet {
            jamesPicture.makeCircle()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupObservers()
    }
    
    private func setupObservers() {
        NotificationCenter.default.observeOnce(forName: .TraktSignedIn) { [weak self] _ in
            self?.dismiss(animated: true, completion: {
                self?.performSegue(withIdentifier: SegueIdentifier.sendToLoggedArea, sender: self)
            })
        }
    }
    
    @IBAction private func presentLogIn() {
        guard let oauthURL = TraktManager.sharedManager.oauthURL else { return }

        let traktAuth = SFSafariViewController(url: oauthURL)
        present(traktAuth, animated: true, completion: nil)
    }
}


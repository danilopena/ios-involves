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

    // -------------      -------------
    // MARK: IBOutlets
    // -------------      -------------
    
    @IBOutlet weak var buttonSignIn: RoundedButton!
    @IBOutlet weak var jamesPicture: UIImageView! {
        didSet {
            jamesPicture.makeCircle()
        }
    }
    
    // -------------      -------------
    // MARK: Native Functions
    // -------------      -------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if TraktManager.sharedManager.isSignedIn {
            self.performSegue(withIdentifier: SegueIdentifier.sendToLoggedArea, sender: self)
        }
    }
    
    // -------------      -------------
    // MARK: Auxiliar Functions
    // -------------      -------------
    
    /// This method will observer if SignedIn/Login has finished and will dismiss Safari, sending to logged area.
    private func setupObservers() {
        NotificationCenter.default.observeOnce(forName: .TraktSignedIn) { [weak self] _ in
            self?.dismiss(animated: true, completion: {
                self?.performSegue(withIdentifier: SegueIdentifier.sendToLoggedArea, sender: self)
            })
        }
    }
    
    
    // -------------      -------------
    // MARK: IBActions
    // -------------      -------------
    
    /// Add SFSafariViewController to authenticate.
    @IBAction internal func presentLogIn() {
        guard let oauthURL = TraktManager.sharedManager.oauthURL else { return }

        let traktAuth = SFSafariViewController(url: oauthURL)
        present(traktAuth, animated: true, completion: nil)
    }
}


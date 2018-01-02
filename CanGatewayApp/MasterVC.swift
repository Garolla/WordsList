//
//  MasterVC.swift
//  SocialNetwork
//
//  Created by Emanuele Garolla on 23/12/17.
//  Copyright © 2017 Emanuele Garolla. All rights reserved.
//

import UIKit

// Enum for individuate the Style of the NavigationBar
enum NavigationBarStyle {
    case weirdBluBar
}

// Enun to individuate the Buttons that needs to be added to the navigation bar
enum NavigationBarButtons {
    case share
    case edit
    case signOut  
    case backNative
    case add
    case search
    case done(title: String, enable: Bool)
}

class MasterVC: UIViewController {
    
    private var isMenuButton: Bool = false
    
    //MARK: UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    //MARK: var & let
    
    // When setted, this var will change the style of the Navigation Bar
    var barStyle: NavigationBarStyle? {
        didSet {
            let tintColor = takeColorFromPalette(barStyle: barStyle!)
            self.navigationController?.navigationBar.barTintColor = tintColor
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        }
    }
    
    // When setted, this var will change the right buttons in Navigation Bar. You need to provide the button type in order of visualization (first the most left, last the most right)
    var rightButtons: [NavigationBarButtons]? {
        didSet{
            var buttonsArray = [UIBarButtonItem]()
            defer {
                self.navigationItem.setRightBarButtonItems(buttonsArray, animated: false)
            }
            guard let buttons = rightButtons else {
                return
            }
            
            for buttonType in buttons.reversed() {
                if let b = self.getButtonItem(withType: buttonType) {
                    buttonsArray.append(b)
                }
            }
        }
    }
    
    // When setted, this var will change the left buttons in Navigation Bar. You need to provide the button type in order of visualization (first the most left, last the most right)
    var leftButtons: [NavigationBarButtons]? {
        didSet{
            var buttonsArray = [UIBarButtonItem]()
            defer {
                self.navigationItem.setLeftBarButtonItems(buttonsArray, animated: false)
            }
            guard let buttons = leftButtons else {
                return
            }
            for buttonType in buttons {
                if let b = self.getButtonItem(withType: buttonType) {
                    buttonsArray.append(b)
                }
            }
        }
    }
    
    // MARK: VC Methods
    deinit {
        print("deinit \(self)")
    }
    
    //MARK: private methods
    
    // This function get the type of button to be designed and return it
    private func getButtonItem(withType type: NavigationBarButtons) -> UIBarButtonItem? {
        var b: UIBarButtonItem?
        isMenuButton = false
        switch type {
        case .share:
            b = UIBarButtonItem(image: #imageLiteral(resourceName: "NavigationBarShare"), style: .plain, target: self, action: #selector(self.share))
        case .edit:
            b = UIBarButtonItem(image: #imageLiteral(resourceName: "NavigationBarEdit"), style: .plain, target: self, action: #selector(self.edit))
        case .signOut:
            let customBackButton = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 20.5))
            let g = UITapGestureRecognizer(target: self, action: #selector(self.dismissSelf))
            customBackButton.addGestureRecognizer(g)
            customBackButton.isUserInteractionEnabled = true
            let imageBack = UIImageView(frame: CGRect(x: 0, y: 0, width: 20.5, height: 20.5))
            imageBack.image = #imageLiteral(resourceName: "sign-out")
            let labelBack = UILabel(frame: CGRect(x: 20.5, y: 0, width: 59.5, height: 20.5))
            labelBack.text = " Out"
            labelBack.textColor = UIColor.white
            customBackButton.addSubview(imageBack)
            customBackButton.addSubview(labelBack)
            b = UIBarButtonItem(customView: customBackButton)
        case .backNative:
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        case .add:
            b = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.add))
        case .search:
            b = UIBarButtonItem(title: "Search", style: .plain, target: self, action: nil)
        case .done(let title, let enable):
            b = UIBarButtonItem(title: title, style: .done, target: self, action: #selector(self.done))
            b?.isEnabled = enable
        }
        return b
    }
    
    func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
    
    open func add() {}
    
    open func share() {}
    
    open func edit() {}
    
    open func done() {}
    
    private func takeColorFromPalette(barStyle: NavigationBarStyle) -> UIColor {
        var color = UIColor()
        switch barStyle {
        case .weirdBluBar:
            color = UIColor(red: 0 / 255, green: 188 / 255, blue: 212 / 255, alpha: 1)
        }
        return color
    }
}


//
//  PinkyPromiseViewController.swift
//  iMessageTest MessagesExtension
//
//  Created by Feargal Walsh on 10/7/17.
//  Copyright © 2017 Feargal Walsh. All rights reserved.
//

import Foundation
import UIKit

class PinkyPromiseViewController: UICollectionViewController {
    //Mark: Types
    
    enum CollectionViewItem {
        case pinkyPromise
    }
    
    static let storyboardIdentifier = "PinkyPromiseViewController"
    
    var pinkyPromise: PinkyPromise?
}

protocol PinkyPromiseViewControllerDelegate: class {
    ///Called when a user chooses to add a new Pinky Promise in the PinkyPromiseViewController
    func pinkyPromiseViewControllerDidSelectAdd( _ controller:
    PinkyPromiseViewController)
}

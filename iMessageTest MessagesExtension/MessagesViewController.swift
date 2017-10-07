//
//  MessagesViewController.swift
//  iMessageTest MessagesExtension
//
//  Created by Feargal Walsh on 9/30/17.
//  Copyright © 2017 Feargal Walsh. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
    
    var browserViewController:pinkyPromiseStickerBrowserViewController!
    override func didBecomeActive(with conversation: MSConversation) {
        super.didBecomeActive(with: conversation)
        presentChildViewController()
    }
    //MARK: Child view controller presentation
    private func presentChildViewController() {
        var controller = UIViewController()
        if presentationStyle == .compact {
            let pinkyPromise = PinkyPromise(isPressed: false)
            controller = instantiatePinkyPromiseController(with: pinkyPromise)
        } else {
            //isPressed true?
            let pinkyPromise = PinkyPromise(isPressed: false)
            controller = instantiatePinkyPromiseController(with: pinkyPromise)
        }
        
        
        //embed the new controller
        addChildViewController(controller)
        
        controller.view.frame = view.bounds
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        
        
        controller.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        controller.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        controller.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        controller.didMove(toParentViewController: self)
    }
    
    
    private func instantiatePinkyPromiseController(with pinkyPromise: PinkyPromise) -> UIViewController {
       //Instantiate a "PinkyPromiseController"
        guard let controller =
        storyboard?.instantiateViewController(withIdentifier: PinkyPromiseViewController.storyboardIdentifier) as?
            PinkyPromiseViewController else { fatalError("Unable to instantiate PinkyPromiseViewController from the storyboard") }
        
            //controller.delegate = self
                
            return controller
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        super.willTransition(to: presentationStyle)
        presentChildViewController()
        // Called before the extension transitions to a new presentation style.
        
        // Use this method to prepare for the change in presentation style.
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        browserViewController = pinkyPromiseStickerBrowserViewController(stickerSize: .regular)
        browserViewController.view.frame = self.view.frame
        
        self.addChildViewController(browserViewController)
        browserViewController.didMove(toParentViewController: self)
        self.view.addSubview(browserViewController.view)
        
        browserViewController.loadStickers()
        browserViewController.stickerBrowserView.reloadData()
        browserViewController.changeBrowserViewBackgroundColour(color: UIColor.init(red: 1.0, green: 0.58, blue: 0.68, alpha: 1))
       
    }
    
    fileprivate func composeMessage(with pinkyPromise: PinkyPromise, caption: String, session: MSSession? = nil) -> MSMessage {
        let messageCaption = NSLocalizedString("Wanna Pinky Promise?", comment: " ")
        
       // var components = URLComponents()
        //components.queryItems = pinkyPromise.queryItems
        let layout = MSMessageTemplateLayout()
        
        //caption = Wanna pinky promise?
        layout.caption = messageCaption
        

        let message = MSMessage()
        message.layout = layout
        message.accessibilityLabel = messageCaption
        return message
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//extension MessagesViewController : pinkyPromiseHistoryViewControllerDelegate {
//    func historyViewControllerAddButtonTapped(_ controller: pinkyPromiseHistoryViewController){
//        requestPresentationStyle(.expanded)
//        //composeMessage(with: <#T##PinkyPromise#>, caption: <#T##String#>)
//    }
//}
//
//    extension MessagesViewController: pinkyPromiseViewControllerDelegate {
//        func pinkyPromiseBuilderViewController( _ controller: pinkyPromiseBuilderViewController,
//                                                didSelect pinkyPromiseHalf: PinkyPromiseHalf, for pinkyPromise: PinkyPromise){
//            var messageCaption = string
//            composeMessage(with: pinkyPromise, caption: messageCaption)
//            dismiss()
//        }
//    }

    








    
//    // MARK: - Conversation Handling
//
//    override func willBecomeActive(with conversation: MSConversation) {
//        // Called when the extension is about to move from the inactive to active state.
//        // This will happen when the extension is about to present UI.
//
//        // Use this method to configure the extension and restore previously stored state.
//    }
//
//    override func didResignActive(with conversation: MSConversation) {
//        // Called when the extension is about to move from the active to inactive state.
//        // This will happen when the user dissmises the extension, changes to a different
//        // conversation or quits Messages.
//
//        // Use this method to release shared resources, save user data, invalidate timers,
//        // and store enough state information to restore your extension to its current state
//        // in case it is terminated later.
//    }
//
//    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
//        // Called when a message arrives that was generated by another instance of this
//        // extension on a remote device.
//
//        // Use this method to trigger UI updates in response to the message.
//    }
//
//    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
//        // Called when the user taps the send button.
//    }
//
//    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
//        // Called when the user deletes the message without sending it.
//
//        // Use this to clean up state related to the deleted message.
//    }
//


//    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
//        // Called after the extension transitions to a new presentation style.
//
//        // Use this method to finalize any behaviors associated with the change in presentation style.
//    }
//
//}


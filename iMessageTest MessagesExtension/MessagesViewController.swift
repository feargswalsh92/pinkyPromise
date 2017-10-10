import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
    
    
    //        // Called when the extension is about to move from the inactive to active state.
    //        // This will happen when the extension is about to present UI.
    //
    //        // Use this method to configure the extension and restore previously stored state.
    override func willBecomeActive(with conversation: MSConversation) {
        print("will become active called")
        
        super.willBecomeActive(with: conversation)
        
        presentViewController(for: conversation, with: presentationStyle)
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        super.didTransition(to: presentationStyle)
        print("didTransition to called")
        guard let conversation = activeConversation else { fatalError("Expected an active conversation")}
        presentViewController(for: conversation, with: presentationStyle)
    }
    
    var browserViewController:pinkyPromiseStickerBrowserViewController!
    override func didBecomeActive(with conversation: MSConversation) {
        super.didBecomeActive(with: conversation)
        presentViewController(for: conversation, with: presentationStyle)
    }
    //MARK: Child view controller presentation
    private func presentViewController(for conversation: MSConversation, with presentationStyle: MSMessagesAppPresentationStyle) {
        
        removeAllChildViewControllers()
        
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
    
    private func removeAllChildViewControllers() {
        for child in childViewControllers {
            child.willMove(toParentViewController: nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
    }
    
    private func instantiatePinkyPromiseController(with pinkyPromise: PinkyPromise) -> UIViewController {
        //Instantiate a "PinkyPromiseViewController"
        guard let controller =
            storyboard?.instantiateViewController(withIdentifier: PinkyPromiseViewController.storyboardIdentifier) as?
            PinkyPromiseViewController else { fatalError("Unable to instantiate PinkyPromiseViewController from the storyboard") }
        
        //controller.delegate = self
        
        return controller
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        super.willTransition(to: presentationStyle)
        removeAllChildViewControllers()
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
       // layout.image = pinkyPromise.renderSticker
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

extension MessagesViewController : PinkyPromiseViewControllerDelegate {
    
    
    func pinkyPromiseViewControllerDidSelectAdd(_ controller: PinkyPromiseViewController){
        guard let conversation = activeConversation else { fatalError("Expected a conversation") }
        
        guard let pinkyPromise = controller.pinkyPromise else { fatalError("Expected a pinky promise")}
        
        let messageCaption: String = "Wanna pinky promise?"
        
    
        let message = composeMessage(with: pinkyPromise, caption: messageCaption)
        
        conversation.insert(message) { error in
            if let error = error {
                print(error)
            }
        }
//        requestPresentationStyle(.expanded)
        //composeMessage(with: <#T##PinkyPromise#>, caption: <#T##String#>)
    }
}
//
//extension MessagesViewController: BuildPinkyPromiseViewControllerDelegate {
//        func pinkyPromiseBuilderViewController( _ controller: pinkyPromiseBuilderViewController,
//}
//                                                didSelect pinkyPromiseHalf: PinkyPromiseHalf, for pinkyPromise: PinkyPromise){
//            var messageCaption = string
//            composeMessage(with: pinkyPromise, caption: messageCaption)
//            dismiss()
//        }
//    }















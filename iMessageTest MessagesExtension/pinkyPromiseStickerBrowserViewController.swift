//
//  pinkyPromiseStickerBrowserViewController.swift
//  iMessageTest MessagesExtension
//
//  Created by Feargal Walsh on 10/3/17.
//  Copyright © 2017 Feargal Walsh. All rights reserved.
//

import Foundation
import UIKit
import Messages


class pinkyPromiseStickerBrowserViewController: MSStickerBrowserViewController {
   
    
    func changeBrowserViewBackgroundColour(color: UIColor) {
        stickerBrowserView.backgroundColor = color
    }
    
    func loadStickers() {
        createSticker(asset: "PinkyPromiseStickerMedium", localizedDescription: "pinkyPromise sticker")
        createSticker(asset: "002", localizedDescription: "cat sticker")
    }
    
    var stickers = [MSSticker]()
    func createSticker(asset: String, localizedDescription: String) {
        guard let stickerPath = Bundle.main.path(forResource: asset, ofType:"png") else {
            print("couldn't create the sticker path for", asset)
            return
        }
        let stickerURL = URL(fileURLWithPath: stickerPath)
        
        let sticker: MSSticker
        
        do {
            try sticker = MSSticker(contentsOfFileURL: stickerURL,
                            localizedDescription: localizedDescription)
            
                            stickers.append(sticker)
        } catch {
            print(error)
            return
        }
    }
    
    override func numberOfStickers(in stickerBrowserView: MSStickerBrowserView) -> Int {
        return stickers.count
    }
    
    override func stickerBrowserView(_ stickerBrowserView: MSStickerBrowserView, stickerAt i: Int) -> MSSticker {
        return stickers[i]
    }
    
    
}

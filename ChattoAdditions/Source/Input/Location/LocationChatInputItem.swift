//
//  LocationChatInputItem.swift
//  ChattoAdditions
//
//  Created by Ninh Vo on 2/4/18.
//  Copyright © 2018 Badoo. All rights reserved.
//

import Foundation
import UIKit

protocol LocationChatInputDelegate: class {
    func inputView(_ inputView: PhotosInputViewProtocol, didSelectImage image: UIImage)
}

open class LocationChatInputItem: ChatInputItemProtocol {
    typealias Class = LocationChatInputItem
    
    public var inputView: UIView?
    public var locationButtonDidTap: (() -> Void)?
    open var tabView: UIView {
        return self.internalTabView
    }
    
    open var presentationMode: ChatInputItemPresentationMode
    
    open var showsSendButton: Bool {
        return true
    }
    
    open var selected: Bool = false
    
    lazy private var internalTabView: UIButton = {
        return TabInputButton.makeInputButton(withAppearance: self.buttonAppearance, accessibilityID: "location.chat.input.view")
    }()
    
    public func handleInput(_ input: AnyObject) {
        
    }
    
    @objc func onLocationTapped(_ sender: Any) {
        print("Location button tap...")
        locationButtonDidTap?()
    }
    
    let buttonAppearance: TabInputButtonAppearance
    
    public init(tabInputButtonAppearance: TabInputButtonAppearance = Class.createDefaultButtonAppearance()){
        self.buttonAppearance = tabInputButtonAppearance
        self.presentationMode = .none
        self.internalTabView.addTarget(self, action: #selector(self.onLocationTapped(_:)), for: .touchUpInside)
    }
    
    public static func createDefaultButtonAppearance() -> TabInputButtonAppearance {
        let images: [UIControlStateWrapper: UIImage] = [
            UIControlStateWrapper(state: .normal): UIImage(named: "send_gps", in: Bundle(for: Class.self), compatibleWith: nil)!,
            UIControlStateWrapper(state: .selected): UIImage(named: "send_gps", in: Bundle(for: Class.self), compatibleWith: nil)!,
            UIControlStateWrapper(state: .highlighted): UIImage(named: "send_gps", in: Bundle(for: Class.self), compatibleWith: nil)!
        ]
        return TabInputButtonAppearance(images: images, size: nil)
    }
}


//
//  Protocols.swift
//  Photo Editor
//
//  Created by Mohamed Hamed on 6/15/17.
//
//

import Foundation
import UIKit
/**
 - didSelectView
 - didSelectImage
 - stickersViewDidDisappear
 */

public protocol PhotoEditorDelegate {
    /**
     - Parameter image: edited Image
     */
    func doneEditing(image: UIImage,isImageEditing:Bool)

    /**
     StickersViewController did Disappear
     */
    func canceledEditing()
    /**
       Edited image with caption text
     */
    func doneEditing(image: UIImage,
                     captionText: String)
}


/**
 - didSelectView
 - didSelectImage
 - stickersViewDidDisappear
 */
protocol StickersViewControllerDelegate {
    /**
     - Parameter view: selected view from StickersViewController
     */
    func didSelectView(view: UIView)
    /**
     - Parameter image: selected Image from StickersViewController
     */
    func didSelectImage(image: UIImage)
    /**
     StickersViewController did Disappear
     */
    func stickersViewDidDisappear()
}

/**
 - didSelectColor
 */
protocol ColorDelegate {
    func didSelectColor(color: UIColor)
}

//
//  PhotoEditor+Keyboard.swift
//  Pods
//
//  Created by Mohamed Hamed on 6/16/17.
//
//

import Foundation
import UIKit

extension PhotoEditorViewController {
    
    @objc func keyboardWillShow(_ notification: Notification) {
        print(#function)
        isKeyboardVisible = true
        if captionTextView.isFirstResponder {
            /// If caption text view is tapped then show text view above keyboard.
            guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            let keyboardHeight = keyboardFrame.height
            self.bottomConstarintTextView.constant = keyboardHeight + 8
            self.colorPickerViewBottomConstraint.constant = keyboardHeight + 8 + captionTextView.frame.height
        } else {
            //When keyboard will show set frame of color picker
            if let userInfo = notification.userInfo {
                let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
                let includeCaptionTextViewHeight = isCaptionTextViewActive() ? captionTextView.frame.height : 0.0
                self.colorPickerViewBottomConstraint.constant = (endFrame?.height ?? 0.0) + includeCaptionTextViewHeight
            }
        }
        self.view.layoutIfNeeded()

        
    }
    

    @objc func keyboardDidShow(notification: NSNotification) {
        if captionTextView.isFirstResponder {
        } else {
            if isTyping {
                doneButton.isHidden = false
                colorPickerView.isHidden = false
                hideToolbar(hide: true)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        ///Reset caption text view, bottom constraint as keyboard is hided.
        self.bottomConstarintTextView.constant = defaultBottomSpaceTextView
        self.colorPickerViewBottomConstraint.constant = defaultBottomSpaceTextView + captionTextView.frame.height
        self.view.layoutIfNeeded()

        isTyping = false
        doneButton.isHidden = true
        hideToolbar(hide: false)
        isKeyboardVisible = false
    }
    
    @objc func keyboardWillChangeFrame(_ notification: NSNotification) {
        print(#function)
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.colorPickerViewBottomConstraint?.constant = defaultBottomSpaceTextView + captionTextView.frame.height
            } else {
                let includeCaptionTextViewHeight = isCaptionTextViewActive() ? captionTextView.frame.height : 0.0
                print("includeCaptionTextViewHeight \(includeCaptionTextViewHeight)")
                self.colorPickerViewBottomConstraint?.constant = (endFrame?.size.height ?? 0.0) + includeCaptionTextViewHeight
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    func isCaptionTextViewActive() -> Bool {
        self.bottomConstarintTextView.constant > 200.0
    }

}

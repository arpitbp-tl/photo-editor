//
//  PhotoEditor+UITextView.swift
//  Pods
//
//  Created by Mohamed Hamed on 6/16/17.
//
//

import Foundation
import UIKit

extension PhotoEditorViewController: UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {
        if textView == captionTextView {
            /// When text view content added, increase the textView height to max height.
            let oldHeight = textView.frame.size.height
            let maxHeight: CGFloat = textViewMaxHeight //beyond this value the textView will scroll
            var newHeight = min(textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude)).height, maxHeight)
            newHeight = ceil(newHeight)
            if newHeight != oldHeight {
                textView.frame.size.height = max(newHeight, textViewDefaultHeight)
                updateTextViewHeight(height: newHeight)
            }
        } else {
            let rotation = atan2(textView.transform.b, textView.transform.a)
            if rotation == 0 {
                let oldFrame = textView.frame
                let sizeToFit = textView.sizeThatFits(CGSize(width: oldFrame.width, height:CGFloat.greatestFiniteMagnitude))
                textView.frame.size = CGSize(width: oldFrame.width, height: sizeToFit.height)
            }
        }
    }
    
    public func updateTextViewHeight(height: CGFloat) {
       heightConstraintCaptionTextView.constant = max(textViewDefaultHeight, height)
       view.layoutIfNeeded()
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == captionTextView {
            if textView.text == placeHoldeTextForCaption {
               textView.text = ""
               textView.textColor = .black
            }
        } else {
            isTyping = true
            lastTextViewTransform =  textView.transform
            lastTextViewTransCenter = textView.center
            lastTextViewFont = textView.font!
            activeTextView = textView
            textView.superview?.bringSubviewToFront(textView)
            textView.font = UIFont(name: "Helvetica", size: 30)
            UIView.animate(withDuration: 0.3,
                           animations: {
                textView.transform = CGAffineTransform.identity
                textView.center = CGPoint(x: UIScreen.main.bounds.width / 2,
                                          y:  UIScreen.main.bounds.height / 5)
            }, completion: nil)
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView == captionTextView {
            if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                textView.text = placeHoldeTextForCaption
                textView.textColor = .lightGray
            }
        } else {
            guard lastTextViewTransform != nil && lastTextViewTransCenter != nil && lastTextViewFont != nil
            else {
                return
            }
            activeTextView = nil
            textView.font = self.lastTextViewFont!
            UIView.animate(withDuration: 0.3,
                           animations: {
                textView.transform = self.lastTextViewTransform!
                textView.center = self.lastTextViewTransCenter!
            }, completion: nil)
        }
    }
    
}

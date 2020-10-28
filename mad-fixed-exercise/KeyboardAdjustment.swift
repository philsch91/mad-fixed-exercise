

import UIKit

class KeyboardAdjustment: NSObject {
    weak var scrollView: UIScrollView!
    let initialContentInset: UIEdgeInsets
    let initialScrollIndicatorInsets: UIEdgeInsets

    init(scrollView: UIScrollView) {
        self.scrollView = scrollView
        initialContentInset = scrollView.contentInset
        initialScrollIndicatorInsets = scrollView.scrollIndicatorInsets
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notificaton:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notificaton:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notificaton: Notification) {
        if let userInfo = notificaton.userInfo {
            if let keyboardRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue {
                /**
                 Adjust the contentInset and scrollIndicatorInsets of the set UIScrollView
                 with respect to the final keyboard frame in the form of a CGRect
                 that is passed with the keyboardFrameEndUserInfoKey key in the userInfo dictionary of the NSNotification with the name keyboardWillShowNotification
                 https://developer.apple.com/documentation/foundation/nsnotification/name
                 */
                let contentInset = UIEdgeInsets(top: scrollView.contentInset.top, left: scrollView.contentInset.left, bottom: keyboardRect.height, right: scrollView.contentInset.right)
                let scrollIndicatorInsets = UIEdgeInsets(top: scrollView.scrollIndicatorInsets.top, left: scrollView.scrollIndicatorInsets.left, bottom: keyboardRect.height, right: scrollView.scrollIndicatorInsets.right)
                scrollView.contentInset = contentInset
                scrollView.scrollIndicatorInsets = scrollIndicatorInsets
            }
        }
    }
    
    @objc func keyboardWillHide(notificaton: Notification) {
        /**
         Set the contentInset and scrollIndicatorInsets of the UIScrollView
         to their initial values
         */
        let contentInset = UIEdgeInsets(top: scrollView.contentInset.top, left: scrollView.contentInset.left, bottom: initialContentInset.bottom, right: scrollView.contentInset.right)
        let scrollIndicatorInsets = UIEdgeInsets(top: scrollView.scrollIndicatorInsets.top, left: scrollView.scrollIndicatorInsets.left, bottom: initialScrollIndicatorInsets.bottom, right: scrollView.scrollIndicatorInsets.right)

        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = scrollIndicatorInsets
    }
}

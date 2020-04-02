//
//  MNkTextViewNoPadding.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 6/11/18.
//

import UIKit
@IBDesignable open class MNkTextViewNoPadding:UITextView{
    open override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }
    
    private func configure(){
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
    }
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        isScrollEnabled = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isScrollEnabled = false
    }
}

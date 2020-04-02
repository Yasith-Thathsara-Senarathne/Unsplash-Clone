//
//  MNkTextFieldWithError.swift
//  MNkSupportUtilities
//
//  Created by Malith Nadeeshan on 3/23/19.
//

import Foundation

open class MNkTextFieldWithError:MNkView{
    
    public var textField:MNkTextField!
    public var errLabel:UILabel!
    
    public var textFieldHeight:CGFloat = 36{
        didSet{
            textFieldHeightAnch?.constant = textFieldHeight
        }
    }
    
    private var stackview:UIStackView!
    private var textFieldHeightAnch:NSLayoutConstraint?
    
    open override func createViews() {
        textField = MNkTextField()
        
        errLabel = UILabel()
        errLabel.font = UIFont.systemFont(ofSize: 11, weight: .light)
        errLabel.textColor = UIColor.lightGray
        errLabel.numberOfLines = 3
        
        stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .fill
        stackview.distribution = .fill
        stackview.spacing = 6
        
    }
    
    open override func insertAndLayoutSubviews() {
        addSubview(stackview)
        stackview.addArrangedSubview(textField)
        stackview.addArrangedSubview(errLabel)
        
        stackview.activateLayouts(to: self)
        
        textFieldHeightAnch = textField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        textFieldHeightAnch?.isActive = true
    }
    
    open override func config() {
        backgroundColor = .clear
    }
}


/*..........................................................
 MARK:- Validatable textview protocol implementation
 ..........................................................*/

extension MNkTextFieldWithError:MNkValidatableTextView{
    public var textView: UIView {
        return textField
    }
    
    public var errorBorderView: UIView?{
        return textField.errBorderView
    }
    
    public var errorLabel: UILabel?{
        return errLabel
    }
}

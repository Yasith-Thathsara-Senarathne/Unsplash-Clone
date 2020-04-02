//
//  MNkAlertView.swift
//
//  Created by Malith Nadeeshan on 6/13/18.
//  Copyright © 2018 Malith Nadeeshan. All rights reserved.
//


public protocol MNkAlertDelegate{
    func userPerformAlertAction(_ action:MNkAlertView.MNkAlertAction)
}

open class MNkAlertView:MNkView{
    
    public enum MNkAlertType{
        case single
        case multi
    }
    public enum MNkAlertAction{
        case accept
        case cancel
    }
    ///Alert properies to config alert view.
    public enum AlertPropertyKeys{
        case leftActionTextColor
        case leftActionBGColor
        case rightActionTextColor
        case rightActionBGColor
        case leftActionText
        case rightActionText
        case aligment
        case titleColor
        case messageColor
    }
    
    public enum Aligment{
        case leftRight
        case rightLeft
        case right
        case left
        case center
    }
    
    public var delegate:MNkAlertDelegate?
    
    public var title:String?
    public var message:String?
    public var type:MNkAlertType = .single
    public var properties:[AlertPropertyKeys:Any] = [:]
    
    //    --------------------------------------------------------
    //    MARK:- Create static veriables for default values of app
    //    --------------------------------------------------------
    public var aligment:Aligment = .center
    public var titleFont:UIFont = UIFont.systemFont(ofSize: 18, weight: .medium){
        didSet{
            titleLabel.font = titleFont
        }
    }
    public var messageFont:UIFont = UIFont.systemFont(ofSize: 14, weight: .regular){
        didSet{
            messageLabel.font = messageFont
        }
    }
    public var buttonTitleFont:UIFont = UIFont.systemFont(ofSize: 16, weight: .medium){
        didSet{
            rightActionButton.titleLabel?.font = buttonTitleFont
            leftActionButton.titleLabel?.font = buttonTitleFont
        }
    }
    public var titleColor:UIColor =  #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1){
        didSet{
            titleLabel.textColor = titleColor
        }
    }
    public var messageColor:UIColor = .black{
        didSet{
            messageLabel.textColor = messageColor
        }
    }
    public var buttonTitleColor:UIColor = .gray{
        didSet{
            rightActionButton.setTitleColor(buttonTitleColor, for: .normal)
            leftActionButton.setTitleColor(buttonTitleColor, for: .normal)
        }
    }
    public var buttonBackgroundColor:UIColor = .white{
        didSet{
            titleLabel.font = titleFont
        }
    }
    
    //    ---------------------------------
    //    MARK:- Create and layout subviews
    //    ---------------------------------
    public var titleLabel:UILabel!
    public var messageLabel:UILabel!
    public var leftActionButton:UIButton!
    public var rightActionButton:UIButton!
    public var buttonStackview:UIStackView!
    public var alertContainer:UIView!
    public var mainStackView:UIStackView!
    
    override open func createViews() {
        alertContainer = UIView()
        alertContainer.clipsToBounds = true
        alertContainer.layer.cornerRadius = 9
        alertContainer.backgroundColor = .white
        alertContainer.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel = UILabel()
        titleLabel.text = "heading"
        titleLabel.font = titleFont
        titleLabel.textColor = titleColor
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel = UILabel()
        messageLabel.text = "Message of alert"
        messageLabel.numberOfLines = 0
        messageLabel.font = messageFont
        messageLabel.textColor = messageColor
        messageLabel.textAlignment = .center
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leftActionButton = UIButton()
        leftActionButton.setTitle("Cancel", for: .normal)
        leftActionButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 12, bottom: 8, right: 12)
        leftActionButton.titleLabel?.font = buttonTitleFont
        leftActionButton.setTitleColor(buttonTitleColor, for: .normal)
        
        rightActionButton = UIButton()
        rightActionButton.setTitle("OK", for: .normal)
        rightActionButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 12, bottom: 8, right: 12)
        rightActionButton.titleLabel?.font = buttonTitleFont
        rightActionButton.setTitleColor(buttonTitleColor, for: .normal)
        
        buttonStackview = UIStackView()
        buttonStackview.axis = .horizontal
        buttonStackview.distribution = .fillEqually
        buttonStackview.spacing = 1
        buttonStackview.alignment = .fill
        buttonStackview.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        mainStackView.alignment = .center
    }
    
    
    override open func insertAndLayoutSubviews() {
        buttonStackview.addArrangedSubview(leftActionButton)
        buttonStackview.addArrangedSubview(rightActionButton)
        
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(messageLabel)
        mainStackView.addArrangedSubview(buttonStackview)
        
        self.addSubview(alertContainer)
        alertContainer.addSubview(mainStackView)
        
        mainStackView.activateLayouts(to: alertContainer, [.leading:0,.traling:0,.top:10,.bottom:0])
        
        NSLayoutConstraint.activate([alertContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     alertContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     alertContainer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
                                     alertContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 150)])
        
        NSLayoutConstraint.activate([titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
                                     titleLabel.widthAnchor.constraint(equalTo: alertContainer.widthAnchor, multiplier: 0.88),
                                     messageLabel.widthAnchor.constraint(equalTo: alertContainer.widthAnchor, multiplier: 0.88),
                                     buttonStackview.widthAnchor.constraint(equalTo: alertContainer.widthAnchor, multiplier: 1)])
    }
    
    override open func config() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        setPublicProperties()
    }
    
    
    //    ----------------------------------------------------------------------------------------------------------------------------------------------
    //    MARK:- Show alert view with heading and alert message
    //    -----------------------------------------------------------------------------------------------------------------------------------------------
    ///    Show alert view with heading and alert message
    ///    You can choose what type of your alert need to be by seting type. Single and multilple, Single only show ok button and action be default hide
    ///    By changing properties you can change button title -> text, color, background color like things.
    ///    And using action clouser, you can catch any action perform by user and give action you want.
    open func show(in targetView:UIView,perform buttonAction:@escaping ((MNkAlertAction)->Void)){
        
        setPrivateProperties()
        
        titleLabel.text = title
        messageLabel.text = message
        leftActionButton.isHidden = type == .single ? true : false
        
        self.alpha = 0
        targetView.addSubview(self)
        self.frame = targetView.bounds
        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.alpha = 1
            self.transform = .identity
        }, completion: nil)
        
        
        if type == .single || type == .multi{
            rightActionButton.addtargetClouser {[weak self]_ in
                self?.dismiss({ _ in
                    buttonAction(.accept)
                })
            }
        }
        
        if type == .multi{
            leftActionButton.addtargetClouser {[weak self]_ in
                self?.dismiss({ _ in
                    buttonAction(.cancel)
                })
            }
        }
    }
    
    public func dismiss(_ completed:@escaping(Bool)->Void){
        UIView.animate(withDuration: 0.4, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { isCompleted in
            self.removeFromSuperview()
            completed(isCompleted)
        }
    }
    
    
    private func setPublicProperties(){
        setAligment()
    }
    
    private func setPrivateProperties(){
        if let leftActionBGColor = (properties[.leftActionBGColor] as? UIColor){
            leftActionButton.backgroundColor = leftActionBGColor
        }
        if let leftActionTextColor = (properties[.leftActionTextColor] as? UIColor){
            leftActionButton.setTitleColor(leftActionTextColor, for: .normal)
        }
        if let rightActionTextColor = (properties[.rightActionTextColor] as? UIColor){
            rightActionButton.setTitleColor(rightActionTextColor, for: .normal)
        }
        if let rightActionBGColor = (properties[.rightActionBGColor] as? UIColor){
            rightActionButton.backgroundColor = rightActionBGColor
        }
        if let titlteColor = (properties[.titleColor] as? UIColor){
            titleLabel.textColor = titlteColor
        }
        if let messageColor = (properties[.messageColor] as? UIColor){
            messageLabel.textColor = messageColor
        }
        if let leftActionText = (properties[.leftActionText] as? String){
            leftActionButton.setTitle(leftActionText, for: .normal)
        }
        if let rightActionText = (properties[.rightActionText] as? String){
            rightActionButton.setTitle(rightActionText, for: .normal)
        }
        if let aligment = (properties[.aligment] as? Aligment){
            setAligment(aligment)
        }
    }
    
}



//    ------------------------------
//    MARK:- Set aligment properties
//    ------------------------------
extension MNkAlertView{
    
    private func setAligment(_ aligment:Aligment = .center){
        switch aligment{
        case .leftRight,.rightLeft,.right,.left:
            setTo(aligment)
        case .center:
            setToCenter()
        }
    }
    
    private func setTo(_ aligment:Aligment){
        let aligTopContent:NSTextAlignment = (aligment == Aligment.left || aligment == Aligment.leftRight) ? NSTextAlignment.left : .right
        let aligBottomContent:UIControl.ContentHorizontalAlignment = (aligment == Aligment.left || aligment == Aligment.rightLeft) ? UIControl.ContentHorizontalAlignment.left : .right
        let stackAligmnet:UIStackView.Alignment = (aligment == Aligment.left || aligment == Aligment.rightLeft) ? UIStackView.Alignment.leading : .trailing
        let leftACBtnPri:UILayoutPriority = (aligment == Aligment.left || aligment == Aligment.rightLeft) ? UILayoutPriority.defaultHigh : .defaultLow
        let rightACBtnPri:UILayoutPriority = (aligment == Aligment.left || aligment == Aligment.rightLeft) ? UILayoutPriority.defaultLow : .defaultHigh
        
        titleLabel.textAlignment = aligTopContent
        messageLabel.textAlignment = aligTopContent
        
        buttonStackview.distribution = .fill
        buttonStackview.alignment = stackAligmnet
        buttonStackview.spacing = 8
        
        leftActionButton.contentHorizontalAlignment = aligBottomContent
        rightActionButton.contentHorizontalAlignment = aligBottomContent
        
        leftActionButton.setContentHuggingPriority(leftACBtnPri, for: .horizontal)
        rightActionButton.setContentHuggingPriority(rightACBtnPri, for: .horizontal)
        
    }
    
    private func setToCenter(){
        titleLabel.textAlignment = .center
        messageLabel.textAlignment = .center
        
        buttonStackview.distribution = .fillEqually
        buttonStackview.alignment = .fill
        buttonStackview.spacing = 1
        
        leftActionButton.contentHorizontalAlignment = .center
        rightActionButton.contentHorizontalAlignment = .center
        
    }
    
}



//MARK:- SUPPORT EXTENSION AND TYPEALISE FOR UIBUTTON CLOUSER ACTION
typealias UIButtonTargetClouser = (UIButton) -> ()

extension UIButton{
    private struct AssociateKeys{
        static var teargetClouser = "targetClouser"
    }
    
    private var targetClouser:UIButtonTargetClouser?{
        get{
            guard let clouserWrapped = objc_getAssociatedObject(self, &AssociateKeys.teargetClouser) as? ClouserWrapped else{return nil}
            return clouserWrapped.clouser
        }
        set{
            guard let _newVal = newValue else{return}
            objc_setAssociatedObject(self, &AssociateKeys.teargetClouser, ClouserWrapped(_newVal), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addtargetClouser(clouser:@escaping UIButtonTargetClouser){
        targetClouser = clouser
        addTarget(self, action: #selector(UIButton.clouserAction), for: .touchUpInside)
    }
    
    @objc func clouserAction(){
        guard let _targetClouser = targetClouser else {return}
        _targetClouser(self)
    }
}

class ClouserWrapped:NSObject{
    let clouser:UIButtonTargetClouser
    init(_ clouser:@escaping UIButtonTargetClouser) {
        self.clouser = clouser
    }
}
//

//
//  BadgeButton.swift
//  Moju
//
//  Created by MNk_Dev on 28/12/18.
//  Copyright © 2018 azbow. All rights reserved.
//

public protocol BadgeButtonDelegate{
    func userTapped(_ badgeButton:BadgeButton)
}


open class BadgeButton:MNkView{
    
    public var delegate:BadgeButtonDelegate?
    
    public var value:Int = 0{
        didSet{
            badgeLabel.text = "\(value)"
        }
    }
    
    private lazy var button:UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(userTappedButton), for: .touchUpInside)
        btn.tintColor = UIColor.blue
        btn.imageView?.contentMode = .scaleAspectFit
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.imageEdgeInsets.top = 4
        return btn
    }()
    
    private lazy var badgeLabel:UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .red
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 8, weight: .medium)
        lbl.text =  "\(value)"
        lbl.layer.cornerRadius = 5
        lbl.clipsToBounds = true
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    override open func insertAndLayoutSubviews() {
        addSubview(button)
        addSubview(badgeLabel)
        
        NSLayoutConstraint.activate([button.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     button.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     button.topAnchor.constraint(equalTo: topAnchor),
                                     button.bottomAnchor.constraint(equalTo: bottomAnchor)])
        
        NSLayoutConstraint.activate([badgeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     badgeLabel.topAnchor.constraint(equalTo: topAnchor),
                                     badgeLabel.heightAnchor.constraint(equalToConstant: 10),
                                     badgeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 10)])
    }
    
    @objc private func userTappedButton(){
        delegate?.userTapped(self)
    }
    
    
}

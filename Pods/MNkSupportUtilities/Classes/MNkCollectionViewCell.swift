//
//  MNkCollectionViewCell.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 27/12/18.
//
import UIKit

open class MNkCVCell_Parameter<T>: MNkCollectionViewCell {
    
    public var data:T?{
        didSet{
            guard let _data = data else{return}
            updateUI(with:_data)
        }
    }
    
    open func updateUI(with data:T){}
    
}

//MARK:- BASED COLLECTIONVIEW CELL
open class MNkCollectionViewCell:UICollectionViewCell{
    open func createViews(){}
    open func insertAndLayoutSubviews(){}
    open func config(){}
    
    open func setAppSetting(){}
    
    private func doLoadThings(){
        backgroundColor = .white
        createViews()
        insertAndLayoutSubviews()
        config()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        doLoadThings()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doLoadThings()
    }
    
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        setAppSetting()
    }
}


//MARK:- EMPTY COLLECTIONVIEW CELL
public protocol EmptyCollectionViewDelegate{
    func userDidTappedReloadData(_ button:UIButton,in cell:MNkEmptyCVCell)
}

open class MNkEmptyCVCell:MNkCollectionViewCell{
    
    public var delegate:EmptyCollectionViewDelegate?
    
    public var message:String?{
        didSet{
            messageLabel.text = message
        }
    }
    
    public var heading:String?{
        didSet{
            headingLabel.text = heading
        }
    }
    
    public var placeHolderImage:UIImage?{
        didSet{
            imageview.image = placeHolderImage
        }
    }
    
    public var isHideButton:Bool = false{
        didSet{
            retryButton.isHidden = isHideButton
        }
    }
    
    public var imageview:UIImageView!
    public var headingLabel:UILabel!
    public var stackview:UIStackView!
    public var messageLabel:UILabel!
    public var retryButton:UIButton!
    
    override open func createViews() {
        imageview = UIImageView()
        imageview.tintColor = .lightGray
        imageview.contentMode = .scaleAspectFit
        
        headingLabel = UILabel()
        headingLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        headingLabel.textColor = .black
        headingLabel.textAlignment = .center
        
        stackview = UIStackView()
        stackview.alignment = .fill
        stackview.distribution = .fill
        stackview.spacing = 8
        stackview.axis = .vertical
        
        messageLabel = UILabel()
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.textColor = .lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.lineBreakMode = .byCharWrapping
        
        retryButton = UIButton()
        retryButton.addTarget(self, action: #selector(userDidtappedReloadButton(_:)), for: .touchUpInside)
        retryButton.setTitle("RETRY", for: .normal)
        retryButton.setTitleColor(.white, for: .normal)
        retryButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        retryButton.backgroundColor = .blue
        retryButton.layer.cornerRadius = 3
        retryButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override open func insertAndLayoutSubviews() {
        addSubview(stackview)
        stackview.addArrangedSubview(imageview)
        stackview.addArrangedSubview(headingLabel)
        stackview.addArrangedSubview(messageLabel)
        addSubview(retryButton)
        
        stackview.activateLayouts(to: self, [.centerY : 0,.centerX:0])
        NSLayoutConstraint.activate([stackview.widthAnchor.constraint(equalTo: self.widthAnchor,
                                                                      multiplier: 0.6),
                                     imageview.heightAnchor.constraint(equalTo: imageview.widthAnchor)])
        
        NSLayoutConstraint.activate([retryButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     retryButton.heightAnchor.constraint(equalToConstant: 36),
                                     retryButton.widthAnchor.constraint(equalTo: self.widthAnchor,
                                                                        multiplier: 0.4),
                                     retryButton.topAnchor.constraint(equalTo: stackview.bottomAnchor,
                                                                      constant: 20)])
    }
    
    override open func config() {
        clipsToBounds = true
    }
    
    @objc private func userDidtappedReloadButton(_ button:UIButton){
        delegate?.userDidTappedReloadData(button, in: self)
    }
}

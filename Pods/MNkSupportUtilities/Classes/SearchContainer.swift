//
//  SearchContainerView.swift
//  Moju
//
//  Created by MNk_Dev on 20/12/18.
//  Copyright © 2018 azbow. All rights reserved.
//

public protocol SearchDelegate{
    func didActivate(search view:SearchContainer.SearchView)
    func didDeActivate(search view:SearchContainer.SearchView)
    func didChange(search text:String,inSearch view:SearchContainer.SearchView)
    func userDidRetun(search text:String,from searchView:SearchContainer.SearchView)
}

public extension SearchDelegate{
    func didActivate(search view:SearchContainer.SearchView){}
    func didDeActivate(search view:SearchContainer.SearchView){}
    func didChange(search text:String,inSearch view:SearchContainer.SearchView){}
    func userDidRetun(search text:String,from searchView:SearchContainer.SearchView){}
}

//    ----------------------------
//    MARK:- Search Container view
//    ----------------------------
open class SearchContainer:MNkView{
    
    private var superWidth:CGFloat!
    private var leadingCons:CGFloat!
    private var traingCons:CGFloat!
    private var topCons:CGFloat!
    private var bottomCons:CGFloat!
    
    
    public var searchText:String?{
        didSet{
            searchView.searchTxtField.text = searchText
        }
    }
    
    public var placeHolderText:String?{
        didSet{
            searchView.searchTxtField.placeholder = placeHolderText
        }
    }
    
    public var delegate:SearchDelegate?{
        didSet{
            searchView.delegate = delegate
        }
    }
    
    private let searchView:SearchView = {
        let sv = SearchView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override open func insertAndLayoutSubviews() {
        addSubview(searchView)
        NSLayoutConstraint.activate([searchView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                                         constant: leadingCons),
                                     searchView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                                          constant: -leadingCons),
                                     searchView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                                        constant: -bottomCons),
                                     searchView.topAnchor.constraint(equalTo: topAnchor,
                                                                     constant: topCons)])
        
        guard superWidth != 0 else{return}
        searchView.widthAnchor.constraint(equalToConstant: superWidth - (leadingCons+8) - traingCons).isActive = true
    }
    
    public init(superWidth width:CGFloat = 0,searchView leading:CGFloat = 8,_ traling:CGFloat = 16,_ top:CGFloat = 6,_ bottom:CGFloat = 8) {
        self.leadingCons = leading
        self.traingCons = traling
        self.topCons = top
        self.bottomCons = bottom
        self.superWidth = width
        super.init(frame: .zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





//    ------------------
//    MARK:- Search view
//    ------------------
public extension SearchContainer{
    class SearchView:MNkView,
    UITextFieldDelegate{
        
        public var delegate:SearchDelegate?
        
        public  lazy var searchTxtField:UITextField = {
            let tf = UITextField()
            tf.addTarget(self, action: #selector(didChangeSearchText), for: .editingChanged)
            tf.delegate = self
            tf.textColor = .black
            tf.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
            tf.placeholder = "Search"
            return tf
        }()
        
        private let magnitoIcoIv:UIImageView = {
            let iv = UIImageView()
            let magnitoImg = #imageLiteral(resourceName: "tabbar_search").withRenderingMode(.alwaysTemplate)
            iv.image = magnitoImg
            iv.contentMode = .scaleAspectFit
            iv.tintColor = .black
            iv.translatesAutoresizingMaskIntoConstraints = false
            return iv
        }()
        
        private lazy var clearButton:UIButton = {
            let btn = UIButton()
            btn.addTarget(self, action: #selector(searchCancelled), for: .touchUpInside)
            btn.setImage(#imageLiteral(resourceName: "close_btn"), for: .normal)
            btn.imageView?.contentMode = .scaleAspectFit
            btn.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
        }()
        
        private let stackview:UIStackView = {
            let sv = UIStackView()
            sv.distribution = .fill
            sv.alignment = .fill
            sv.axis = .horizontal
            sv.spacing = 12
            sv.translatesAutoresizingMaskIntoConstraints = false
            return sv
        }()
        
        override open func insertAndLayoutSubviews() {
            addSubview(stackview)
            stackview.addArrangedSubview(magnitoIcoIv)
            stackview.addArrangedSubview(searchTxtField)
            stackview.addArrangedSubview(clearButton)
            
            NSLayoutConstraint.activate([stackview.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                                            constant: 8),
                                         stackview.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                                             constant: -8),
                                         stackview.topAnchor.constraint(equalTo: topAnchor,
                                                                        constant: 6),
                                         stackview.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                                           constant: -6)])
            
            NSLayoutConstraint.activate([magnitoIcoIv.widthAnchor.constraint(equalTo: stackview.heightAnchor, multiplier: 1),
                                         clearButton.widthAnchor.constraint(equalTo: stackview.heightAnchor, multiplier: 1)])
        }
        
        override open func config() {
            backgroundColor = .lightGray
            clipsToBounds = true
            layer.cornerRadius = 6
        }
        
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            delegate?.didActivate(search: self)
        }
        
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.endEditing(true)
            guard let _text = textField.text ,
                !_text.isEmpty
                else{return true}
            delegate?.userDidRetun(search: _text.trimmingCharacters(in: .whitespacesAndNewlines), from: self)
            return true
        }
        
        @objc private func searchCancelled(){
            self.endEditing(true)
            searchTxtField.text = ""
            delegate?.didDeActivate(search: self)
        }
        
        @objc private func didChangeSearchText(){
            guard let _text = searchTxtField.text else{return}
            delegate?.didChange(search:_text , inSearch: self)
        }
        
    }
}

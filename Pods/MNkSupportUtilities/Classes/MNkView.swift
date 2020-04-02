//
//  MNkView.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 15/11/18.
//
import UIKit
open class MNkView:UIView{
    open func createViews(){}
    open func insertAndLayoutSubviews(){}
    open func config(){}
    open func updateUIWithNewData(){}
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
    
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        setAppSetting()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doLoadThings()
    }
}



open class MNkView_Parameter<T>:MNkView{
    public var data:T!{didSet{updateUIWithNewData()}}
}





open class MNkView_TV_Parameter_CellType<T,C:MNkTVCell_Parameter<T>>:MNkView,UITableViewDataSource,UITableViewDelegate{
    
    public var tableView:UITableView!
    
    public var cellID:String = "GenericCellID \(arc4random())"
    public var data:[T] = []{didSet{updateUIWithNewData()}}
    
    open override func createViews() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(C.self, forCellReuseIdentifier: cellID)
    }
    
    open override func config() {
        tableView.tableFooterView = UIView()
    }
    
    open override func insertAndLayoutSubviews() {
        addSubview(tableView)
        tableView.activateLayouts(to: self)
    }
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! C
        cell.data = data[indexPath.item]
        return cell
    }
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {return UITableView.automaticDimension}
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    open func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {}
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {return nil}
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {return nil}
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {return 0}
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {return nil}
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {return 0}
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {}
}


open class MNkTViewParameterWithEmptyCellType<T,C:MNkTVCell_Parameter<T>,E:MNkEmptyTVCell>:MNkView_TV_Parameter_CellType<T,C>{
    private var emptyCellID:String{
        return "Empty_Cell_ID"
    }
    
    open override func createViews() {
        super.createViews()
        tableView.register(E.self, forCellReuseIdentifier:emptyCellID)
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.isEmpty ? 1 : data.count
    }
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !data.isEmpty else{
            let emptyCell = tableView.dequeueReusableCell(withIdentifier: emptyCellID, for: indexPath) as! E
            emptyCell.delegate = self
            return tableview(setEmptyCellData: emptyCell, at: indexPath)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! C
        cell.data = data[indexPath.item]
        return cell
    }
    
    open override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard data.isEmpty else{
            return UITableView.automaticDimension
        }
        return tableView.bounds.size.height
    }
    
    open func tableview(setEmptyCellData emptyCell:E,at indexPath:IndexPath)->E{return emptyCell}
}

extension MNkTViewParameterWithEmptyCellType:EmptyTableviewDelegate{
    public func userDidTappedReloadData(_ button: UIButton, in cell: MNkEmptyTVCell) {}
}

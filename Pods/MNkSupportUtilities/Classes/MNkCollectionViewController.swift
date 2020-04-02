//
//  MNkBaseCollectionVC.swift
//  FBSnapshotTestCase
//
//  Created by MNk_Dev on 2/11/18.
//

import UIKit
/*...................................................................
 MARK:- MNkCollectionv view controllers with normal cell type reload
 ...................................................................*/
open class MNKCollectionViewController:MNkViewController,
    UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource{
    
    open var layout:UICollectionViewLayout = UICollectionViewFlowLayout()
    
    public var cellID:String = "GenericCellID \(arc4random())"
    public var emptyCellID:String = "EmptyCellID \(arc4random())"
    
    public var cellDisplayViewBounds:CGRect{
        let topPadding = (navigationController?.navigationBar.frame.size.height ?? 0) + safeAreaEdgeInsets.top
        let bottomPadding = (tabBarController?.tabBar.frame.size.height ?? 0) + safeAreaEdgeInsets.bottom
        let mainSreenRect = UIScreen.main.bounds
        return CGRect.init(origin: .zero,
                           size: CGSize.init(width: mainSreenRect.width,
                                             height: mainSreenRect.height - topPadding - bottomPadding))
    }
    
    public var collectionView:UICollectionView!
    
    open override func createViews() {
        collectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
    }
    
    open override func insertAndLayoutSubviews() {
        view.addSubview(collectionView)
        collectionView.activateLayouts(to: self.view)
    }
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {return 1}
    
    open  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {return 0}
    open  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {return UICollectionViewCell()}
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {return .zero}
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {return UICollectionReusableView()}
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {return .zero}
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {return .zero}
    open func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {}
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {return .zero}
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {}
    open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {}
    open func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {}
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {}
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {}
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {}
    open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {}
    open func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {}
    open func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {}
}

//MARK:- COLLECTIONVIEW CONTROLLER WITH CELL TYPE AND AND PARAMETER
open class MNkCollectionVC_Parameter_CellType<T,C:MNkCVCell_Parameter<T>>: MNkCollectionVC_Parameter<T>{
    
    open override func config() {
        collectionView.register(C.self, forCellWithReuseIdentifier: cellID)
    }
    
    open  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! C
        cell.data = data[indexPath.item]
        return cell
    }
}

//MARK:- COLLRCTIONVIEW CONTROLLER WITH PARAMETER
open class MNkCollectionVC_Parameter<T>:MNKCollectionViewController{
    public var data:[T] = []{didSet{updateUIWithNewData()}}
    
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {return data.count}
}

/*...........................................................
 MARK:- MNkTableView controllers with empty cell type reload
 ............................................................*/
open class MNkCVC_Parameter_Cell_EmptyCellType<T,C:MNkCVCell_Parameter<T>,E:MNkEmptyCVCell>:MNkCVC_Parameter_EmptyCellType<T,E>{
    
    open override func config() {
        super.config()
        collectionView.register(C.self, forCellWithReuseIdentifier: cellID)
    }
    
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard data.isEmpty else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! C
            cell.data = data[indexPath.item]
            return self.collectionView(collectionView,updateCellDataWhenReloadingAt: indexPath, of: cell)
        }
        return super.collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    open func collectionView(_ collectionView:UICollectionView,updateCellDataWhenReloadingAt indexPath:IndexPath,of cell:C)->C{return cell}
}

open class MNkCVC_Parameter_EmptyCellType<T,E:MNkEmptyCVCell>:MNkCVC_EmptyCellType<E>{
    public var data:[T] = [] {didSet{updateUIWithNewData()}}
    
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard data.isEmpty else {return data.count}
        return super.collectionView(collectionView, numberOfItemsInSection: section)
    }
}


open class MNkCVC_EmptyCellType<E:MNkEmptyCVCell>:MNKCollectionViewController{
    open override func config() {
        super.config()
        collectionView.register(E.self, forCellWithReuseIdentifier: emptyCellID)
    }
    
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: emptyCellID, for: indexPath) as! E
        emptyCell.delegate = self
        return self.collectionView(setEmptyCellData: emptyCell, at: indexPath)
    }
    
    open override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellDisplayViewBounds.size
    }
    
    open func collectionView(setEmptyCellData emptyCell:E,at indexPath:IndexPath)->E{return emptyCell}
    
    open func userDidTappedReloadData(_ button: UIButton, in cell: MNkEmptyCVCell) {}
}


extension MNkCVC_EmptyCellType:EmptyCollectionViewDelegate{}

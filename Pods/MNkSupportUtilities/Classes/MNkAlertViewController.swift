//
//  MNkAlertViewController.swift
//  CelebrateSriLanka
//
//  Created by Malith Nadeeshan on 2018-04-03.
//  Copyright © 2018 Azbow. All rights reserved.
//

open class MNkAlertViewController:MNkViewController{
    private var alertView = MNkAlertView()
    
    public func set(alertView:MNkAlertView){
        self.alertView = alertView
    }
    
    override open func config() {
        view.backgroundColor = .clear
        alertView.delegate = self
    }
    
    public func showAlert(in target:UIViewController,_ complete:((MNkAlertView.MNkAlertAction)->Void)? = nil){
        target.present(self, animated: false) {
            self.alertView.show(in: self.view) { actionType in
                guard let _complete = complete else{
                    self.dismiss(animated: false, completion: nil)
                    return
                }
                _complete(actionType)
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
}

extension MNkAlertViewController:MNkAlertDelegate{
    public func userPerformAlertAction(_ action: MNkAlertView.MNkAlertAction) {
        self.dismiss(animated: false, completion: nil)
    }
}



public extension UIViewController{
    func showAlert(of alertVC:MNkAlertViewController,completed:((_ completedAction:MNkAlertView.MNkAlertAction)->())? = nil){
        alertVC.modalTransitionStyle = .crossDissolve
        alertVC.modalPresentationStyle = .overCurrentContext
        
        alertVC.showAlert(in: self, completed)
    }
}









//
//  MainView.swift
//  VIPPER
//
//  Created by Manh Pham on 3/5/21.
//

import Foundation

protocol MainViewInterface: AnyObject {
    var presenter: MainPresenterInterface! { get set }
    func showAlert(title: String, message: String)
    func didLoadData()
    func showLoading()
    func hideLoading()
}

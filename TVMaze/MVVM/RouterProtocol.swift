//
//  RouterProtocol.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 20/08/21.
//

import Foundation
import UIKit

typealias AcceptAction = () -> Void

enum AlertAction {
    case cancel
    case accept(action: AcceptAction?)
}

protocol RouterProtocol {
    var viewController: UIViewController? { get }
    init(viewController: UIViewController)
    func routeBack()
}

extension RouterProtocol {
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func pop() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func push(viewController: UIViewController, isAlphaTransition: Bool = false) {
        guard isAlphaTransition else {
            self.viewController?.navigationController?.delegate = nil
            self.viewController?.navigationController?.pushViewController(viewController, animated: true)
            return
        }
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showAlert(title: String, message: String, actions: [AlertAction] = []) {
        var alertActions: [UIAlertAction] = []
        for action in actions {
            switch action {
            case .accept(let action):
                let accept = UIAlertAction(title: "Aceptar", style: .default) { _ in
                    action?()
                }
                alertActions.append(accept)
            case .cancel:
                let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
                alertActions.append(cancel)
            }
        }
        viewController?.showAlert(title: title, message: message, actions: alertActions)
    }
    
    public func showAlert(with error: Error, acceptAction: @escaping AcceptAction) {
        showAlert(title: "Error", message: error.localizedDescription, actions: [.accept(action: acceptAction), .cancel])
    }
    
    func showDefaultAlertError(acceptAction: @escaping AcceptAction) {
        showAlert(title: "Oops, algo salió mal!",
                  message: "Hubo un problema al guardar/borrar este show de TV. ¿Quieres intentar nuevamente?",
                  actions: [.accept(action: acceptAction), .cancel])
    }
}

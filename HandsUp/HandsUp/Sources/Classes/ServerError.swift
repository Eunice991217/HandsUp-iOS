//
//  ServerError.swift
//  HandsUp
//
//  Created by 황재상 on 2023/01/31.
//

import Foundation
import UIKit

extension UIViewController {
    func ServerError() {
        let serverSB = UIStoryboard(name: "ServerError", bundle: nil)
        let serverErrorVC = serverSB.instantiateViewController(withIdentifier: "ServerError")
        self.navigationController?.pushViewController(serverErrorVC, animated: false)
    }
}

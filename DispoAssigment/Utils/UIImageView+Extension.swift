//
//  UIImageView+Extension.swift
//  DispoAssigment
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 1/17/22.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        self.image = UIImage(systemName: "photo")
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

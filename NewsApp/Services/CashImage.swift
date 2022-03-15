//
//  CashImage.swift
//  NewsApp
//
//  Created by Юрий Девятаев on 15.03.2022.
//

import Foundation
import UIKit

protocol CashImage {
    
////    var imageDict: [String: UIImage] {get}
//
//    func receiveData(category: String, success: @escaping ([News]) -> Void, error: @escaping (Error?) -> Void)
//    func loadImage(url: String?, success: @escaping (UIImage?) -> Void, error: @escaping (Error?) -> Void)
}

class CashImageImp: CashImage {
    
    let imageCache = NSCache<NSString, UIImage>()
    
    
}

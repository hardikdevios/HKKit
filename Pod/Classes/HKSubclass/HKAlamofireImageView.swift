//
//  HKAlamofireImageView.swift
//  Genemedics
//
//  Created by Plenar on 29/09/16.
//  Copyright © 2016 Plenar. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
open class HKAlamofireImageView: UIImageView {
    
    private var recipt:RequestReceipt?
    static var downloader = ImageDownloader(
                configuration: ImageDownloader.defaultURLSessionConfiguration(),
                downloadPrioritization: .lifo,
                maximumActiveDownloads: 4,
                imageCache: AutoPurgingImageCache()
            )
    
    public func cancelRequest(){
        guard let request = recipt else {
            return
        }
        HKAlamofireImageView.downloader.cancelRequest(with: request)
        
    }
    
    public func downloadImage(url:URL,placeHolder:UIImage) {
        self.image = placeHolder
        
        
        self.recipt = HKAlamofireImageView.downloader.download(URLRequest(url:url), completion: { (response) in
            
            
            
            if let image = response.result.value {
                self.image = image.af_imageAspectScaled(toFit: self.frame.size)
            }

          
            
            
            
            
        })
        
    }
    
    
    
    
    
}

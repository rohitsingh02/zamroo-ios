//
//  AFURLSource.swift
//  ImageSlideshow
//
//  Created by Petr Zvoníček on 30.07.15.
//

import AFNetworking
import ImageSlideshow

public class AFURLSource: NSObject, InputSource {
    var url: NSURL!
    var placeholder: UIImage?
    
    public init(url: NSURL) {
        self.url = url
        super.init()
    }
    
    public init(url: NSURL, placeholder: UIImage) {
        self.url = url
        self.placeholder = placeholder
        super.init()
    }
    
    public init?(urlString: String) {
        if let validUrl = NSURL(string: urlString) {
            self.url = validUrl
            super.init()
        } else {
            super.init()
            return nil
        }
    }
    
    @objc public func setToImageView(_ imageView: UIImageView) {
//        imageView.setImageWithURLRequest(NSURLRequest(URL: url), placeholderImage: self.placeholder, success: { (request: NSURLRequest, response: NSHTTPURLResponse?, image: UIImage) -> Void in
//            imageView.image = image
//            }, failure: nil)
        
        imageView.kf_setImage(with: url as URL, placeholder: UIImage(named: "chache_image"), options: [.transition(.fade(1))], progressBlock: { (receivedSize, totalSize) -> () in
            print("Download Progress: \(receivedSize)/\(totalSize)")}, completionHandler: { (image, error, cacheType, imageURL) -> () in
                print("Downloaded and set!")
        })
        
        
        
    }

}

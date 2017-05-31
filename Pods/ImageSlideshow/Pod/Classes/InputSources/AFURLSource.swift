//
//  AFURLSource.swift
//  ImageSlideshow
//
//  Created by Petr Zvoníček on 30.07.15.
//

import AFNetworking

open class AFURLSource: NSObject, InputSource {
    var url: URL!
    var placeholder: UIImage?
    
    public init(url: URL) {
        self.url = url
        super.init()
    }
    
    public init(url: URL, placeholder: UIImage) {
        self.url = url
        self.placeholder = placeholder
        super.init()
    }
    
    public init?(urlString: String) {
        if let validUrl = URL(string: urlString) {
            self.url = validUrl
            super.init()
        } else {
            super.init()
            return nil
        }
    }
    
    @objc open func setToImageView(_ imageView: UIImageView) {
        imageView.setImageWith(URLRequest(url: url), placeholderImage: self.placeholder, success: { (request: URLRequest, response: HTTPURLResponse?, image: UIImage) -> Void in
            imageView.image = image
            }, failure: nil)
    }

}

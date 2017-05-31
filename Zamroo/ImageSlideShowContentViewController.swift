//
//  ImageSlideShowContentViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 03/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import ImageSlideshow

protocol ImageNotAvailableDelegate:class {
    
    func ifImageNotAvailable()
   

}

class ImageSlideShowContentViewController: UIViewController {
    var imagesArrayJSON:JSON  = []
    var productJSON:JSON = []
    var productCategory = ""
    
    @IBOutlet var slideshow: ImageSlideshow!
    
    weak var delegate:ImageNotAvailableDelegate?
    
    var slideshowTransitioningDelegate: ZoomAnimatedTransitioningDelegate?
    
    var alamofireSource : [AFURLSource] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProductAttributesImagesUsingProductId(productJSON["product_id"].intValue)
        slideshow.backgroundColor = UIColor.white
        slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.underScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray;
        slideshow.pageControl.pageIndicatorTintColor = UIColor.black;
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        // try out other sources such as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource`
       // slideshow.setImageInputs(alamofireSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(ImageSlideShowContentViewController.click))
        slideshow.addGestureRecognizer(recognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func click() {
        let ctr = FullScreenSlideshowViewController()
        ctr.pageSelected = {(page: Int) in
            self.slideshow.setScrollViewPage(page, animated: false)
        }
        
        ctr.initialImageIndex = slideshow.scrollViewPage
        ctr.inputs = slideshow.images
        slideshowTransitioningDelegate = ZoomAnimatedTransitioningDelegate(slideshowView: slideshow, slideshowController: ctr)
        // Uncomment if you want disable the slide-to-dismiss feature on full screen preview
        // self.transitionDelegate?.slideToDismissEnabled = false
        ctr.transitioningDelegate = slideshowTransitioningDelegate
        self.present(ctr, animated: true, completion: nil)
    }
    
    func getProductAttributesImagesUsingProductId(_ id:Int){
        AppService.fetchDataFromUrl(AppService.productAttributeImageUrl + "\(id)"){
            (JSON) -> () in
            
            if JSON["images"].stringValue != "false" {
            
                self.imagesArrayJSON = JSON["images"]
                print(JSON["images"])
                
                
                for i in 0 ..< self.imagesArrayJSON.count{
                    let URL = AppService.getImageUrl(StringHelper.convertStringForImageUrl(self.productCategory), subCategory: StringHelper.convertStringForImageUrl(self.productJSON["sub_cat_name"].stringValue), size: "medium", imageCode: self.imagesArrayJSON[i]["image"].stringValue)
                    
                    self.alamofireSource.append(AFURLSource(urlString: URL)!)
                }
                self.slideshow.setImageInputs(self.alamofireSource)
                
            }else{
            //
                self.delegate?.ifImageNotAvailable()
            }
        }
    }
  

}

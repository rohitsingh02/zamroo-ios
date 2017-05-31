//
//  HouseAndApartmentsForSaleTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class HouseAndApartmentsForSaleTableViewCell: UITableViewCell {

    @IBOutlet var houseANdApartmentForSaleXibHeight: NSLayoutConstraint!
    
  
    @IBOutlet var securityDepositTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var priceAttributeLabel: UILabel!

    
    
    @IBOutlet var expYearLabel: UILabel!
    @IBOutlet var expYearValueLabel: UILabel!
    @IBOutlet var expYearHeaderLabel: UILabel!
    
    @IBOutlet var expmonthLabel: UILabel!
    @IBOutlet var expMonthValueLabel: UILabel!
    @IBOutlet var expmonthHeaderLabel: UILabel!
    
    @IBOutlet var flatAmentiesLabel: UILabel!
    @IBOutlet var flatAmentiesValueLabel: UILabel!
    @IBOutlet var flatAmentiesHeaderLabel: UILabel!
    
    @IBOutlet var societyAmentiesLabel: UILabel!
    @IBOutlet var societyAmentiesValueLabel: UILabel!
    @IBOutlet var societyAmentiesHeaderLabel: UILabel!
    
    @IBOutlet var selectPropertyTypeLabel: UILabel!
    @IBOutlet var propertyTypeValueLabel: UILabel!
    @IBOutlet var propertyTypeHeaderLabel: UILabel!
    
    
    weak var delegate:MobileViewDelegate?
    
    @IBOutlet var individualButton: DesignableButton!


    
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    @IBAction func sellerTypeButtonTapped(_ sender: DesignableButton) {
        
        delegate?.sellerTypeSelectedButton(cell: self, sender: sender)
    }
    
    @IBAction func numberOfRoomsTapped(_ sender: AnyObject) {
        
          delegate?.operatingSystemTypeSelectedButton(cell: self, sender: sender)
        
    }
    
    
    @IBAction func areaSquareFtTapped(_ sender: AnyObject) {
        
        delegate?.simSlotsTypeSelectedButton(cell: self, sender: sender)
        
    }
    
    @IBAction func furnishedTapped(_ sender: AnyObject) {
        
          delegate?.sizeTypeSelectedButton(cell: self, sender: sender)
        
    }
    
    @IBAction func noOfBalconiesTapped(_ sender: AnyObject) {
         delegate?.cameraTypeSelectedButton(cell: self, sender: sender)
        
    }
    
    
    @IBAction func carParkingTapped(_ sender: AnyObject) {
           delegate?.ramTypeSelected(cell: self, sender: sender)
        
    }
    
    
    
    @IBAction func floorNumberTapped(_ sender: AnyObject) {
      delegate?.selectFloorNumber(cell:self,sender: sender,floorArray : AppService.floorNumbersArray,isTotalFloor : false)
    }
    
    
    @IBAction func totalfloorsTapped(_ sender: AnyObject) {
        delegate?.selectFloorNumber(cell:self,sender: sender,floorArray : AppService.totalFloorsArray,isTotalFloor : true)
        
    }
    
    @IBAction func bathroomTapped(_ sender: AnyObject) {
        
        delegate?.megaPixelTypeSelectedButton(cell: self, sender: sender)
    }
    
    @IBAction func propertyOwnershipTapped(_ sender: AnyObject) {
        
        delegate?.productTypeSelectedButton(cell:self,sender: sender)
        
    }
    
 
    @IBAction func propertyTypeTapped(_ sender: AnyObject) {
        
        
        delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.housesApartmentForRentPropertyTypeArray,isSelectBrand: false )
        
    }
    
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
    @IBAction func flatAmenitiesTapped(_ sender: AnyObject) {
        delegate?.featuresMultipleSelection(cell: self, sender: sender,multipleSelectionArray : AppService.flatAmenitiesSaleArray,isMultipleSelection :true)
        
    }
    @IBAction func societyAmenitiesTapped(_ sender: AnyObject) {
        delegate?.featuresMultipleSelection(cell: self, sender: sender,multipleSelectionArray : AppService.societyAmenitiesArray,isMultipleSelection :false)
        
    }
}

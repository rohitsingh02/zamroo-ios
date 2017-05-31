//
//  AppService.swift
//  Zamroo
//
//  Created by Rohit Singh on 27/08/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import Alamofire


struct AppService {
    fileprivate static let baseUrl = "http://india.coderatech.com/api/"
    static let ZamrooClientId = "161042301455-cgj3cgoipq98ngt702c4juj6cechr5qp.apps.googleusercontent.com"
    
    
    fileprivate enum ResourcePath: CustomStringConvertible {
        
        case latestProducts
        case featureProducts
        case category
        case state
        case city
        case topCity
        case adList
        case product
        case productAttributes
        case productAttributeImages
        case imageUrl
        case autoSearchUrl
        case signUp
        case login
        case facebook
        case google
        case forgetPassword
        case createPassword
        case verifyEmail
        case viewAllAds
        //postAdApi's
        case postAd
        
        var description: String {
            switch self {
            case .latestProducts: return "get-latest-product"
            case .featureProducts: return "get-feature-product"
            case .category: return "get-category"
            case .state: return "get-state"
            case .city: return "get-city/"
            case .topCity: return "get-top-city"
            case .adList: return "get-listing/"
            case .product: return "get-product/"
            case .productAttributes: return "get-product-att/"
            case .productAttributeImages: return "get-images/"
            case .imageUrl: return "http://india.coderatech.com/images/product-images/"
            case .autoSearchUrl: return "get-auto-search/"
            case .signUp: return "signup"
            case .login : return "login"
            case .facebook: return "login-fb"
            case .google: return "login-go"
            case .forgetPassword: return "forgot-password"
            case .createPassword: return "create-pass"
            case .verifyEmail: return "verifyuser"
            case .viewAllAds: return "get-cat-listing/"
            //postAdApi's
            case .postAd:  return "post-free-ad"
                
                
            }
        }
    }
    
    static let latestProductUrl = baseUrl + ResourcePath.latestProducts.description
    static let featureProductUrl = baseUrl + ResourcePath.featureProducts.description
    static let categoryUrl = baseUrl + ResourcePath.category.description
    static let statesUrl = baseUrl + ResourcePath.state.description
    static let cityUrl = baseUrl + ResourcePath.city.description
    static let topCitiesUrl = baseUrl + ResourcePath.topCity.description
    static let adUrl = baseUrl + ResourcePath.adList.description
    static let productUrl = baseUrl + ResourcePath.product.description
    static let productAttributesUrl = baseUrl + ResourcePath.productAttributes.description
    static let productAttributeImageUrl = baseUrl + ResourcePath.productAttributeImages.description
    static let imageUrl = ResourcePath.imageUrl.description
    static let autoSearchUrl = baseUrl + ResourcePath.autoSearchUrl.description
    static let signUpUrl = baseUrl + ResourcePath.signUp.description
    static let signInUrl = baseUrl + ResourcePath.login.description
    static let forgotPasswordUrl = baseUrl + ResourcePath.forgetPassword.description
    static let viewAllAdsUrl = baseUrl + ResourcePath.viewAllAds.description
    static let postFreeAdsUrl = baseUrl + ResourcePath.postAd.description
    
    static func fetchDataFromUrl(_ urlString:String,responseJSON:@escaping (JSON) -> ()) {
    
        Alamofire.request(urlString)
            .responseJSON { response in
                
                if let json:JSON
                    = JSON(response.result.value ?? []) {
                    responseJSON(json)
                }
        }
    }
    
  
    static func fetchCategoryList() -> JSON{
        var category: JSON?
        if let path = Bundle.main.path(forResource: "Category", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                let json = JSON(data: data, options: JSONSerialization.ReadingOptions.allowFragments, error: nil)
                    category = json["category"]
                }
            }
        return category!
        }
    
    static func fetchCategoryList2() -> JSON{
        var category: JSON?
        if let path = Bundle.main.path(forResource: "Category2", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                let json = JSON(data: data, options: JSONSerialization.ReadingOptions.allowFragments, error: nil)
                category = json["category"]
            }
        }
        return category!
    }
    
    static func fetchTopCity() -> JSON{
        var topCity: JSON?
        if let path = Bundle.main.path(forResource: "TopCity", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                let json = JSON(data: data, options: JSONSerialization.ReadingOptions.allowFragments, error: nil)
                topCity = json["top_city"]
                print(topCity)
            }
        }
        return topCity!
    }
    
    static func fetchStates() -> JSON{
        var states: JSON?
        if let path = Bundle.main.path(forResource: "States", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                let json = JSON(data: data, options: JSONSerialization.ReadingOptions.allowFragments, error: nil)
                states = json["State"]
            }
        }
        return states!
    }
    

    static func getPageMenuTitleArray() -> [String]{
    
        let pageMenuTitleArray = ["Mobiles & Tablets","Electronics & Computers","Real Estate","Home & Garden","Cars & Other Vehicles" ]
        
        return pageMenuTitleArray
    
    }
    
    static func getImageUrl(_ category:String,subCategory:String,size:String,imageCode:String) -> String{
        
        let imageUrl = AppService.imageUrl + category + "/" + subCategory + "/" + size + "/" + imageCode
        
        return imageUrl
        
    }
    
    
    static func sendDataToUrl(_ urlString:String,email:String,password:String,confirmPassword:String,responseJSON:@escaping (JSON) -> ()) {
        
        // build parameters
        let parameters = ["email": email, "password": password,"password2":confirmPassword]
        
        // build request
        Alamofire.request(urlString ,method:.post, parameters: parameters, encoding: JSONEncoding.default,headers: nil).responseJSON { response in
            
            switch response.result {
            case .success:
                if let json:JSON = JSON(response.result.value ?? []){
                  
                    responseJSON(json)
                }
                break
         case .failure(let error):
                print(error)
                break
                
            }
        }
        
    }
    
    static func attemptLogin(_ urlString:String,email:String,password:String,responseJSON:@escaping (JSON) -> ()) {
        
        print(urlString)
        // build parameters
        let parameters = ["email": email, "password": password]
        
        // build request
        Alamofire.request(urlString ,method:.post, parameters: parameters, encoding: URLEncoding.default,headers: nil).responseJSON { response in
            
             print("\(response.result)")
            switch response.result {
           
            case .success:
                if let json:JSON = JSON(response.result.value ?? []){
                  
                    responseJSON(json)
                }
                break
                
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
   
    
    static func attemptPasswordReset(_ urlString:String,email:String,responseJSON:@escaping (JSON) -> ()) {
        
        // build parameters
        let parameters = ["email": email]
        
        // build request
        Alamofire.request(urlString ,method:.post, parameters: parameters, encoding: JSONEncoding.default,headers: nil).responseJSON { response in
            
            switch response.result {
            case .success:
                if let json:JSON = JSON(response.result.value ?? []){
                  
                    responseJSON(json)
                }
                break
                
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
    
    static func postAdDataToUrl(_ urlString:String,parameters:[String:AnyObject],responseJSON:@escaping (String) -> ()) {
        
        // build parameters
    
        
        // build request
        Alamofire.request(urlString ,method:.post, parameters: parameters,headers: nil).responseString { response in
            
            
            switch response.result {
            case .success:
                print(response.result.value!)
                break
            case .failure(let error):
                print(error)
                break
                
            }
        }
        
    }
    
    
    static var mobileBrandArray = ["Acer","Alcatel","Apple iPhone","Blackberry","Dell","Gfive","Gionee","HTC","Huawei","iBall","Intex","Karbonn","Lava","Lemon","Lenovo","LG","Micromax","Motorola","Nokia","Samsung","Sony","Spice","Videocon","Xiaomi","Xolo","Other Mobiles"]
    static var tabletBrandArray = ["Acer","Alcatel","Apple iPhone","Blackberry","Dell","Gfive","Gionee","HTC","Huawei","iBall"]
    static var laptopBrandArray = ["Acer","Apple","Asus","Benq","Compaq","Dell","HCL","Hitachi","HP","IBM","Lenovo","LG","Samsung","Sony","Toshiba","Wipro","Others"]

    static var computerPeripheralsProductTypeArray = ["Battery","Blank Media","CPU","Data Card","Ethernet Cable","External DVD Writer","External Harddisk","Graphics Card","Headphones","Headset","Keyboard","Monitor","Mouse","Network Card","Pen Drive","Print Ink/Toner","Printer","RAM","Router","Scanner","Switch","Webcam","Wireless USB Adapter","Motherboard","Other Peripherals"]
    static var tvBrandArray = ["Akai","AOC","Benq","BPL","Fujitsu","Haier","Hitachi","Home Tech","Hyundai","Intex","JVC","LG","Magnavox","Mitsubisi","Moser Baer","Onida","Panasonic","Philips","Pioneer","Samsung","Sansui","Sanyo","Sharp","Sony","TCL","Toshiba","Videocon","Weston"]
    static var tvProductTypeArray = ["3D LED TV","CRT TV","HD TV","LCD TV","LED TV","Plasma TV","Portable TV","Smart TV","TV Accessories"]
    static var audioVideoProductTypeArray = ["Cables & Accessories","DJ & Karaoke","FM Radio","Headphones & Earphones","Hi-Fi System","Home Theatre","iPods & Accessories","MP3 & Media Players","Portable Audio Players","Stereos","Stereos Components","Video Players","Video Recorders"]
    static var cameraMakeArray = ["Canon","Casio","Fujifilm","Kodak","Nikon","Olympus","Panasonic","Pentax","Polaroid","Samsung","Sony","Others"]
    static var cameraProductTypeArray = ["Digital Camera","Point & Shoot","Video Camera","Camcorder","SLR","Binoculars & Optics","Other Camera's"]
    
    static var cameraAccessoriesProductTypeArray = ["Camera Bags","Camera Battery","Camera Battery Charger","Camera Flashes","Camera Remote Control","Film Camera","Lense Cap","Lense Cleaner","Lenses","Memory Cards","Tripods","Other Accessories"]
    
     static var gamingAndConsoleProductTypeArray = ["Adapters","Camera Battery","Camera Battery Charger","Camera Flashes","Camera Remote Control","Film Camera","Lense Cap","Lense Cleaner","Lenses","Memory Cards","Tripods","Other Accessories"]
    
    static var housesApartmentForRentPropertyTypeArray = ["Apartment","Independent House/Vila","Builder Floor","Farm House","Pent House"]
    
    static var floorNumbersArray = ["Basement","Lower Ground","Ground","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25"]
    
    static var totalFloorsArray = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25"]
    
    static var commercialPropertyForRentPropertyTypeArray = ["ATM Kiosk","Banquet Halls","Business Centre","Commercial Land","Commercial Shop","Conference - Party Halls","Industrial Building","Industrial Land","Industrial Shed","Office Space","Space in Shopping Mall","Studios for Photos / Films / Serials","Swimming Pool","Warehouse - Godown","Wedding Venues","Other Location For Hire"]
    
    static var otherJobsTypeOfJobsArray = ["Full Time Job","Part Time Job","Freelancer","Contract","Internship","Volunteer"]
    
    static var motorcycleYearArray = ["1965","1966","1967","1968","1969","1970","1971","1972","1973","1974","1975","1976","1977","1978","1979","1980","1981","1982","1983","1984","1985","1986","1987","1988","1989","1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016"]
    
    static var scooterMakeArray = ["Bajaj","BMW","Hero","Hero Honda","Honda","LML","Mahindra","Suzuki","TVS","Yamaha","Others"]
    
    static var carMakeArray = ["Aston Martin","Audi","Bentley","BMW","Bugatti","Chevrolet","Daewoo","Datsun","Fiat","Ford","Hindustan Motors","Honda","Hyundai","Jaguar","Lamborghini","Mahindra","Mahndra Renault","Maruti Suzuki","Maserati","Mercedes Benz","Mitsubishi","Nissan","Opel","Others","Renault","Rolls Royce","Skoda","Tata","Toyota","Volkswagen","Volvo"]
    
    static var motorcycleMakeArray = ["Bajaj","BMW","Hero","Hero Honda","Honda","Imported Bikes","Kinetic Motors","LML","Royal Enfield","Suzuki","TVS","Yamaha","Others"]
    
    static var tractorMakeArray = ["Arjun","Escorts","Force Motors","Ford","HMT","Indofarm","Mahindra","New Holland","Sonalika","Swaraj"]
    
    static var suvMakeArray = ["Ashok Leyland","Audi","BMW","Cadillac","Chevrolet","Fiat","Force","Ford","Honda","Hummer","Hyundai","Jeep","Land Rover","Lexus","Mahindra","Mahindra Ssangyong","Maruti","Mercedes Benz","Mitsubishi","Nissan","Others","Porsche","Premier","Renault","Skoda","Tata","Toyota","Volkswagen","Volvo"]
    static var commercialTransportationTypeArray = ["Bus","Other Commercial Vehicles","Pickup","Tempo","Trailer","Truck"]
    
    static var acBrandArray = ["Bluestar","Carrier","Diakin","Electrolux","Godrej","Haier","Hitachi","Intec","LG","Lloyd","Mitsubishi","Napoleon","O General","Panasonic","Samsung","Sharp","Toshiba","Veestar","Videocon","Voltas","Whirlpool"]
    
    static var acSelectTypeArray = ["Split AC","Windows AC","Cassette AC","Ducted AC","Floor Standing AC"]
    
    static var refrigeratorBrandArray = ["Electrolux","Godrej","Haier","Hitachi","IFB","Kelvinator","LG","Panasonic","Samsung","Sharp","Toshiba","Videocon","Whirlpool"]
    
    static var refrigeratorStorageVolumeBrandArray = ["200 - 299 Ltr","300 - 399 Ltr","400 - 499 Ltr","500 - 599 Ltr","Below 199 Ltr","600 Ltr and above"]
    
    static var airCoolerBrandArray = ["Bajaj","Crompton Greaves","Eurolex","Kenstar","Khaitan","Maharaja Whiteline","Orient","Others","Ram Coolers","Symphony","Usha"]

    static var fansBrandArray = ["Arise","Bajaj","Champion Electronics","Crompton Greaves","EON","Havells","Hotstar","Khaitan","Luminous","Maharaja Whiteline","Orient","Orpat","Usha","Vents"]
    
    static var fanSelectTypeArray = ["Ceilling Fan","Exhaust Fan","Padestal Fan","Table Fan","Wall Fan","Others"]
    
    static var geysersBrandArray = ["AO Smith","Arise","Bajaj","Champion Electronics","Crompton Greaves","Haier","Havells","Inalsa","Kenstar","Littlehome","Maharaja Whiteline","Morphy Richards","Olympus","Orient","Orpat","Racold","Staar","Usha","V-Guard","Venus","Warmex","Westinghouse"]
    
    static var washingMachineBrandArray = ["Bosch","Electrolux","Godrej","Haier","Hitachi","IFB","LG","Onida","Others","Panasonic","Samsung","Sharp","Voltas","Videocon","Whirlpool"]
    
    static var waterPurifierBrandArray = ["Aqua Fresh","Eureka Forbes","Kent","Krona","Livpure","Nasaka","Pureit","Whirlpool","Zero B"]
    
    static var vaccuumCleanerBrandArray = ["Black & Decker","Bosch","Eureka Forbes","Euroline","Eurostar","Inalsa","Karcher","LG","Morphy Richards","Others","Panasonic","Philips"]
    
    static var furnitureHomeTypeArray = ["Bedroom Furniture","Chair","Living Room Furniture","Kitchen,Dining & Bar","Office Furniture","Tables","Storage Cabinets","Garden Furniture","Bathroom","Others"]
    
    static var homeApplianceTypeArray = ["Chiney,Hoods & Hobs","Cooking Range & Hobs","Juicer,Mixer & Grinder","Toaster & Sandwich Maker","Roti Maker & Snack Maker","Iron-Dry & Steam Iron","Everything Else"]
    
    static var homeDecorativeTypeArray = ["Wall Clocks","Indoor Lighting","Rugs","Decorative candles","Photo Frames","Artificial Plants","Decorative Boxes","Ashtrays","Door Signs","Paintings","Decorative Stickers","Door Mats","Vases","Seasonal Decorations","Other Decorative Items"]
    
    static var microwaveBrandArray = ["Bajaj","Electrolux","Godrej","IFB","Inalsa","Jaipan","Kenstar","Kenwood","LG","Morphy Richards","Onida","Oster","Others","Panasonic","Philips","Samsung","Skyline","Sunflame","Usha","Whirlpool"]
    
    static var bathroomRepairTypeArray = ["Taps & Faucets","Showers & Accessories","Sanitoryware","Bathroom Fittings & Sinks","Other Bathroom Fittings"]
    
    static var hotelAndRestrauntSupplyTypeArray = ["Tea Coffee Counter","Four Door Refrigerator","Tilting Bulk Cooker","Salamender","Trolleys & Racks","Display Counters","Refrigeration Equipments","Cooking Equipments","Table & Sinks","Exhaust Equipments","Dish Washing Equipments","Bar Equipments","Water Coolers","Pop Corn Machine","Restaurant Furniture","Hotel Furniture","Everything Else"]
    
    static var outdoorGardenItemsTypeArray = ["Gazebos / Canopies","Swings","Hammocks","Barbeque","Patio Furniture","Gardening Tools","Plant Containers","Watering Equipments","Outdoor Chairs / Tables","Plants","Fertilizer & Soil","Seeds","Outdoor Lighting","Everything Else"]
    
    static var otherHouseholdGoodsTypeArray = ["Lightings","Rugs & Mats","Electric Shaver","Bells & Chimes","Mattresses","Gas Stoves","Bean Bags","Sofa Upholstery","Ironing Board","Laundry Equipments","Heat Convertors","Voltage Stablizers","Microwaveble Storage","Dinner Sets","Everything Else"]
    
    static var petsTypeArray = ["Dogs","Cats","Birds","Fish","Horses","Rodents","Exotics","Other Pets"]
    
    static var maidsServicesTypeArray = ["Baby Sitters","Car Drivers","Cooks","Domestic Helpers"]
    
    static var homeRepairTypeArray = ["Carpenters & Painters","Electricials & Plumbers","Electronics & Appliances Repair","Home Repair"]
    
    static var telecomRepairTypeArray = ["Computer Repair","Laptop Repair","Mobile Repair","Software Services"]
    
    static var healthAndBeautyTypeArray = ["Beauticians","Parlours & Saloons","Photographer"]
    
    static var otherServicesTypeArray = ["Dj","Events & Party Planners","Placement & Rectruitment Agencies","Printing Services","Other Services"]
    
    static var personalFinanceTypeArray = ["Insurance Agents","Loan Agents & Companies"]
    
    static var mensClothingTypeArray = ["Clothing","Watches","Bags","Sunglasses","Fregrances","Footwear","Accessories"]
    
    static var kidsClothingTypeArray = ["Boys Clothing","Girls Clothing","Toys","Shoes","School Bags","Accessories","Everything Else"]
    
    static var booksTypeArray = ["Academic & Professional","Art & Photography","Bussiness & Money","Children & Teens","Comics & Graphic Novels","Computer & Technology","Cook Books,Food & Wine","Entrance Exam","Literature & Fiction","Mystery,Thrillers & Suspense","Politics & Social Science","Romance","Sports & Outdoors","Travel","Religion & Spirituality","New Release","Others"]
    
    static var cdTypeArray = ["Movies","Drama","Faith & Spirituality","Sports","Children Games"]
    
    static var stationaryTypeArray = ["Diaries,Planners, Desk Organisers","Files & Folders","Writing Instruments","Writing Pads","General Stationary","Everything Else"]
    
    static var homeTutorType = ["Class Ist - 8th","Class 9th - 12th","Crafts & Hobbies","Dance Classes","Engineering Entrance / IIT-JEE","Engineering Subjects","Medical Entrance / AIPMT","Music","Spoken English","Sports & Fitness","Swimming"]
    
    static var onlineTutorType = ["Class 9th - 12th","Competitive Exams","Computer Software Training","Distance Education","Engineering Entrance / IIT-JEE","Engineering Subjects","GRE / GMAT / TOEFL / IELTS","Job Training","Law / Judiciary Coaching","MBA / BBA","Medical Entrance / AIPMT","Spoken English","Sports & Fitness","Other Online Training Institutes"]
    
    static var coachingSchoolType = ["Acting Schools","CA Coaching","CAD / CAM / CAE  Coaching","Call Center Training","Cinematography","Class 9th - 12th","Competitive Exams","Computer Software Training","Crafts & Hobbies","Dance & Music Institutes","Distance Education","Engineering Entrance / IIT-JEE","Engineering Subjects","Fashion & Modelling Institutes","GRE / GMAT / TOEFL / IELTS","Interior Designing Institutes","Job Training","Law / Judiciary Coaching","MBA / BBA","Medical Entrance / AIPMT","Spoken English","Sports Institutes","Yoga Training","Other Institutes"]
   
    static var babyClothingType = ["Boys(2-6 years)","Boys(6-12 years)","Girls(2-6 years)","Girls(6-12 years)","Infants(0-2 years)"]
    
    static var toyType = ["Car seats","Prams","Stroller"]
    
    static var babyBathTypesArray = ["Baby Bath & Accessories","Baby food","Baby Skin Products","Healthcare - Vitamins & Supplements"]
    
    static var childSafetyProductType = ["Baby Gates","Bed Rails & Guards","Gates & Guards","Other Safety Products"]

    static var babyFeedingtype = ["Baby & Kids Utensils","Bottles","Breast Pump","Sterlizers & Warmers","Others"]
    
    static var auditionType = ["Audition For Modelling","Audition For Movies","Audition For Music","Audition For Print Ad","Audition For Short Films","Audition For TV"]
    
    static var actorAndArtistType = ["Anchor","Child Artist","Comedian","Dancer","Lead Artist","Model","Singer","Stuntman","Supporting Artist","Villian","Voice Over Artist","Other Roles"]

    static var experienceYearsType = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25"]
    
    static var experienceMonthsType = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    
    static var otherBollywoodPositionType = ["Action Director","Advertising Agency","Art Director","Assistant Editor","Casting Director","Choreographer","Cinematography","Dialogue Writer","Dubbing Artist","Fiction Director","Graphic Designer","Hair Stylist","Light - Man","Lighting Manager","Lighting Technician","Location Manager","Lyricist","Makeup - Artist","Production Assistant","Screenplay Writer","Script Writer","Set Designers","Spot Boys","Technitians","Other Jobs"]
    
    static var taxiMakeType = ["Chevrolet","Fiat","Ford","Honda","Hyundai","Mahindra","Maruti Suzuki","Nissan","Tata","Other Cars","Luxury Cars"]
    
    static var jewelleryTypeArray = ["Diamond jewellery","Gold jewellery","Solitaire jewellery","Gemstone jewellery","Platinim jewellery","Silver jewellery","Other jewellery"]
    
    static var jewellerySubTypeArray = ["Rings","Earrings","Pendants","Necklaces","Bangles & Bracelets","Chains & Necklaces","Gold Coins","Other jewellery"]
    
    static var gemstoneType = ["Yellow Sapphire","Blue Sapphire-Neelam","Ruby-Manik","Emerald-Panna","Red Coral-Moonga","White Sapphire","Pink Sapphire","Pearl-Moti","Hessonite-Gomedh","Blue Zircon","Other Diamonds & Pearls"]
    
    static var rudrakshaTypes = ["1 Mukhi","2 Mukhi","3 Mukhi","4 Mukhi","5 Mukhi","6 Mukhi","7 Mukhi","8 Mukhi","9 Mukhi","10 Mukhi","11 Mukhi","12 Mukhi","13 Mukhi","14 Mukhi","15 Mukhi","16 Mukhi","17 Mukhi"]
    
    static var agricultureType = ["Agricultural Equipments","Livestock Supplies","Tools"]
    
    static var automotivetypes = ["Auto Brake Disk","Auto Brake Pads","Auto Electrical & Lighting System","Auto Shock Absorbers","Auto Suspension Spring","Brake System","Car Bumpers","Casts & Forged","Engine & Engine Spare Parts","Fabrication Services","Gear, Gear Boxes & Parts","Machining Parts","Suspension System","Everything Else"]
    
    static var constructiontype = ["Building Material & Supplies","Construction Equipments","levels & Surveying Equipments","Modular & Prefabricated","Protective Gears","Others"]
    
    static var electricalEquipmentType = ["Connectors, Switches & Wires","Electrical Components","Electrical Equipments & Tool","Industrial Automation & Control","Motor & Transmissions","Switch,Gears & Transformers","Test Equipments","Other Equipments & Supplies"]
    
    static var fuelAndEnergyType = ["Alternative Fuel & Energy","Oil & Gas","Power & Utilities","Other Equipments & Supplies"]
    
    static var healthAndLifeScienceTypes = ["Hospital Furniture","Imaging Aesthetic Equipments","Imaging Aesthetic Supplies","Lab Equipments, Lab Supplies","Medical Equipments","Medical Supplies & Disposables","Everything Else"]
    
    static var heavyEquipmentsType = ["Attachments","Backhoe Loader","Crawlers Dozers & Loaders","EDM Machines","Excavators","Forklifts","Parts & Accessories","Scissor & Boom Lifts","Skid Steer Loader","Other Equipments"]
   
    static var mROType = ["Fasteners","Fittings","Hose & Tubing","HVAC","Hydraulics & Pneumatics","Janitorial","Lighting & Batteries","Lubrication","Material Handling","Pumps & Safety","Safety & Security","Tools & Equipments"]

    static var metalWorkingTypes = ["Apparel & Textile Equipments","Metal & Alloys","Metalworking Tooling","Process Equipments","Semiconductor & PCB Equipments","Welding","Woodworking","Others"]

    static var restaurantCateringTypes = ["Bar & Beverage Equipments","Commercial Kitchen Equipments","Furniture Signs & Decor","Refrigeration & Ice Machine","Tabletop & Serving","Uniforms & Aprons","Vending & Tabletop Concessions","Others"]
    
    static var hotelFeaturesArray = ["Airport Transfer","Nightclub","Restaurant","Spa-Sauna","Swimming Pool","Internet"]
    
    static var flatAmenitiesRentArray = ["Piped Gas","Wardrobe","TV","Dining Table","Fridge","Sofa Set","Wi-Fi","Microwave","AC","Servant Room"]
    
     static var flatAmenitiesSaleArray = ["Piped Gas","Wardrobe","Modular Kitchen","AC","Water Purifier","Servant Room","Private Garden","Terrace","Intercom Facility","Vastu Compliant"]
    
    static var societyAmenitiesArray = ["Parking","Lift","Gym","Swimming Pool","Club House","24 x 7 Security","Power Backup","Kids Play Area","Garden","Water Storage"]
    
    static var areaInSqFtArray = ["Upto 500","500 - 1,250","1,250 - 2,000","2,000 - 3,000","3,000 - 5,000","5000+"]
}

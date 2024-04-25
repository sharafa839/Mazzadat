//
//  Constants.swift
//  TeamPlusApp
//
//  Created by Ammar AlTahhan on 22/01/2019.
//  Copyright © 2019 Ammar AlTahhan. All rights reserved.
//

import Foundation
import UIKit
import PassKit

//this is an old file and should be refactored
struct Constants {
    struct Storyboard {
        static let Auth = UIStoryboard(name: "Auth", bundle: Bundle.main)
        static let VenuesLists = UIStoryboard(name: "VenuesLists", bundle: Bundle.main)
        static let PeerEvaluation = UIStoryboard(name: "PeerEvaluation", bundle: Bundle.main)
        static let PeerAssessment = UIStoryboard(name: "PeerAssessment", bundle: Bundle.main)
    }
    
    struct UserDefaults {
        static let IsFirstTime = "isFirstTime"
        static let Token = "token"
        static let User = "user"
    }
    
    // TODO: should be removed
    struct API {
        private static let Base = "http://128.199.164.215/api/v1/"
        
        static let Login = Base + "login"
        static let Signup = Base + "register"
        static let MyCourses = Base + "myCourses"
        static let MyCourse = Base + "myCourse"
        static let ShowCourseWithCode = Base + "showCourseWithCode"
        static let JoinCourse = Base + "joinCourse"
        static let ShowCourseTeams = Base + "showCourseMembers"
        static let JoinTeam = Base + "joinTeam"
        static let LeaveTeam = Base + "leaveTeam"
        static let PeerEvaluation = Base + "getPeerEvaluation"
        static let PeerEvaluationReport = Base + "getPeerEvaluationReport"
        static let PeerAssessmentTeams = Base + "getPeerAssessmentTeams"
        static let PeerAssessment = Base + "getPeerAssessment"
        static let PeerAssessmentReport = Base + "getPeerAssessmentReport"
        
        static let SaveAnswer = Base + "saveAnswer"
        static let SavePeerAssessmentAnswer = Base + "savePeerAssessmentAnswer"
        static let SubmitAnswer = Base + "submitAnswer"
        static let SubmitPeerAssessmentAnswer = Base + "submitPeerAssessment"
    }
    
    struct NotificationCenterEvents {
        static let didChangeDate = NSNotification.Name(rawValue: "didChangeDate")
    }
    
    struct Font {
        static func defaultFont(size: CGFloat) -> UIFont {
            return UIFont(name: "Ubuntu", size: size)!
        }
        static func defaultMediumFont(size: CGFloat) -> UIFont {
            return UIFont(name: "Ubuntu-Medium", size: size)!
        }
        static func defaultLightFont(size: CGFloat) -> UIFont {
            return UIFont(name: "Ubuntu-Light", size: size)!
        }
    }
    
    struct DateFormat {
        static let MainDate = "yyyy-MM-dd"
        static let StartOfferDate = "yyyy-MM-dd"
        static let Main = "yyyy-MM-dd HH:mm:ss"
        static let Secondary = "yyyy-MM-dd HH:mm:ss.SSSSSS"
        static let personalizedOfferDateFormat = "yyyy-MM-dd hh:mm:ss"
        static let dayFormat = "EEEE"
        static let dayWithDateFormat = "EEEE dd/MM/yyyy"

        static let monthFormat = "d-MMM-yyyy"

    }
    
    //AMPLITUED
    struct Amplitude {
        static let APIKey = Bundle.main.infoDictionary!["AMPLITUDE_API_KEY"] as! String
        
        struct Events{
            static let LoginFail = "Login Fail"
            static let AddToFavorite = "Add To Favorite"
            static let ClickBookVenue = "Click (Book Venue)"
            static let ChooseBookingOption = "Choose Booking Option"
            static let ChooseBookingOptionInside = "Choose Booking Option Inside"
            static let ClickContinueBooking = "Click Continue Booking"
            static let ClickCompletePayment = "Click Complete payment"
            static let ClickPayNow = "Click Pay Now" // old, not used now and might be removed in the future
            static let ClickPay = "Click Pay"
            static let IncompleteBooking = "Incomplete Booking"
            static let RegisterLater = "Register Later"
            static let AccountNotVerified = "Account Not Verified"
            static let AccountVerified = "Account Verified"
            static let ViewVenue = "View Venue"
            static let EventType = "Event Type"
            static let DateChosen = "Date Chosen"
            static let ShowOptionDetails = "Show Option Details"
            static let Logout = "Logout"
            static let Guests = "Guests"
            static let SearchQuery = "Search Query"
            static let StartSearch = "Start Search"
            static let ClickPhotos = "Click Photos"
            static let Region = "Region"
            static let PaymentSucceeded = "Payment Succeeded"
            static let PaymentFailed = "Payment Failed"
            
            // TODO: THE FOLLOWING EVENT ARE NOT IN THE EXCELL FILE AND SHOULD BE ADDED WHENEVER IT HAS TO BE IN OTHER PLATFORMS
            static let VenueScrollViewScrolledToMax = "Venue Scroll View Scrolled To Max"
            static let ForgotPasswordTapped = "Forgot Password Tapped"
            static let RecoverPasswordTapped = "Recover Password Tapped"

            
            
            
        }
    }
    
    
    //APPLEPAY
    struct ApplePay{
        static let merchantId = "merchant.com.qosoor.app"
        static let countryCode = "SA"
        static let currencyCode = "SAR"
        
        static func supportedNetworks() -> [PKPaymentNetwork]{
            var networks = [PKPaymentNetwork.visa, .masterCard]
            if #available(iOS 12.1.1, *) {
                networks.append(.mada)
            }
            return networks
        }
    }
    
    struct MadaCard {
        static let paymentFailurePath = "/qosoor/api/v1/madaPaymentFailure"
        static let paymentSuccessPath = "/qosoor/api/v1/madaPaymentSuccess"
        
        static let madaBins = [
            "588845"
            ,"440647"
            ,"440795"
            ,"446404"
            ,"457865"
            ,"968208"
            ,"588846"
            ,"493428"
            ,"539931"
            ,"558848"
            ,"557606"
            ,"968210"
            ,"636120"
            ,"417633"
            ,"468540"
            ,"468541"
            ,"468542"
            ,"468543"
            ,"968201"
            ,"446393"
            ,"588847"
            ,"400861"
            ,"409201"
            ,"458456"
            ,"484783"
            ,"968205"
            ,"462220"
            ,"455708"
            ,"588848"
            ,"455036"
            ,"968203"
            ,"486094"
            ,"486095"
            ,"486096"
            ,"504300"
            ,"440533"
            ,"489317"
            ,"489318"
            ,"489319"
            ,"445564"
            ,"968211"
            ,"401757"
            ,"410685"
            ,"432328"
            ,"428671"
            ,"428672"
            ,"428673"
            ,"968206"
            ,"446672"
            ,"543357"
            ,"434107"
            ,"431361"
            ,"604906"
            ,"521076"
            ,"588850"
            ,"968202"
            ,"535825"
            ,"529415"
            ,"543085"
            ,"524130"
            ,"554180"
            ,"549760"
            ,"588849"
            ,"968209"
            ,"524514"
            ,"529741"
            ,"537767"
            ,"535989"
            ,"536023"
            ,"513213"
            ,"585265"
            ,"588983"
            ,"588982"
            ,"589005"
            ,"508160"
            ,"531095"
            ,"530906"
            ,"532013"
            ,"588851"
            ,"605141"
            ,"968204"
            ,"422817"
            ,"422818"
            ,"422819"
            ,"428331"
            ,"483010"
            ,"483011"
            ,"483012"
            ,"589206"
            ,"968207"
            ,"419593"
            ,"439954"
            ,"407197"
            ,"407395"
        ]
        static func isMadaCard(cardNumber num: String) -> Bool{
            let index = num.index(num.startIndex, offsetBy: 6)
            let cardBin = String(num[..<index])//get the first 6 digits that represents the pin
            print(cardBin)
            let contains = madaBins.contains(cardBin)
            return contains
            
        }
    }
}

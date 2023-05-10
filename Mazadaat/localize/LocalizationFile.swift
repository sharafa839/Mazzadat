//
//  LocalizationFile.swift
//  Mazadaat
//
//  Created by Sharaf on 09/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
protocol Localizable {
    var localize:String {get}
}

enum Localizations {
    
    
    case goodToSeeYou,welcome,signIn,register,enterYourMobile,enterPassword,forgetPassword,or,continueAsGuest,enterTheEmail,enterYourMobileNumber,verifyYourOtp,weHaveSent,dontRecieve,verify,incorrectCode,resendVerificationCode,resetPassword,passwordShouldBe,newPassword,confirmPassword,save,success,yourPassword,confirm,failed,anError,dismissing,tryAgain,join,withAFree,enterYourFullName,etnerYourMobileNumber,enterYourEmail,createAPassword,verifyWithNafath,loginToNafath,cancel,welcomeBack,home,askGoldenBell,auctions,profile,exploreGoldenBell,aboutGoldenBell,GoldenBellCommuunity,rateGoldenBell,plans,freePlan,youPay,yourLimitBid,SAR,premiumPlan,yourCuurrentPlan,upgrade,deleteYourNationalIDCard,areYouSureYouWantToDeleteNationalId,remove,discardChanges,anyChanges,discard,myProfile,myDocuments,toBid,delete,change,drivingLicence,add,frontView,backView,uploadDocument,requestAnAuction,myTickets,chat,plan,yourAuctionRequest,newAuctionRequest,auctionTitle,writeAuctionTitle,auctionDescription,writeAuctionDescription,sendRequesst,all,running,solved,giveAFeedback,writeYourFeedback,sendFeedback,contactUs,inquryAbout,yourMessage,writeYourMessage,call,contact,setting,appLanguage,genrealNotification,auctionAlerts,bidUpdates,auctionEndingSoon,promotions,changePassword,oldPassword,supportingText,confrimNewPassword,emailAddress,verifyPhoneNumber,emailUs,callUs,settings,phoneNumber,displayName,personslInformation,emilAddress,faqs,privacyPolicy,termsOfUse,biddings,myauctions,myGoldenList,share,about
}

extension Localizations:Localizable {
    var localize: String {
        switch self {
        case .about:
            return "about".localize
        case .share:
            return "share".localize
        case .goodToSeeYou:
            return "goodToSeeYou".localize
        case .welcome:
            return "welcome".localize
        case .signIn:
            return "signIn".localize
        case .register:
            return "register".localize
        case .enterYourMobile:
            return "enterYourMobile".localize
        case .enterPassword:
            return "enterPassword".localize
        case .forgetPassword:
             return "forgetPassword".localize
            
        case .or:
            return "or".localize
        case .continueAsGuest:
            return "continueAsGues".localize
        case .enterTheEmail:
            return "enterTheEmail".localize
        case .enterYourMobileNumber:
            return "enterYourMobileNumber".localize
        case .verifyYourOtp:
            return "verifyYourOtp".localize
        case .weHaveSent:
            return "weHaveSent".localize
        case .dontRecieve:
            return "dontRecieve".localize
        case .verify:
            return "verify".localize
        case .incorrectCode:
            return "incorrectCode".localize
        case .resendVerificationCode:
            return "resendVerificationCode".localize
        case .resetPassword:
            return "resetPassword".localize
        case .passwordShouldBe:
            return "passwordShouldBe".localize
        case .newPassword:
            return "newPassword".localize
        case .confirmPassword:
            return "confirmPassword".localize
        case .save:
            return "save".localize
        case .success:
            return "success".localize
        case .yourPassword:
            return "yourPassword".localize
        case .confirm:
            return "confirm".localize
        case .failed:
            return "failed".localize
        case .anError:
            return "anError".localize
        case .dismissing:
            return "dismissing".localize
        case .tryAgain:
            return "tryAgain".localize
        case .join:
            return "join".localize
        case .withAFree:
            return "WithAFree".localize
        case .enterYourFullName:
            return "enterYourFullName".localize
        case .etnerYourMobileNumber:
            return "etnerYourMobileNumber".localize
        case .enterYourEmail:
            return "enterYourEmail".localize
        case .createAPassword:
            return "createAPassword".localize
        case .confirmPassword:
            return "confirmPassword".localize
        case .verifyWithNafath:
            return "verifyWithNafath".localize
        case .loginToNafath:
            return "loginToNafath".localize
        case .cancel:
            return "cancel".localize
        case .welcomeBack:
            return "welcomeBack".localize
        case .home:
            return "home".localize
        case .askGoldenBell:
            return "askGoldenBell".localize
        case .auctions:
            return "auctions".localize
        case .profile:
            return "profile".localize
        case .exploreGoldenBell:
            return "exploreGoldenBell".localize
        case .aboutGoldenBell:
            return "aboutGoldenBell".localize
        case .GoldenBellCommuunity:
            return "GoldenBellCommuunity".localize
        case .rateGoldenBell:
            return "rateGoldenBell".localize
        case .plans:
            return "plans".localize
        case .freePlan:
            return "freePlan".localize
        case .youPay:
            return "youPay".localize
        case .yourLimitBid:
            return "yourLimitBid".localize
        case .SAR:
            return "SAR".localize
        case .premiumPlan:
            return "premiumPlan".localize
        case .yourCuurrentPlan:
            return "yourCuurrentPlan".localize
        case .upgrade:
            return "upgrade".localize
        case .deleteYourNationalIDCard:
            return "deleteYourNationalIDCard".localize
        case .areYouSureYouWantToDeleteNationalId:
            return "areYouSureYouWantToDeleteNationalId".localize
        case .remove:
            return "remove".localize
      
        case .discardChanges:
            return "discardChanges".localize
        case .anyChanges:
            return "anyChanges".localize
        case .discard:
            return "discard".localize
        case .myProfile:
            return "myProfile".localize
        case .myDocuments:
            return "myDocuments".localize
        case .toBid:
            return "toBid".localize
        case .delete:
            return "delete".localize
        case .change:
            return "change".localize
        case .drivingLicence:
            return "drivingLicence".localize
        case .add:
            return "add".localize
        case .frontView:
            return "frontView".localize
        case .backView:
            return "backView".localize
        case .uploadDocument:
            return "uploadDocument".localize
        case .requestAnAuction:
            return "requestAnAuction".localize
        case .myTickets:
            return "myTickets".localize
        case .chat:
            return "chat".localize
        case .plan:
            return "plan".localize
        case .yourAuctionRequest:
            return "yourAuctionRequest".localize
        case .newAuctionRequest:
            return "newAuctionRequest".localize
        case .auctionTitle:
            return "auctionTitle".localize
        case .writeAuctionTitle:
            return "writeAuctionTitle".localize
        case .auctionDescription:
            return "auctionDescription".localize
        case .writeAuctionDescription:
            return "writeAuctionDescription".localize
        case .sendRequesst:
            return "sendRequesst".localize
        case .all:
            return "all".localize
        case .running:
            return "running".localize
        case .solved:
            return "solved".localize
        case .giveAFeedback:
            return "giveAFeedback".localize
        case .writeYourFeedback:
            return "writeYourFeedback".localize
        case .sendFeedback:
            return "sendFeedback".localize
        case .contactUs:
            return "contactUs".localize
        case .inquryAbout:
            return "inquryAbout".localize
        case .yourMessage:
            return "yourMessage".localize
        case .writeYourMessage:
            return "writeYourMessage".localize
        case .call:
            return "call".localize
        case .contact:
            return "contact".localize
        case .setting:
            return "setting".localize
        case .appLanguage:
            return "appLanguage".localize
        case .genrealNotification:
            return "genrealNotification".localize
        case .auctionAlerts:
            return "auctionAlerts".localize
        case .bidUpdates:
            return "bidUpdates".localize
        case .auctionEndingSoon:
            return "auctionEndingSoon".localize
        case .promotions:
            return "promotions".localize
        case .changePassword:
            return "changePassword".localize
        case .oldPassword:
            return "oldPassword".localize
        case .supportingText:
            return "supportingText".localize
        case .confrimNewPassword:
            return "confrimNewPassword".localize
        case .emailAddress:
            return "emailAddress".localize
        case .verifyPhoneNumber:
            return "verifyPhoneNumber".localize
        case .emailUs:
            return "emailUs".localize
        case .callUs:
            return "callUs".localize
        case .settings:
            return "settings".localize
        case .phoneNumber:
            return "phoneNumber".localize
        case .displayName:
            return "displayName".localize
        case .personslInformation:
            return "personslInformation".localize
        case .emilAddress:
            return "emilAddress".localize
        case .faqs:
            return "faqs".localize
        case .privacyPolicy:
            return "privacyPolicy".localize
        case .termsOfUse:
            return "termsOfUse".localize
        case .biddings:
            return "biddings".localize
        case .myauctions:
            return "myauctions".localize
        case .myGoldenList:
            return "myGoldenList".localize
        }
    }
}

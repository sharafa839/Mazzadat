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

enum Localization:String {
    case goodToSeeYou,welcome,signIn,register,enterYourMobile,enterPassword,forgetPassword,signIn,or,continueAsGuest,forgetPassword,enterTheEmail,enterYourMobileNumber,verifyYourOtp,weHaveSent,dontRecieve,verify,incorrectCode,resendVerificationCode,resetPassword,passwordShouldBe,newPassword,confirmPassword,save,success,yourPassword,confirm,failed,anError,dismissing,tryAgain,join,withAFree,enterYourFullName,etnerYourMobileNumber,enterYourEmail,createAPassword,confirmPassword,verifyWithNafath,loginToNafath,cancel,welcomeBack,home,askGoldenBell,auctions,profile,exploreGoldenBell,aboutGoldenBell,GoldenBellCommuunity,rateGoldenBell,plans,freePlan,youPay,yourLimitBid,SAR,premiumPlan,yourCuurrentPlan,upgrade,deleteYourNationalIDCard,areYouSureYouWantToDeleteNationalId,remove,cancel,discardChanges,anyChanges,discard,myProfile,myDocuments,toBid,delete,change,drivingLicence,add,frontView,backView,uploadDocument,requestAnAuction,myTickets,chat,plan,yourAuctionRequest,newAuctionRequest,auctionTitle,writeAuctionTitle,auctionDescription,writeAuctionDescription,sendRequesst,all,running,solved,giveAFeedback,writeYourFeedback,sendFeedback,contactUs,inquryAbout,yourMessage,writeYourMessage,call,contact,setting,appLanguage,genrealNotification,auctionAlerts,bidUpdates,auctionEndingSoon,promotions,changePassword,oldPassword,supportingText,confrimNewPassword,emailAddress,verifyPhoneNumber,emailUs,callUs,settings,phoneNumber,displayName,personslInformation,emilAddress,faqs,privacyPolicy,termsOfUse,biddings,auctions,myauctions,myGoldenList,
}

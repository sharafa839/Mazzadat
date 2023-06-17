//
//  ext.swift
//  Naseem
//
//  Created by Amar Amassi  on 7/5/19.
//  Copyright © 2019 Dev Anas. All rights reserved.
//

import UIKit
import Toast_Swift
import AVFoundation




extension Data {
    var bytes : [UInt8]{
        return [UInt8](self)
    }
}



extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
}


extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        
        return arrayOrdered
    }
}




extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
 public   init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
extension AVPlayer {
  public  func addProgressObserver(action:@escaping ((Double) -> Void)) -> Any {
        return self.addPeriodicTimeObserver(forInterval: CMTime.init(value: 1, timescale: 1), queue: .main, using: { time in
            if let duration = self.currentItem?.duration {
                let duration = CMTimeGetSeconds(duration), time = CMTimeGetSeconds(time)
                let progress = (time/duration)
                action(progress)
            }
        })
    }
}



extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}




//extension UIViewController {
//
//    func setBackButton(){
//        let yourBackImage = UIImage(named: "Back")
//        navigationController?.navigationBar.backIndicatorImage = yourBackImage
//        navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
//    }
//
//}










extension UIImage {///Rotate Image
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.x, y: -origin.y,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        
        return self
    }
}


extension UIViewController {
    func errorAlert(title : String , body : String){
        let alert = UIAlertController.init(title:title, message: body , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "OK".localized, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func toastAlert(title : String ){
        var style = ToastStyle()
        style.messageColor = .white
        self.view.makeToast(title, duration: 3.0, position: .bottom, style: style)


      }
}






extension Date {
    
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: "Asia/Riyadh (+03:00)3")

        formatter.locale = Locale(identifier: "en_US_POSIX")

        return formatter.string(from: self)
    }
    
    func toArString(format: String = "yyyy-MM-dd") -> String {
          let formatter = DateFormatter()
          formatter.dateStyle = .short
        formatter.locale = Locale(identifier: "en")
        formatter.timeZone =  TimeZone.current

          formatter.dateFormat = format
          return formatter.string(from: self)
      }
    
    func dateAndTimetoString(format: String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func timeIn24HourFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    func startOfMonth() -> Date {
        var components = Calendar.current.dateComponents([.year,.month], from: self)
        components.day = 1
        let firstDateOfMonth: Date = Calendar.current.date(from: components)!
        return firstDateOfMonth
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func nextDate() -> Date {
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: self)
        return nextDate ?? Date()
    }
    
    func previousDate() -> Date {
        let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: self)
        return previousDate ?? Date()
    }
    
    func addMonths(numberOfMonths: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .month, value: numberOfMonths, to: self)
        return endDate ?? Date()
    }
    
    func removeMonths(numberOfMonths: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .month, value: -numberOfMonths, to: self)
        return endDate ?? Date()
    }
    
    func removeYears(numberOfYears: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .year, value: -numberOfYears, to: self)
        return endDate ?? Date()
    }
    
    func getHumanReadableDayString() -> String {
        let weekdays = [
            "Sunday".localized,
            "Monday".localized,
            "Tuesday".localized,
            "Wednesday".localized,
            "Thursday".localized,
            "Friday".localized,
            "Saturday".localized
        ]
        
        let calendar = Calendar.current.component(.weekday, from: self)
        return weekdays[calendar - 1]
    }
    
    
    func timeSinceDate(fromDate: Date) -> String {
        let earliest = self < fromDate ? self  : fromDate
        let latest = (earliest == self) ? fromDate : self
        
        let components:DateComponents = Calendar.current.dateComponents([.minute,.hour,.day,.weekOfYear,.month,.year,.second], from: earliest, to: latest)
        let year = components.year  ?? 0
        let month = components.month  ?? 0
        let week = components.weekOfYear  ?? 0
        let day = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        
        
        if year >= 2{
            return "\(year) years ago"
        }else if (year >= 1){
            return "1 year ago"
        }else if (month >= 2) {
            return "\(month) months ago"
        }else if (month >= 1) {
            return "1 month ago"
        }else  if (week >= 2) {
            return "\(week) weeks ago"
        } else if (week >= 1){
            return "1 week ago"
        } else if (day >= 2) {
            return "\(day) days ago"
        } else if (day >= 1){
            return "1 day ago"
        } else if (hours >= 2) {
            return "\(hours) hours ago"
        } else if (hours >= 1){
            return "1 hour ago"
        } else if (minutes >= 2) {
            return "\(minutes) minutes ago"
        } else if (minutes >= 1){
            return "1 minute ago"
        } else if (seconds >= 3) {
            return "\(seconds) seconds ago"
        } else {
            return "Just now"
        }
        
    }
}


extension UITextField {
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textAlignment = .right



    }
}


//emailValdate
extension String {
//    func isValidEmail() -> Bool {
//        // here, `try!` will always succeed because the pattern is valid
//        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
//        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
//    }
}




extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.1,
        x: CGFloat = 0,
        y: CGFloat = 0,
        blur: CGFloat = 9,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}





extension UIView {
func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
if #available(iOS 11, *) {
self.layer.cornerRadius = radius
self.layer.maskedCorners = corners
        } else {
var cornerMask = UIRectCorner()
if(corners.contains(.layerMinXMinYCorner)){
                cornerMask.insert(.topLeft)
            }
if(corners.contains(.layerMaxXMinYCorner)){
                cornerMask.insert(.topRight)
            }
if(corners.contains(.layerMinXMaxYCorner)){
                cornerMask.insert(.bottomLeft)
            }
if(corners.contains(.layerMaxXMaxYCorner)){
                cornerMask.insert(.bottomRight)
            }
let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
let mask = CAShapeLayer()
            mask.path = path.cgPath
self.layer.mask = mask
        }
    }
}




class CustomPageControl: UIPageControl {

@IBInspectable var currentPageImage: UIImage?

@IBInspectable var otherPagesImage: UIImage?

override var numberOfPages: Int {
    didSet {
        updateDots()
    }
}

override var currentPage: Int {
    didSet {
        updateDots()
    }
}

override func awakeFromNib() {
    super.awakeFromNib()
    pageIndicatorTintColor = .clear
    currentPageIndicatorTintColor = .clear
    clipsToBounds = false
}

private func updateDots() {

    for (index, subview) in subviews.enumerated() {
        let imageView: UIImageView
        if let existingImageview = getImageView(forSubview: subview) {
            imageView = existingImageview
        } else {
            imageView = UIImageView(image: otherPagesImage)

            imageView.center = subview.center
            subview.addSubview(imageView)
            subview.clipsToBounds = false
        }
        imageView.image = currentPage == index ? currentPageImage : otherPagesImage
    }
}

private func getImageView(forSubview view: UIView) -> UIImageView? {
    if let imageView = view as? UIImageView {
        return imageView
    } else {
        let view = view.subviews.first { (view) -> Bool in
            return view is UIImageView
        } as? UIImageView

        return view
    }
}
}





public extension Date {
    
    // MARK: Convert from String
    
    /*
     Initializes a new Date() objext based on a date string, format, optional timezone and optional locale.
     
     - Returns: A Date() object if successfully converted from string or nil.
     */
    init?(fromString string: String, format:DateFormatType, timeZone: TimeZoneType = .local, locale: Locale = Foundation.Locale.current) {
        guard !string.isEmpty else {
            return nil
        }
        var string = string
        switch format {
        case .dotNet:
            let pattern = "\\\\?/Date\\((\\d+)(([+-]\\d{2})(\\d{2}))?\\)\\\\?/"
            let regex = try! NSRegularExpression(pattern: pattern)
            guard let match = regex.firstMatch(in: string, range: NSRange(location: 0, length: string.utf16.count)) else {
                return nil
            }
            #if swift(>=4.0)
            let dateString = (string as NSString).substring(with: match.range(at: 1))
            #else
            let dateString = (string as NSString).substring(with: match.rangeAt(1))
            #endif
            let interval = Double(dateString)! / 1000.0
            self.init(timeIntervalSince1970: interval)
            return
        case .rss, .altRSS:
            if string.hasSuffix("Z") {
                string = string[..<string.index(string.endIndex, offsetBy: -1)].appending("GMT")
            }
        default:
            break
        }
        let formatter = Date.cachedFormatter(format.stringFormat, timeZone: timeZone.timeZone, locale: locale)
        guard let date = formatter.date(from: string) else {
            return nil
        }
        self.init(timeInterval:0, since:date)
    }
    
    var toCurrentTimezoneLocale: Date {
        return Date(fromString: toString(format: .isoDateTime, timeZone: .local, locale: .current), format: .isoDateTime)!
    }
    
    // MARK: Convert to String
    
    
    /// Converts the date to string using the short date and time style.
    func toString(style:DateStyleType = .short) -> String {
        switch style {
        case .short:
            return self.toString(dateStyle: .short, timeStyle: .short, isRelative: false)
        case .medium:
            return self.toString(dateStyle: .medium, timeStyle: .medium, isRelative: false)
        case .long:
            return self.toString(dateStyle: .long, timeStyle: .long, isRelative: false)
        case .full:
            return self.toString(dateStyle: .full, timeStyle: .full, isRelative: false)
        case .ordinalDay:
            let formatter = Date.cachedOrdinalNumberFormatter
            if #available(iOSApplicationExtension 9.0, *) {
                formatter.numberStyle = .ordinal
            }
            return formatter.string(from: component(.day)! as NSNumber)!
        case .weekday:
            let weekdaySymbols = Date.cachedFormatter().weekdaySymbols!
            let string = weekdaySymbols[component(.weekday)!-1] as String
            return string
        case .shortWeekday:
            let shortWeekdaySymbols = Date.cachedFormatter().shortWeekdaySymbols!
            return shortWeekdaySymbols[component(.weekday)!-1] as String
        case .veryShortWeekday:
            let veryShortWeekdaySymbols = Date.cachedFormatter().veryShortWeekdaySymbols!
            return veryShortWeekdaySymbols[component(.weekday)!-1] as String
        case .month:
            let monthSymbols = Date.cachedFormatter().monthSymbols!
            return monthSymbols[component(.month)!-1] as String
        case .shortMonth:
            let shortMonthSymbols = Date.cachedFormatter().shortMonthSymbols!
            return shortMonthSymbols[component(.month)!-1] as String
        case .veryShortMonth:
            let veryShortMonthSymbols = Date.cachedFormatter().veryShortMonthSymbols!
            return veryShortMonthSymbols[component(.month)!-1] as String
        }
    }
    
    func convertDateFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "your_loc_id")
        let convertedDate = dateFormatter.date(from: date)

        guard dateFormatter.date(from: date) != nil else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = "yyyy MMM HH:mm EEEE"///this is what you want to convert format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeStamp = dateFormatter.string(from: convertedDate!)

        return timeStamp
    }
    /// Converts the date to string based on a date format, optional timezone and optional locale.
    func toString(format: DateFormatType, timeZone: TimeZoneType = .local, locale: Locale = Locale.current) -> String {
        switch format {
        case .dotNet:
            let offset = Foundation.NSTimeZone.default.secondsFromGMT() / 3600
            let nowMillis = 1000 * self.timeIntervalSince1970
            return String(format: format.stringFormat, nowMillis, offset)
        default:
            break
        }
        let formatter = Date.cachedFormatter(format.stringFormat, timeZone: timeZone.timeZone, locale: locale)
        return formatter.string(from: self)
    }
    
    
    /// Converts the date to string based on DateFormatter's date style and time style with optional relative date formatting, optional time zone and optional locale.
    func toString(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, isRelative: Bool = false, timeZone: Foundation.TimeZone = Foundation.NSTimeZone.local, locale: Locale = Locale.current) -> String {
        let formatter = Date.cachedFormatter(dateStyle, timeStyle: timeStyle, doesRelativeDateFormatting: isRelative, timeZone: timeZone, locale: locale)
        return formatter.string(from: self)
    }
//
//    /// Converts the date to string based on a relative time language. i.e. just now, 1 minute ago etc...
//    func toStringWithRelativeTime(strings:[RelativeTimeStringType:String]? = nil) -> String {
//
//        let time = self.timeIntervalSince1970
//        let now = Date().timeIntervalSince1970
//        let isPast = now - time > 0
//
//        let sec:Double = abs(now - time)
//        let min:Double = round(sec/60)
//        let hr:Double = round(min/60)
//        let d:Double = round(hr/24)
//
//        if sec < 60 {
//            if sec < 10 {
//                if isPast {
//                    return strings?[.nowPast] ?? NSLocalizedString("just now", comment: "Date format")
//                } else {
//                    return strings?[.nowFuture] ?? NSLocalizedString("in a few seconds", comment: "Date format")
//                }
//            } else {
//                let string:String
//                if isPast {
//                    string = strings?[.secondsPast] ?? NSLocalizedString("%.f seconds ago", comment: "Date format")
//                } else {
//                    string = strings?[.secondsFuture] ?? NSLocalizedString("in %.f seconds", comment: "Date format")
//                }
//                return String(format: string, sec)
//            }
//        }
//        if min < 60 {
//            if min == 1 {
//                if isPast {
//                    return strings?[.oneMinutePast] ?? NSLocalizedString("1 minute ago", comment: "Date format")
//                } else {
//                    return strings?[.oneMinuteFuture] ?? NSLocalizedString("in 1 minute", comment: "Date format")
//                }
//            } else {
//                let string:String
//                if isPast {
//                    string = strings?[.minutesPast] ?? NSLocalizedString("%.f minutes ago", comment: "Date format")
//                } else {
//                    string = strings?[.minutesFuture] ?? NSLocalizedString("in %.f minutes", comment: "Date format")
//                }
//                return String(format: string, min)
//            }
//        }
//        if hr < 24 {
//            if hr == 1 {
//                if isPast {
//                    return strings?[.oneHourPast] ?? NSLocalizedString("last hour", comment: "Date format")
//                } else {
//                    return strings?[.oneHourFuture] ?? NSLocalizedString("next hour", comment: "Date format")
//                }
//            } else {
//                let string:String
//                if isPast {
//                    string = strings?[.hoursPast] ?? NSLocalizedString("%.f hours ago", comment: "Date format")
//                } else {
//                    string = strings?[.hoursFuture] ?? NSLocalizedString("in %.f hours", comment: "Date format")
//                }
//                return String(format: string, hr)
//            }
//        }
//        if d < 7 {
//            if d == 1 {
//                if isPast {
//                    return strings?[.oneDayPast] ?? NSLocalizedString("yesterday", comment: "Date format")
//                } else {
//                    return strings?[.oneDayFuture] ?? NSLocalizedString("tomorrow", comment: "Date format")
//                }
//            } else {
//                let string:String
//                if isPast {
//                    string = strings?[.daysPast] ?? NSLocalizedString("%.f days ago", comment: "Date format")
//                } else {
//                    string = strings?[.daysFuture] ?? NSLocalizedString("in %.f days", comment: "Date format")
//                }
//                return String(format: string, d)
//            }
//        }
//        if d < 28 {
//            if isPast {
//                if compare(.isLastWeek) {
//                    return strings?[.oneWeekPast] ?? NSLocalizedString("last week", comment: "Date format")
//                } else {
//                    let string = strings?[.weeksPast] ?? NSLocalizedString("%.f weeks ago", comment: "Date format")
//                    return String(format: string, Double(abs(since(Date(), in: .week))))
//                }
//            } else {
//                if compare(.isNextWeek) {
//                    return strings?[.oneWeekFuture] ?? NSLocalizedString("next week", comment: "Date format")
//                } else {
//                    let string = strings?[.weeksFuture] ?? NSLocalizedString("in %.f weeks", comment: "Date format")
//                    return String(format: string, Double(abs(since(Date(), in: .week))))
//                }
//            }
//        }
//        if compare(.isThisYear) {
//            if isPast {
//                if compare(.isLastMonth) {
//                    return strings?[.oneMonthPast] ?? NSLocalizedString("last month", comment: "Date format")
//                } else {
//                    let string = strings?[.monthsPast] ?? NSLocalizedString("%.f months ago", comment: "Date format")
//                    return String(format: string, Double(abs(since(Date(), in: .month))))
//                }
//            } else {
//                if compare(.isNextMonth) {
//                    return strings?[.oneMonthFuture] ?? NSLocalizedString("next month", comment: "Date format")
//                } else {
//                    let string = strings?[.monthsFuture] ?? NSLocalizedString("in %.f months", comment: "Date format")
//                    return String(format: string, Double(abs(since(Date(), in: .month))))
//                }
//            }
//        }
//        if isPast {
//            if compare(.isLastYear) {
//                return strings?[.oneYearPast] ?? NSLocalizedString("last year", comment: "Date format")
//            } else {
//                let string = strings?[.yearsPast] ?? NSLocalizedString("%.f years ago", comment: "Date format")
//                return String(format: string, Double(abs(since(Date(), in: .year))))
//            }
//        } else {
//            if compare(.isNextYear) {
//                return strings?[.oneYearFuture] ?? NSLocalizedString("next year", comment: "Date format")
//            } else {
//                let string = strings?[.yearsFuture] ?? NSLocalizedString("in %.f years", comment: "Date format")
//                return String(format: string, Double(abs(since(Date(), in: .year))))
//            }
//        }
//    }
    
    
    // MARK: Compare Dates
    
//    /// Compares dates to see if they are equal while ignoring time.
//    func compare(_ comparison:DateComparisonType) -> Bool {
//        switch comparison {
//        case .isToday:
//            return compare(.isSameDay(as: Date()))
//        case .isTomorrow:
//            let comparison = Date().adjust(.day, offset:1)
//            return compare(.isSameDay(as: comparison))
//        case .isYesterday:
//            let comparison = Date().adjust(.day, offset: -1)
//            return compare(.isSameDay(as: comparison))
//        case .isSameDay(let date):
//            return component(.year) == date.component(.year)
//                && component(.month) == date.component(.month)
//                && component(.day) == date.component(.day)
//        case .isThisWeek:
//            return self.compare(.isSameWeek(as: Date()))
//        case .isNextWeek:
//            let comparison = Date().adjust(.week, offset:1)
//            return compare(.isSameWeek(as: comparison))
//        case .isLastWeek:
//            let comparison = Date().adjust(.week, offset:-1)
//            return compare(.isSameWeek(as: comparison))
//        case .isSameWeek(let date):
//            if component(.week) != date.component(.week) {
//                return false
//            }
//            // Ensure time interval is under 1 week
//            return abs(self.timeIntervalSince(date)) < Date.weekInSeconds
//        case .isThisMonth:
//            return self.compare(.isSameMonth(as: Date()))
//        case .isNextMonth:
//            let comparison = Date().adjust(.month, offset:1)
//            return compare(.isSameMonth(as: comparison))
//        case .isLastMonth:
//            let comparison = Date().adjust(.month, offset:-1)
//            return compare(.isSameMonth(as: comparison))
//        case .isSameMonth(let date):
//            return component(.year) == date.component(.year) && component(.month) == date.component(.month)
//        case .isThisYear:
//            return self.compare(.isSameYear(as: Date()))
//        case .isNextYear:
//            let comparison = Date().adjust(.year, offset:1)
//            return compare(.isSameYear(as: comparison))
//        case .isLastYear:
//            let comparison = Date().adjust(.year, offset:-1)
//            return compare(.isSameYear(as: comparison))
//        case .isSameYear(let date):
//            return component(.year) == date.component(.year)
//        case .isInTheFuture:
//            return self.compare(.isLater(than: Date()))
//        case .isInThePast:
//            return self.compare(.isEarlier(than: Date()))
//        case .isEarlier(let date):
//            return (self as NSDate).earlierDate(date) == self
//        case .isLater(let date):
//            return (self as NSDate).laterDate(date) == self
//        case .isWeekday:
//            return !compare(.isWeekend)
//        case .isWeekend:
//            let range = Calendar.current.maximumRange(of: Calendar.Component.weekday)!
//            return (component(.weekday) == range.lowerBound || component(.weekday) == range.upperBound - range.lowerBound)
//        }
//
//    }
    
    
    // MARK: Adjust dates
    
    /// Creates a new date with adjusted components
    
    func adjust(_ component:DateComponentType, offset:Int) -> Date {
        var dateComp = DateComponents()
        switch component {
        case .second:
            dateComp.second = offset
        case .minute:
            dateComp.minute = offset
        case .hour:
            dateComp.hour = offset
        case .day:
            dateComp.day = offset
        case .weekday:
            dateComp.weekday = offset
        case .nthWeekday:
            dateComp.weekdayOrdinal = offset
        case .week:
            dateComp.weekOfYear = offset
        case .month:
            dateComp.month = offset
        case .year:
            dateComp.year = offset
        }
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }
    
    /// Return a new Date object with the new hour, minute and seconds values.
    func adjust(hour: Int?, minute: Int?, second: Int?, day: Int? = nil, month: Int? = nil) -> Date {
        var comp = Date.components(self)
        comp.month = month ?? comp.month
        comp.day = day ?? comp.day
        comp.hour = hour ?? comp.hour
        comp.minute = minute ?? comp.minute
        comp.second = second ?? comp.second
        return Calendar.current.date(from: comp)!
    }
    
    // MARK: Date for...
    
    func dateFor(_ type:DateForType, calendar:Calendar = Calendar.current) -> Date {
        switch type {
        case .startOfDay:
            return adjust(hour: 0, minute: 0, second: 0)
        case .endOfDay:
            return adjust(hour: 23, minute: 59, second: 59)
        case .startOfWeek:
            return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        case .endOfWeek:
            let offset = 7 - component(.weekday)!
            return adjust(.day, offset: offset)
        case .startOfMonth:
            return adjust(hour: 0, minute: 0, second: 0, day: 1)
        case .endOfMonth:
            let month = (component(.month) ?? 0) + 1
            return adjust(hour: 0, minute: 0, second: 0, day: 0, month: month)
        case .tomorrow:
            return adjust(.day, offset:1)
        case .yesterday:
            return adjust(.day, offset:-1)
        case .nearestMinute(let nearest):
            let minutes = (component(.minute)! + nearest/2) / nearest * nearest
            return adjust(hour: nil, minute: minutes, second: nil)
        case .nearestHour(let nearest):
            let hours = (component(.hour)! + nearest/2) / nearest * nearest
            return adjust(hour: hours, minute: 0, second: nil)
        }
    }
    
    // MARK: Time since...
    
    func since(_ date:Date, in component:DateComponentType) -> Int64 {
        switch component {
        case .second:
            return Int64(timeIntervalSince(date))
        case .minute:
            let interval = timeIntervalSince(date)
            return Int64(interval / Date.minuteInSeconds)
        case .hour:
            let interval = timeIntervalSince(date)
            return Int64(interval / Date.hourInSeconds)
        case .day:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .day, in: .era, for: self)
            let start = calendar.ordinality(of: .day, in: .era, for: date)
            return Int64(end! - start!)
        case .weekday:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .weekday, in: .era, for: self)
            let start = calendar.ordinality(of: .weekday, in: .era, for: date)
            return Int64(end! - start!)
        case .nthWeekday:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .weekdayOrdinal, in: .era, for: self)
            let start = calendar.ordinality(of: .weekdayOrdinal, in: .era, for: date)
            return Int64(end! - start!)
        case .week:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .weekOfYear, in: .era, for: self)
            let start = calendar.ordinality(of: .weekOfYear, in: .era, for: date)
            return Int64(end! - start!)
        case .month:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .month, in: .era, for: self)
            let start = calendar.ordinality(of: .month, in: .era, for: date)
            return Int64(end! - start!)
        case .year:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .year, in: .era, for: self)
            let start = calendar.ordinality(of: .year, in: .era, for: date)
            return Int64(end! - start!)
            
        }
    }
    
    
    // MARK: Extracting components
    
    func component(_ component:DateComponentType) -> Int? {
        let components = Date.components(self)
        switch component {
        case .second:
            return components.second
        case .minute:
            return components.minute
        case .hour:
            return components.hour
        case .day:
            return components.day
        case .weekday:
            return components.weekday
        case .nthWeekday:
            return components.weekdayOrdinal
        case .week:
            return components.weekOfYear
        case .month:
            return components.month
        case .year:
            return components.year
        }
    }
    
    func numberOfDaysInMonth() -> Int {
        let range = Calendar.current.range(of: Calendar.Component.day, in: Calendar.Component.month, for: self)!
        return range.upperBound - range.lowerBound
    }
    
    func firstDayOfWeek() -> Int {
        let distanceToStartOfWeek = Date.dayInSeconds * Double(self.component(.weekday)! - 1)
        let interval: TimeInterval = self.timeIntervalSinceReferenceDate - distanceToStartOfWeek
        return Date(timeIntervalSinceReferenceDate: interval).component(.day)!
    }
    
    func lastDayOfWeek() -> Int {
        let distanceToStartOfWeek = Date.dayInSeconds * Double(self.component(.weekday)! - 1)
        let distanceToEndOfWeek = Date.dayInSeconds * Double(7)
        let interval: TimeInterval = self.timeIntervalSinceReferenceDate - distanceToStartOfWeek + distanceToEndOfWeek
        return Date(timeIntervalSinceReferenceDate: interval).component(.day)!
    }
    
    
    // MARK: Internal Components
    
    internal static func componentFlags() -> Set<Calendar.Component> { return [Calendar.Component.year, Calendar.Component.month, Calendar.Component.day, Calendar.Component.weekOfYear, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second, Calendar.Component.weekday, Calendar.Component.weekdayOrdinal, Calendar.Component.weekOfYear] }
    internal static func components(_ fromDate: Date) -> DateComponents {
        return Calendar.current.dateComponents(Date.componentFlags(), from: fromDate)
    }
    
    
    // MARK: Static Cached Formatters
    
    /// A cached static array of DateFormatters so that thy are only created once.
    private static var cachedDateFormatters = [String: DateFormatter]()
    private static var cachedOrdinalNumberFormatter = NumberFormatter()
    
    /// Generates a cached formatter based on the specified format, timeZone and locale. Formatters are cached in a singleton array using hashkeys.
    private static func cachedFormatter(_ format:String = DateFormatType.standard.stringFormat, timeZone: Foundation.TimeZone = Foundation.TimeZone.current, locale: Locale = Locale.current) -> DateFormatter {
        let hashKey = "\(format.hashValue)\(timeZone.hashValue)\(locale.hashValue)"
        if Date.cachedDateFormatters[hashKey] == nil {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            formatter.timeZone = timeZone
            formatter.locale = locale
            formatter.isLenient = true
            Date.cachedDateFormatters[hashKey] = formatter
        }
        return Date.cachedDateFormatters[hashKey]!
    }
    
    /// Generates a cached formatter based on the provided date style, time style and relative date. Formatters are cached in a singleton array using hashkeys.
    private static func cachedFormatter(_ dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, doesRelativeDateFormatting: Bool, timeZone: Foundation.TimeZone = Foundation.NSTimeZone.local, locale: Locale = Locale.current) -> DateFormatter {
        let hashKey = "\(dateStyle.hashValue)\(timeStyle.hashValue)\(doesRelativeDateFormatting.hashValue)\(timeZone.hashValue)\(locale.hashValue)"
        if Date.cachedDateFormatters[hashKey] == nil {
            let formatter = DateFormatter()
            formatter.dateStyle = dateStyle
            formatter.timeStyle = timeStyle
            formatter.doesRelativeDateFormatting = doesRelativeDateFormatting
            formatter.timeZone = timeZone
            formatter.locale = locale
            formatter.isLenient = true
            Date.cachedDateFormatters[hashKey] = formatter
        }
        return Date.cachedDateFormatters[hashKey]!
    }
    
    // MARK: Intervals In Seconds
    internal static let minuteInSeconds:Double = 60
    internal static let hourInSeconds:Double = 3600
    internal static let dayInSeconds:Double = 86400
    internal static let weekInSeconds:Double = 604800
    internal static let yearInSeconds:Double = 31556926
    
}

// MARK: Enums used

/**
 The string format used for date string conversion.
 
 ````
 case isoYear: i.e. 1997
 case isoYearMonth: i.e. 1997-07
 case isoDate: i.e. 1997-07-16
 case isoDateTime: i.e. 1997-07-16T19:20+01:00
 case isoDateTimeSec: i.e. 1997-07-16T19:20:30+01:00
 case isoDateTimeMilliSec: i.e. 1997-07-16T19:20:30.45+01:00
 case dotNet: i.e. "/Date(1268123281843)/"
 case rss: i.e. "Fri, 09 Sep 2011 15:26:08 +0200"
 case altRSS: i.e. "09 Sep 2011 15:26:08 +0200"
 case httpHeader: i.e. "Tue, 15 Nov 1994 12:45:26 GMT"
 case standard: "EEE MMM dd HH:mm:ss Z yyyy"
 case custom(String): a custom date format string
 ````
 
 */
public enum DateFormatType {
    
    /// The ISO8601 formatted year "yyyy" i.e. 1997
    case isoYear
    
    /// The ISO8601 formatted year and month "yyyy-MM" i.e. 1997-07
    case isoYearMonth
    
    /// The ISO8601 formatted date "yyyy-MM-dd" i.e. 1997-07-16
    case isoDate
    
    /// The ISO8601 formatted date and time "yyyy-MM-dd'T'HH:mmZ" i.e. 1997-07-16T19:20+01:00
    case isoDateTime
    
    /// The ISO8601 formatted date, time and sec "yyyy-MM-dd'T'HH:mm:ssZ" i.e. 1997-07-16T19:20:30+01:00
    case isoDateTimeSec
    
    /// The ISO8601 formatted date, time and millisec "yyyy-MM-dd'T'HH:mm:ss.SSSZ" i.e. 1997-07-16T19:20:30.45+01:00
    case isoDateTimeMilliSec
    
    /// The dotNet formatted date "/Date(%d%d)/" i.e. "/Date(1268123281843)/"
    case dotNet
    
    /// The RSS formatted date "EEE, d MMM yyyy HH:mm:ss ZZZ" i.e. "Fri, 09 Sep 2011 15:26:08 +0200"
    case rss
    
    /// The Alternative RSS formatted date "d MMM yyyy HH:mm:ss ZZZ" i.e. "09 Sep 2011 15:26:08 +0200"
    case altRSS
    
    /// The http header formatted date "EEE, dd MM yyyy HH:mm:ss ZZZ" i.e. "Tue, 15 Nov 1994 12:45:26 GMT"
    case httpHeader
    
    /// A generic standard format date i.e. "EEE MMM dd HH:mm:ss Z yyyy"
    case standard
    
    /// A custom date format string
    case custom(String)
    
    var stringFormat:String {
        switch self {
        case .isoYear: return "yyyy"
        case .isoYearMonth: return "yyyy-MM"
        case .isoDate: return "yyyy-MM-dd"
        case .isoDateTime: return "yyyy-MM-dd'T'HH:mmZ"
        case .isoDateTimeSec: return "yyyy-MM-dd'T'HH:mm:ssZ"
        case .isoDateTimeMilliSec: return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case .dotNet: return "/Date(%d%f)/"
        case .rss: return "EEE, d MMM yyyy HH:mm:ss ZZZ"
        case .altRSS: return "d MMM yyyy HH:mm:ss ZZZ"
        case .httpHeader: return "EEE, dd MM yyyy HH:mm:ss ZZZ"
        case .standard: return "EEE MMM dd HH:mm:ss Z yyyy"
        case .custom(let customFormat): return customFormat
        }
    }
}

extension DateFormatType: Equatable {
    public static func ==(lhs: DateFormatType, rhs: DateFormatType) -> Bool {
        switch (lhs, rhs) {
        case (.custom(let lhsString), .custom(let rhsString)):
            return lhsString == rhsString
        default:
            return lhs == rhs
        }
    }
}

/// The time zone to be used for date conversion
public enum TimeZoneType {
    case local, `default`, utc, custom(Int)
    var timeZone:TimeZone {
        switch self {
        case .local: return NSTimeZone.local
        case .default: return NSTimeZone.default
        case .utc: return TimeZone(secondsFromGMT: 0)!
        case let .custom(gmt): return TimeZone(secondsFromGMT: gmt)!
        }
    }
}

// The string keys to modify the strings in relative format
public enum RelativeTimeStringType {
    case nowPast, nowFuture, secondsPast, secondsFuture, oneMinutePast, oneMinuteFuture, minutesPast, minutesFuture, oneHourPast, oneHourFuture, hoursPast, hoursFuture, oneDayPast, oneDayFuture, daysPast, daysFuture, oneWeekPast, oneWeekFuture, weeksPast, weeksFuture, oneMonthPast, oneMonthFuture, monthsPast, monthsFuture, oneYearPast, oneYearFuture, yearsPast, yearsFuture
}

// The type of comparison to do against today's date or with the suplied date.
public enum DateComparisonType {
    
    // Days
    
    /// Checks if date today.
    case isToday
    /// Checks if date is tomorrow.
    case isTomorrow
    /// Checks if date is yesterday.
    case isYesterday
    /// Compares date days
    case isSameDay(as:Date)
    
    // Weeks
    
    /// Checks if date is in this week.
    case isThisWeek
    /// Checks if date is in next week.
    case isNextWeek
    /// Checks if date is in last week.
    case isLastWeek
    /// Compares date weeks
    case isSameWeek(as:Date)
    
    // Months
    
    /// Checks if date is in this month.
    case isThisMonth
    /// Checks if date is in next month.
    case isNextMonth
    /// Checks if date is in last month.
    case isLastMonth
    /// Compares date months
    case isSameMonth(as:Date)
    
    // Years
    
    /// Checks if date is in this year.
    case isThisYear
    /// Checks if date is in next year.
    case isNextYear
    /// Checks if date is in last year.
    case isLastYear
    /// Compare date years
    case isSameYear(as:Date)
    
    // Relative Time
    
    /// Checks if it's a future date
    case isInTheFuture
    /// Checks if the date has passed
    case isInThePast
    /// Checks if earlier than date
    case isEarlier(than:Date)
    /// Checks if later than date
    case isLater(than:Date)
    /// Checks if it's a weekday
    case isWeekday
    /// Checks if it's a weekend
    case isWeekend
    
}

// The date components available to be retrieved or modifed
public enum DateComponentType {
    case second, minute, hour, day, weekday, nthWeekday, week, month, year
}


// The type of date that can be used for the dateFor function.
public enum DateForType {
    case startOfDay, endOfDay, startOfWeek, endOfWeek, startOfMonth, endOfMonth, tomorrow, yesterday, nearestMinute(minute:Int), nearestHour(hour:Int)
}

// Convenience types for date to string conversion
public enum DateStyleType {
    /// Short style: "2/27/17, 2:22 PM"
    case short
    /// Medium style: "Feb 27, 2017, 2:22:06 PM"
    case medium
    /// Long style: "February 27, 2017 at 2:22:06 PM EST"
    case long
    /// Full style: "Monday, February 27, 2017 at 2:22:06 PM Eastern Standard Time"
    case full
    /// Ordinal day: "27th"
    case ordinalDay
    /// Weekday: "Monday"
    case weekday
    /// Short week day: "Mon"
    case shortWeekday
    /// Very short weekday: "M"
    case veryShortWeekday
    /// Month: "February"
    case month
    /// Short month: "Feb"
    case shortMonth
    /// Very short month: "F"
    case veryShortMonth
}




extension UserDefaults {
    
    func save<T:Encodable>(customObject object: T, inKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            self.set(encoded, forKey: key)
        }
    }
    
    func retrieve<T:Decodable>(object type:T.Type, fromKey key: String) -> T? {
        if let data = self.data(forKey: key) {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(type, from: data) {
                return object
            }else {
                print("Couldnt decode object")
                return nil
            }
        }else {
            print("Couldnt find key")
            return nil
        }
    }
    
}




class CustomImagePageControl: UIPageControl {

  let activeImage:UIImage = UIImage(named: "SelectedPage")!
  let inactiveImage:UIImage = UIImage(named: "SelectedPage")!

  override func awakeFromNib() {
        super.awakeFromNib()

        self.pageIndicatorTintColor = UIColor.clear
        self.currentPageIndicatorTintColor = UIColor.clear
        self.clipsToBounds = false
   }

   func updateDots() {
        var i = 0
        for view in self.subviews {
            if let imageView = self.imageForSubview(view) {
                if i == self.currentPage {
                    imageView.image = self.activeImage
                } else {
                    imageView.image = self.inactiveImage
                }
                i = i + 1
            } else {
                var dotImage = self.inactiveImage
                if i == self.currentPage {
                    dotImage = self.activeImage
                }
                view.clipsToBounds = false
                view.addSubview(UIImageView(image:dotImage))
                i = i + 1
            }
        }
    }

    fileprivate func imageForSubview(_ view:UIView) -> UIImageView? {
        var dot:UIImageView?

        if let dotImageView = view as? UIImageView {
            dot = dotImageView
        } else {
            for foundView in view.subviews {
                if let imageView = foundView as? UIImageView {
                    dot = imageView
                    break
                }
            }
        }

        return dot
    }
}



extension UIViewController {
func transitionVc(vc: UIViewController, duration: CFTimeInterval, type: CATransitionSubtype) {
    let customVcTransition = vc
    let transition = CATransition()
    transition.duration = duration
    transition.type = CATransitionType.push
    transition.subtype = type
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    view.window!.layer.add(transition, forKey: kCATransition)
    present(customVcTransition, animated: false, completion: nil)
}}


//public enum Model : String {
//
////Simulator
//case simulator     = "simulator/sandbox",
//
////iPod
//iPod1              = "iPod 1",
//iPod2              = "iPod 2",
//iPod3              = "iPod 3",
//iPod4              = "iPod 4",
//iPod5              = "iPod 5",
//
////iPad
//iPad2              = "iPad 2",
//iPad3              = "iPad 3",
//iPad4              = "iPad 4",
//iPadAir            = "iPad Air ",
//iPadAir2           = "iPad Air 2",
//iPadAir3           = "iPad Air 3",
//iPad5              = "iPad 5", //iPad 2017
//iPad6              = "iPad 6", //iPad 2018
//iPad7              = "iPad 7", //iPad 2019
//
////iPad Mini
//iPadMini           = "iPad Mini",
//iPadMini2          = "iPad Mini 2",
//iPadMini3          = "iPad Mini 3",
//iPadMini4          = "iPad Mini 4",
//iPadMini5          = "iPad Mini 5",
//
////iPad Pro
//iPadPro9_7         = "iPad Pro 9.7\"",
//iPadPro10_5        = "iPad Pro 10.5\"",
//iPadPro11          = "iPad Pro 11\"",
//iPadPro12_9        = "iPad Pro 12.9\"",
//iPadPro2_12_9      = "iPad Pro 2 12.9\"",
//iPadPro3_12_9      = "iPad Pro 3 12.9\"",
//
////iPhone
//iPhone4            = "iPhone 4",
//iPhone4S           = "iPhone 4S",
//iPhone5            = "iPhone 5",
//iPhone5S           = "iPhone 5S",
//iPhone5C           = "iPhone 5C",
//iPhone6            = "iPhone 6",
//iPhone6Plus        = "iPhone 6 Plus",
//iPhone6S           = "iPhone 6S",
//iPhone6SPlus       = "iPhone 6S Plus",
//iPhoneSE           = "iPhone SE",
//iPhone7            = "iPhone 7",
//iPhone7Plus        = "iPhone 7 Plus",
//iPhone8            = "iPhone 8",
//iPhone8Plus        = "iPhone 8 Plus",
//iPhoneX            = "iPhone X",
//iPhoneXS           = "iPhone XS",
//iPhoneXSMax        = "iPhone XS Max",
//iPhoneXR           = "iPhone XR",
//iPhone11           = "iPhone 11",
//iPhone11Pro        = "iPhone 11 Pro",
//iPhone11ProMax     = "iPhone 11 Pro Max",
//iPhoneSE2          = "iPhone SE 2nd gen",
//
////Apple TV
//AppleTV            = "Apple TV",
//AppleTV_4K         = "Apple TV 4K",
//unrecognized       = "?unrecognized?"
//}

// #-#-#-#-#-#-#-#-#-#-#-#-#
// MARK: UIDevice extensions
// #-#-#-#-#-#-#-#-#-#-#-#-#

//public extension UIDevice {
//
//var type: Model {
//    var systemInfo = utsname()
//    uname(&systemInfo)
//    let modelCode = withUnsafePointer(to: &systemInfo.machine) {
//        $0.withMemoryRebound(to: CChar.self, capacity: 1) {
//            ptr in String.init(validatingUTF8: ptr)
//        }
//    }
//
//    let modelMap : [String: Model] = [
//
//        //Simulator
//        "i386"      : .simulator,
//        "x86_64"    : .simulator,
//
//        //iPod
//        "iPod1,1"   : .iPod1,
//        "iPod2,1"   : .iPod2,
//        "iPod3,1"   : .iPod3,
//        "iPod4,1"   : .iPod4,
//        "iPod5,1"   : .iPod5,
//
//        //iPad
//        "iPad2,1"   : .iPad2,
//        "iPad2,2"   : .iPad2,
//        "iPad2,3"   : .iPad2,
//        "iPad2,4"   : .iPad2,
//        "iPad3,1"   : .iPad3,
//        "iPad3,2"   : .iPad3,
//        "iPad3,3"   : .iPad3,
//        "iPad3,4"   : .iPad4,
//        "iPad3,5"   : .iPad4,
//        "iPad3,6"   : .iPad4,
//        "iPad6,11"  : .iPad5, //iPad 2017
//        "iPad6,12"  : .iPad5,
//        "iPad7,5"   : .iPad6, //iPad 2018
//        "iPad7,6"   : .iPad6,
//        "iPad7,11"  : .iPad7, //iPad 2019
//        "iPad7,12"  : .iPad7,
//
//        //iPad Mini
//        "iPad2,5"   : .iPadMini,
//        "iPad2,6"   : .iPadMini,
//        "iPad2,7"   : .iPadMini,
//        "iPad4,4"   : .iPadMini2,
//        "iPad4,5"   : .iPadMini2,
//        "iPad4,6"   : .iPadMini2,
//        "iPad4,7"   : .iPadMini3,
//        "iPad4,8"   : .iPadMini3,
//        "iPad4,9"   : .iPadMini3,
//        "iPad5,1"   : .iPadMini4,
//        "iPad5,2"   : .iPadMini4,
//        "iPad11,1"  : .iPadMini5,
//        "iPad11,2"  : .iPadMini5,
//
//        //iPad Pro
//        "iPad6,3"   : .iPadPro9_7,
//        "iPad6,4"   : .iPadPro9_7,
//        "iPad7,3"   : .iPadPro10_5,
//        "iPad7,4"   : .iPadPro10_5,
//        "iPad6,7"   : .iPadPro12_9,
//        "iPad6,8"   : .iPadPro12_9,
//        "iPad7,1"   : .iPadPro2_12_9,
//        "iPad7,2"   : .iPadPro2_12_9,
//        "iPad8,1"   : .iPadPro11,
//        "iPad8,2"   : .iPadPro11,
//        "iPad8,3"   : .iPadPro11,
//        "iPad8,4"   : .iPadPro11,
//        "iPad8,5"   : .iPadPro3_12_9,
//        "iPad8,6"   : .iPadPro3_12_9,
//        "iPad8,7"   : .iPadPro3_12_9,
//        "iPad8,8"   : .iPadPro3_12_9,
//
//        //iPad Air
//        "iPad4,1"   : .iPadAir,
//        "iPad4,2"   : .iPadAir,
//        "iPad4,3"   : .iPadAir,
//        "iPad5,3"   : .iPadAir2,
//        "iPad5,4"   : .iPadAir2,
//        "iPad11,3"  : .iPadAir3,
//        "iPad11,4"  : .iPadAir3,
//
//
//        //iPhone
//        "iPhone3,1" : .iPhone4,
//        "iPhone3,2" : .iPhone4,
//        "iPhone3,3" : .iPhone4,
//        "iPhone4,1" : .iPhone4S,
//        "iPhone5,1" : .iPhone5,
//        "iPhone5,2" : .iPhone5,
//        "iPhone5,3" : .iPhone5C,
//        "iPhone5,4" : .iPhone5C,
//        "iPhone6,1" : .iPhone5S,
//        "iPhone6,2" : .iPhone5S,
//        "iPhone7,1" : .iPhone6Plus,
//        "iPhone7,2" : .iPhone6,
//        "iPhone8,1" : .iPhone6S,
//        "iPhone8,2" : .iPhone6SPlus,
//        "iPhone8,4" : .iPhoneSE,
//        "iPhone9,1" : .iPhone7,
//        "iPhone9,3" : .iPhone7,
//        "iPhone9,2" : .iPhone7Plus,
//        "iPhone9,4" : .iPhone7Plus,
//        "iPhone10,1" : .iPhone8,
//        "iPhone10,4" : .iPhone8,
//        "iPhone10,2" : .iPhone8Plus,
//        "iPhone10,5" : .iPhone8Plus,
//        "iPhone10,3" : .iPhoneX,
//        "iPhone10,6" : .iPhoneX,
//        "iPhone11,2" : .iPhoneXS,
//        "iPhone11,4" : .iPhoneXSMax,
//        "iPhone11,6" : .iPhoneXSMax,
//        "iPhone11,8" : .iPhoneXR,
//        "iPhone12,1" : .iPhone11,
//        "iPhone12,3" : .iPhone11Pro,
//        "iPhone12,5" : .iPhone11ProMax,
//        "iPhone12,8" : .iPhoneSE2,
//
//        //Apple TV
//        "AppleTV5,3" : .AppleTV,
//        "AppleTV6,2" : .AppleTV_4K
//    ]
//
//    if let model = modelMap[String.init(validatingUTF8: modelCode!)!] {
//        if model == .simulator {
//            if let simModelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
//                if let simModel = modelMap[String.init(validatingUTF8: simModelCode)!] {
//                    return simModel
//                }
//            }
//        }
//        return model
//    }
//    return Model.unrecognized
//  }
//}
//



////

extension UIViewController {
func updateBackButton(){
    if self.navigationController != nil {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
    }
}}





@IBDesignable
open class VariableCornerRadiusView: UIView  {

    private func applyRadiusMaskFor() {
        let path = UIBezierPath()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        layer.mask = shape
    }

    @IBInspectable
    open var topLeftRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    open var topRightRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    open var bottomLeftRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    open var bottomRightRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        applyRadiusMaskFor()
    }
}

extension UIView{
    func roundCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {//(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath()
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
//    func circle() {
//        self.layer.cornerRadius = self.frame.width / 2
//        self.clipsToBounds = true
//    }
}


extension String {

    func strstr(needle: String, beforeNeedle: Bool = false) -> String? {
        guard let range = self.range(of: needle) else { return nil }

        if beforeNeedle {
            return self.substring(to: range.lowerBound)
        }

        return self.substring(from: range.upperBound)
    }

}


extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
        // return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

@IBDesignable class TextViewWithPlaceholder: UITextView {
    
    override var text: String! { // Ensures that the placeholder text is never returned as the field's text
        get {
            if showingPlaceholder {
                return "" // When showing the placeholder, there's no real text to return
            } else { return super.text }
        }
        set { super.text = newValue }
    }
    @IBInspectable var placeholderText: String = ""
    @IBInspectable var placeholderTextColor: UIColor = UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0) // Standard iOS placeholder color (#C7C7CD). See https://stackoverflow.com/questions/31057746/whats-the-default-color-for-placeholder-text-in-uitextfield
    private var showingPlaceholder: Bool = true // Keeps track of whether the field is currently showing a placeholder
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if text.isEmpty {
            showPlaceholderText() // Load up the placeholder text when first appearing, but not if coming back to a view where text was already entered
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        // If the current text is the placeholder, remove it
        if showingPlaceholder {
            text = nil
            textColor = nil // Put the text back to the default, unmodified color
            showingPlaceholder = false
        }
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        // If there's no text, put the placeholder back
        if text.isEmpty {
            showPlaceholderText()
        }
        return super.resignFirstResponder()
    }
    
    private func showPlaceholderText() {
        showingPlaceholder = true
        textColor = placeholderTextColor
        text = placeholderText
        
    }
    
}


import UIKit

final class ContentSizedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}






extension NSData {
    var toURL: URL? {
        (self as Data).toURL
    }
}

extension Data {
    var toURL: URL? {
        String(data: self as Data, encoding: .utf8)?.toURL
    }
}

extension String {
    var toURL: URL? {
        var url:URL? = nil
        url = URL(string: self)
        if url == nil {
            let encodeString =  self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if let encodeString = encodeString {
                url = URL(string: encodeString)
            }
        }
        return url
    }
    
}

extension Data {
    var toString: String? {
        String(data: self, encoding: .utf8)
    }
}

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension UIImage {
   static let profilePlaceholder = #imageLiteral(resourceName: "No_image")
    static let placeholder = #imageLiteral(resourceName: "Gallery icon")
    static let selectedIcon = #imageLiteral(resourceName: "Group 94")
    static let unSelectedIcon = #imageLiteral(resourceName: "Group 8")


}

extension Int {
 public   func dateFromMilliseconds() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self)/1000)
    }
}

extension Array
{
    func propertySorted<T: Comparable>(_ property: (Element) -> T?, descending: Bool) -> [Element]
    {
        sorted(by: {
            switch (property($0), property($1)) {
            case (.some, .some):
                return descending ? property($0)! > property($1)! : property($0)! < property($1)!
                
            case (.some, .none):
                return true
                
            case (.none, _):
                return false
            }
        })
    }
    
    mutating func propertySort<T: Comparable>(_ property: (Element) -> T?, descending: Bool)
    {
        sort(by: {
            switch (property($0), property($1)) {
            case (.some, .some):
                return descending ? property($0)! > property($1)! : property($0)! < property($1)!
                
            case (.some, .none):
                return true
                
            case (.none, _):
                return false
            }
        })
    }
}

extension Date {
    func timeAgo() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1
        return String(format: formatter.string(from: self, to: Date()) ?? "", locale: .current)
    }
}
    
extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return numberOfDays.day!
    }
    
    func numberOfDaysHoursBetween(_ from: Date, and to: Date) -> (Int,Int,Int) {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        
        let numberOfDays = dateComponents([.day,.hour,.minute], from: fromDate, to: toDate) // <3>
    
        return (numberOfDays.day!,numberOfDays.hour!,numberOfDays.minute!)
    }
    
}



extension Date {

    static func -(recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second

        return (month: month, day: day, hour: hour, minute: minute, second: second)
    }
    
    func computeNewDate(from fromDate: Date, to toDate: Date) -> (day:Int,hour:Int,minute:Int)  {
         let delta = toDate.timeIntervalSince(fromDate)
         let today = Date()
         if delta < 0 {
             return (0,0,0)
         } else {
             let newDate =  today.addingTimeInterval(delta)
             let calendar = Calendar.current
             let components = calendar.dateComponents([.day,.hour,.minute], from: newDate)
             return (components.day!,components.hour!,components.minute!)
         }
    }

}

extension String {

    func toDateNew(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{

        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: Locale.current.identifier)

        let date = formatter.date(from: self)

        return date

    }
}

#warning("Remove this code and use DateToolsSwift")

func timeAgoSinceDate(_ date:Date, numericDates:Bool = false) -> String {
    let calendar = NSCalendar.current
    let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
    let now = Date()
    let earliest = now < date ? now : date
    let latest = (earliest == now) ? date : now
    let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
    
    if (components.year! >= 2) {
        return "\(components.year!) \("years ago".localized)"
    } else if (components.year! >= 1){
        if (numericDates){
            return "1 year ago"
        } else {
            return "Last year"
        }
    } else if (components.month! >= 2) {
        return "\(components.month!) \("months ago".localized)"
    } else if (components.month! >= 1){
        if (numericDates){
            return "1 month ago"
        } else {
            return "Last month"
        }
    } else if (components.weekOfYear! >= 2) {
        return "\(components.weekOfYear!) weeks ago"
    } else if (components.weekOfYear! >= 1){
        if (numericDates){
            return "1 week ago"
        } else {
            return "Last week"
        }
    } else if (components.day! >= 2) {
        return "\(components.day!) days ago"
    } else if (components.day! >= 1){
        if (numericDates){
            return "1 day ago"
        } else {
            return "Yesterday"
        }
    } else if (components.hour! >= 2) {
        return "\(components.hour!) \("hours ago".localized)"
    } else if (components.hour! >= 1){
        if (numericDates){
            return "1 \("hours ago".localized)"
        } else {
            return "An hour ago".localized
        }
    } else if (components.minute! >= 2) {
        return "\(components.minute!) \("minutes ago".localized)"
    } else if (components.minute! >= 1){
        if (numericDates){
            return "1 minute ago"
        } else {
            return "A minute ago"
        }
    } else if (components.second! >= 3) {
        return "\(components.second!) \("seconds ago".localized)"
    } else {
        return "Just now".localized
    }
    
}


#warning("Remove this code and use DateToolsSwift")

func getLastMessageTimeInString(date: NSDate?) -> String {
    if date != nil {
        let order = NSCalendar.current.compare(Date(), to: (date! as Date), toGranularity: .day)
        switch order {
        case .orderedAscending, .orderedDescending:
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd"
            return formatter.string(from: date! as Date)
            
        case .orderedSame:
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            return formatter.string(from: date! as Date)
        }
    } else {
        return ""
    }

}

extension UITableView {
    
    //Variable-height UITableView tableHeaderView with autolayout
    func layoutTableHeaderView() {
        
        guard let headerView = self.tableHeaderView else { return }
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let headerWidth = headerView.bounds.size.width;
        let temporaryWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "[headerView(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: UInt(0)), metrics: ["width": headerWidth], views: ["headerView": headerView])
        
        headerView.addConstraints(temporaryWidthConstraints)
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let headerSize = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let height = headerSize.height
        var frame = headerView.frame
        
        frame.size.height = height
        headerView.frame = frame
        
        self.tableHeaderView = headerView
        
        headerView.removeConstraints(temporaryWidthConstraints)
        headerView.translatesAutoresizingMaskIntoConstraints = true
        
    }
    
    
    func layoutTableFooterView() {
        
        guard let footerView = self.tableFooterView else { return }
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        let footerWidth = footerView.bounds.size.width;
        let temporaryWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "[footerView(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: UInt(0)), metrics: ["width": footerWidth], views: ["footerView": footerView])
        
        footerView.addConstraints(temporaryWidthConstraints)
        
        footerView.setNeedsLayout()
        footerView.layoutIfNeeded()
        
        let footerSize = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let height = footerSize.height
        var frame = footerView.frame
        
        frame.size.height = height
        footerView.frame = frame
        
        self.tableFooterView = footerView
        
        footerView.removeConstraints(temporaryWidthConstraints)
        footerView.translatesAutoresizingMaskIntoConstraints = true
        
    }
    
}



extension String {
    var withoutSpecialCharacters: String {
        return self.components(separatedBy: CharacterSet.symbols).joined(separator: "")
    }
}


extension UIView {
    func isHiddenAnimated(value: Bool, duration: Double = 0.2) {
        UIView.animate(withDuration: duration) { [weak self] in self?.isHidden = value }
    }
}

extension UITableView {
    func scrollTableViewToBottom(animated: Bool) {
        guard let dataSource = dataSource else { return }

        var lastSectionWithAtLeasOneElements = (dataSource.numberOfSections?(in: self) ?? 1) - 1

        while dataSource.tableView(self, numberOfRowsInSection: lastSectionWithAtLeasOneElements) < 1 {
            lastSectionWithAtLeasOneElements -= 1
        }

        let lastRow = dataSource.tableView(self, numberOfRowsInSection: lastSectionWithAtLeasOneElements) - 1

        guard lastSectionWithAtLeasOneElements > -1 && lastRow > -1 else { return }

        let bottomIndex = IndexPath(item: lastRow, section: lastSectionWithAtLeasOneElements)
        scrollToRow(at: bottomIndex, at: .bottom, animated: animated)
    }
}


extension URL {
    func download(to directory: FileManager.SearchPathDirectory, using fileName: String? = nil, overwrite: Bool = false, completion: @escaping (URL?, Error?) -> Void) throws {
        let directory = try FileManager.default.url(for: directory, in: .userDomainMask, appropriateFor: nil, create: true)
        let destination: URL
        if let fileName = fileName {
            destination = directory
                .appendingPathComponent(fileName)
                .appendingPathExtension(self.pathExtension)
        } else {
            destination = directory
            .appendingPathComponent(lastPathComponent)
        }
        if !overwrite, FileManager.default.fileExists(atPath: destination.path) {
            completion(destination, nil)
            return
        }
        URLSession.shared.downloadTask(with: self) { location, _, error in
            guard let location = location else {
                completion(nil, error)
                return
            }
            do {
                if overwrite, FileManager.default.fileExists(atPath: destination.path) {
                    try FileManager.default.removeItem(at: destination)
                }
                try FileManager.default.moveItem(at: location, to: destination)
                completion(destination, nil)
            } catch {
                print(error)
            }
        }.resume()
    }
}


extension UIImage {
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()

        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}



extension UIImageView {
    static func fromGif(frame: CGRect, resourceName: String) -> UIImageView? {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "gif") else {
            print("Gif does not exist at that path")
            return nil
        }
        let url = URL(fileURLWithPath: path)
        guard let gifData = try? Data(contentsOf: url),
            let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return nil }
        var images = [UIImage]()
        let imageCount = CGImageSourceGetCount(source)
        for i in 0 ..< imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        let gifImageView = UIImageView(frame: frame)
        gifImageView.animationImages = images
        return gifImageView
    }
}

extension UIApplication {
    class var topViewController: UIViewController? { return getTopViewController() }
    private class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController { return getTopViewController(base: nav.visibleViewController) }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController { return getTopViewController(base: selected) }
        }
        if let presented = base?.presentedViewController { return getTopViewController(base: presented) }
        return base
    }

    private class func _share(_ data: [Any],
                              applicationActivities: [UIActivity]?,
                              setupViewControllerCompletion: ((UIActivityViewController) -> Void)?) {
        let activityViewController = UIActivityViewController(activityItems: data, applicationActivities: nil)
        setupViewControllerCompletion?(activityViewController)
        UIApplication.topViewController?.present(activityViewController, animated: true, completion: nil)
    }

    class func share(_ data: Any...,
                     applicationActivities: [UIActivity]? = nil,
                     setupViewControllerCompletion: ((UIActivityViewController) -> Void)? = nil) {
        _share(data, applicationActivities: applicationActivities, setupViewControllerCompletion: setupViewControllerCompletion)
    }
    class func share(_ data: [Any],
                     applicationActivities: [UIActivity]? = nil,
                     setupViewControllerCompletion: ((UIActivityViewController) -> Void)? = nil) {
        _share(data, applicationActivities: applicationActivities, setupViewControllerCompletion: setupViewControllerCompletion)
    }
}

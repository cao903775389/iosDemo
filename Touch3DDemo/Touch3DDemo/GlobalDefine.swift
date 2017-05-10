//
//  GlobalDefine.swift
//  Nebula
//
//  Created by bluce on 15/9/2.
//  Copyright (c) 2015年 CBSi. All rights reserved.
//

import UIKit
import CoreData
import AdSupport
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}



///是否全屏
var KIsFullScreen = false
//返回按钮尺寸
let KMENULEFTICONWIDTH:CGFloat = 45

let KLaunchVideoCacheKey = "KLaunchVideoCacheKey" // 启动广告视频
//检查前后摄像头
let KCameraAvailable = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)

//检查声音支持
let KAudioAvailable = AVAudioSession.sharedInstance().isInputAvailable


// 网络
//let KReachability = AFNetworkReachabilityManager.sharedManager().networkReachabilityStatus.rawValue
var KNoNetwork:Bool = Reachability.forInternetConnection().currentReachabilityStatus().rawValue == 0 ? true : false
let KWhatNetwork = Reachability.forInternetConnection().currentReachabilityStatus().rawValue
//缓存用户信息
var KUserDefaults:UserDefaults = UserDefaults.standard
let log = XCGLogger.default
var bundle:Bundle?
func KLocalizedStringForKey(_ key:String)->String?{
    return bundle?.localizedString(forKey: key, value: nil, table: "Beauty-localize")
}
// 通过高值判断设备
let K_IS_IPHONE_4 = UIScreen.main.currentMode?.size.height == 960.0 ? true : false
let K_IS_IPHONE_5 = UIScreen.main.currentMode?.size.height == 1136.0 ? true : false
let K_IS_IPHONE_6 = UIScreen.main.currentMode?.size.height == 1334.0 ? true : false
let K_IS_IPHONE_6P = UIScreen.main.currentMode?.size.height == 2208.0 ? true : false
let K_IS_GREATER_47_INCH_SCREEN = UIScreen.main.currentMode?.size.height >= 1334.0 ? true : false
let K_IS_GREATER_4_INCH_SCREEN = UIScreen.main.currentMode?.size.height >= 1136.0 ? true : false
    

func KLocalizedStringForKey(_ key:String,defaultString string:String)->String{
    if let str = bundle?.localizedString(forKey: key, value: nil, table: "Beauty-localize"){
        return str
    }else{
        return string
    }
}

func KGetResourcePath(_ imageName:String,ofType:String = "png") -> String?{
    return Bundle.main.path(forResource: imageName, ofType:ofType)
}

/**-----device Info-------*/
func KDeviceIDFA() -> String? {
    if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
        let IDFA = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        return IDFA
    } else {
        return nil
    }
}

//延迟执行
func KDelay(seconds:Double, completion:()->()) {
    let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
    
    DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.low).asyncAfter(deadline: popTime) {
        completion()
    }
}


//UIDevice.currentDevice().name.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
let KDeviceName = UIDevice.current.name.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)

let KDeviceIDFV = UIDevice.current.identifierForVendor?.uuidString

let KiOSVersion = UIDevice.current.systemVersion

///内部版本号
func KCFBundleVersion() -> String?{
    return KMainBundleInfoWithKey("CFBundleVersion")
}

///外部版本号
func KCFBundleShortVersionString() -> String?{
    return KMainBundleInfoWithKey("CFBundleShortVersionString")
}

///获取plist信息
func KMainBundleInfoWithKey(_ key:String)-> String?{
    if let infoDictionary = Bundle.main.infoDictionary {
        if let CFBundleShortVersionString = infoDictionary[key] as? String {
            return CFBundleShortVersionString
        }
    }
    return nil
}

/**-------Statusbar Style-----*/
/// 向上按钮尺寸
let KTOPICONWIDTH:CGFloat = 54

var KStatusBarBackgroundColor = UIStatusBarStyle.default
var KStatusBarIsVisible = true

var KOpenWithSafari:Bool =  false

// 默认动画时长
let kDefaultAnimationDuration = 0.3

var KTabbarViewController:BaseTabbarController?

let KSystem_Version:Double = (UIDevice.current.systemVersion as NSString).doubleValue

let KStatusBarHeight = UIApplication.shared.statusBarFrame.height
let KIPHONE5 = equalMainScreenSize(640,_height: 1136)
let KIPHONE4 = equalMainScreenSize(640,_height: 960)
let KMainScreenSize = UIScreen.main.bounds.size
let KMainScreen = UIScreen.main.bounds
let KMainScreenWidth = UIScreen.main.bounds.size.width
let KMainScreenHeight = UIScreen.main.bounds.size.height

let KMainApplicationFrame = UIScreen.main.applicationFrame.size
let KKEY_WINDOW = UIApplication.shared.keyWindow
let KISRETINA:Bool = UIScreen.main.scale>1.0 ? true : false

func KAdaptedHeight(_ x:CGFloat)->CGFloat{
    if TARGET_OS_IPHONE==1{
        //以375为基准伸展高度
        return x * KMainScreenSize.width/375
    }
}

func KAdaptedWidth(_ y:CGFloat)->CGFloat{
    if TARGET_OS_IPHONE==1{
        //以667为基准伸展高度
        return y * KMainScreenSize.height/667
    }
}

//MARK: - 定义全局的NSNotificationCenter名称
///首页广告通知
let KHomeViewControllerUICallbackNotify = "HomeViewControllerUICallbackNotify"
///缓存KEY
let KLaunchImageCacheKey = "KLaunchImageCacheKey" //启动广告图

// 记录token
let KDeviceToken = "KDeviceToken"



///记录广告是否关闭了，是就不再请求,app重开则这数据重置
var KADCloseHistory = Dictionary<Int,Bool>()

///用户头像尺寸（用于图片上传之前裁剪)
let KUserAvatarSize = CGSize(width: 99, height: 99)

/****导航标题*****/
let KNavBarTitleFont = KFontName.STHeitiSCMedium

/****标题栏*****/
let KTitleBarFont = KFontName.STHeitiSCMedium

/****搜索框*****/
let  KSearchBarFont = KFontName.Helvetica

/******字母栏******/
let KLetterBarFont = KFontName.STHeitiSCMedium

/******按钮橙色*******/
let KButtonOrangeFont = KFontName.STHeitiSCMedium

/******时间*******/
let KTimeFont = KFontName.Helvetica

/******消息提示*******/
let KImpresaOrMessageTipFont = KFontName.Helvetica

/********** 字体大小 *************/
enum KFontSize:CGFloat{
    case eleven = 11
    case twelve = 12
    case fourteen = 14
    case sixteen = 16
    case eighteen = 18
    case titleFont = 17
}


let labelHeight = 45.0
let CellBigImageHeight = 175.0
let constCellHeight = CellBigImageHeight + labelHeight + 35.0

/******** 字体名称 *********/
enum KFontName:String{
    case STHeitiSCMedium = "STHeitiSC-Medium"
    case STHeitiSCLight = "STHeitiSC-Light"
    case Helvetica = "Helvetica"
    case HelveticaBold = "Helvetica-Bold"
    case THeitiSCMedium = "Thonburi-Light"
    case AppleSDGothicNeoLight = "AppleSDGothicNeo-Light"
    case AppleSDGothicNeoUltraLight = "AppleSDGothicNeo-UltraLight"
}
//MARK: - 字体大小
let KFontSystemSize8  = UIFont.systemFont(ofSize: 8)
let KFontSystemSize9  = UIFont.systemFont(ofSize: 9)
let KFontSystemSize10 = UIFont.systemFont(ofSize: 10)
let KFontSystemSize11 = UIFont.systemFont(ofSize: 11)
let KFontSystemSize12 = UIFont.systemFont(ofSize: 12)
let KFontSystemSize13 = UIFont.systemFont(ofSize: 13)
let KFontSystemSize14 = UIFont.systemFont(ofSize: 14)
let KFontSystemSize15 = UIFont.systemFont(ofSize: 15)
let KFontSystemSize16 = UIFont.systemFont(ofSize: 16)
let KFontSystemSize17 = UIFont.systemFont(ofSize: 17)
let KFontSystemSize18 = UIFont.systemFont(ofSize: 18)
let KFontSystemSize19 = UIFont.systemFont(ofSize: 19)
let KFontSystemSize20 = UIFont.systemFont(ofSize: 20)
let KFontSystemSize21 = UIFont.systemFont(ofSize: 21)
let KFontSystemSize22 = UIFont.systemFont(ofSize: 22)
let KFontBold_M19 = K_IS_GREATER_47_INCH_SCREEN ? KFontWithSTHeitiSC(19) : UIFont.boldSystemFont(ofSize: 19)

func kFontSTHeitiSCLight(_ fontSize:CGFloat)->UIFont{
    return UIFont(name: KFontName.STHeitiSCLight.rawValue, size: fontSize)!
}
func KFontWithSTHeitiSC(_ fontSize:CGFloat)->UIFont{
    return UIFont(name: KFontName.STHeitiSCMedium.rawValue, size: fontSize)!
}

func KFontTHeitiSCMedium(_ fontSize:CGFloat)->UIFont{
    return UIFont(name:KFontName.THeitiSCMedium.rawValue, size:fontSize)!
}
func AppleSDGothicNeoLight(_ fontSize:CGFloat)->UIFont{
    return UIFont(name:KFontName.AppleSDGothicNeoLight.rawValue, size:fontSize)!
}
func AppleSDGothicNeoUltraLight(_ fontSize:CGFloat)->UIFont{
    return UIFont(name:KFontName.AppleSDGothicNeoUltraLight.rawValue, size:fontSize)!
}
//func KFontHelvetica = "AppleSDGothicNeo-Light"
//func KFontHelveticaBold = "国籍ol12OLAppleSDGothicNeo-UltraLight"

func KGetFont(_ name:KFontName,fontSize:KFontSize)->UIFont{
    return UIFont(name:name.rawValue, size: fontSize.rawValue)!
}

func KFontWithSTHeitiSC(_ fontSize:KFontSize)->UIFont{
    return UIFont(name: KFontName.STHeitiSCMedium.rawValue, size: fontSize.rawValue)!
}

func KFontWithHelvetica(_ fontSize:KFontSize)->UIFont{
    return UIFont(name: KFontName.Helvetica.rawValue, size: fontSize.rawValue)!
}

func KFontWithHelveticaBold(_ fontSize:KFontSize)->UIFont{
    return UIFont(name: KFontName.HelveticaBold.rawValue, size: fontSize.rawValue)!
}

func RGB(_ r:CGFloat,g:CGFloat,b:CGFloat) ->UIColor{
    return RGBA(r, g: g, b: b,a: 1.0)
}

func RGBA(_ rgb:CGFloat) ->UIColor{
    return RGB(rgb, g: rgb, b: rgb)
}

func RGBA(_ r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) ->UIColor{
    return UIColor(red:r/255, green: g/255, blue:b/255, alpha:a)
}

//MARK: - 字体颜色
/**时间评论文字颜色**/
let jwColoer_time_text_color = UIColor(rgba: "#9a9a9a")
let jwColoer_CellTitle_text_color = UIColor(rgba: "#323232")
let jwColoer_CellUserName_text_color = UIColor(rgba: "#909090")
// 统一封装颜色
let Hcolor_pink_text_color = UIColor(rgba: "#FD4E4E")
let Hcolor_606060_color = UIColor(rgba: "#606060")
let Hcolor_F2F2F2_color = UIColor(rgba: "#F2F2F2")
let Hcolor_NavgationBar_color = UIColor(rgba: "#FFFFFF")
let Hcolor_999999_color = UIColor(rgba: "#999999")
let Hcolor_CCCCCC_color = UIColor(rgba: "#CCCCCC")
let Hcolor_666666_color = UIColor(rgba: "#666666")
//MARK: - 统一APPKey配置
/**友盟统计*/
let KUMENG_APPKEY = "56c6b748e0f55a51c3001bbc"

/**ShareSDKAPPKey*/
let shareSDKAPPKey = "f8120d44a3ed"
/**WeiXinAPPKay*/
let weiXinAPPID = "wxfddd244b34cdf044"
let weiXinSecretKey = "f75b88fa19f5674507ea0ed508842cc5"
/**WeiBoAPPKey*/
let sinaWeiBoAPPKey = "196066042"
let sinaWeiBoSecretKey = "9a380d51f5177bee71c3aad59ce8e528"
/**TencentQQAPPKay*/
//echo 'ibase=10;obase=16;101236492'|bc
let QQAPPID = "101004586"
let QQAPPKey = "45b6467278af64029908b11867e56bb4"

//回调URL
let rediretURL = "http://www.onlylady.com"

//MARK: - 网络错误提示
let networkErrorMessage = "网络错误"
let networkErrorLongMessage = "当前网络不可用，请检查你的网络设置"
let serverNetWorkErrorMessage = "服务器异常"
let appErrorMessage = "APP异常"

//MARK: - 1.0.0版本
// 标记app是否第一次登录
let KBEAUTY_IS_FIRST_LAUNCH = "KBEAUTY_IS_FIRST_LAUNCH"
// 标记是否第一次打开详情页
let KBEAUTY_IS_FIRST_OPEN_DETAILS = "KBEAUTY_IS_FIRST_OPEN_DETAILS"
// app提示更新
let KBEAUTY_VERSION_UPDATE = "KBEAUTY_VERSION_UPDATE"
// 更新通知
let KNotifWithVersionUpdate = "KNotifWithVersionUpdate"
// 记录app 开启次数
let KBEAUTYAPP_OPEN_TIMES = "KBEAUTYAPP_OPEN_TIMES"

// 反馈未登录本地缓存
let KFEEDBACK_SAVE_LIST = "KFEEDBACK_SAVE_LIST"
//MARK: -

func equalMainScreenSize(_ _width:Int,_height:Int)->Bool{
    var isIphone5:Bool
    let _size:CGSize?=UIScreen.main.currentMode?.size
    if(_size != nil){
        isIphone5 = CGSize(width:_width, height: _height).equalTo(_size!)
    }
    else{
        isIphone5 = false
    }
    return isIphone5
}


//// GCD库,封装常用操作
struct KGCD{
    static func async_in_worker(_ closure: GCDClosure) {
        gcd.async(.default, closure: closure)
    }
    
    static func async_in_main(_ closure: GCDClosure) {
        gcd.async(.main, closure: closure)
    }
}

//缓存图片文件夹类型
enum ImageCacheType:String{
    #if DEBUG
    case ImageCache = "ImageCache"
    case LaunchImageAD = "LaunchImageAD"
    case LaunchImageADVideo = "LaunchImageADVideo"
    case BannerAD = "BannerAD"
    case SmallAD = "SmallAD"
    #else
    case ImageCache = ".ImageCache"
    case LaunchImageAD = ".LaunchImageAD"
    case LaunchImageADVideo = ".LaunchImageADVideo"
    case BannerAD = ".BannerAD"
    case SmallAD = ".SmallAD"
    #endif
}

class GlobalDefine:NSObject{
    class func changeStatusBarOrientation(_ orientationKey:UIDeviceOrientation)-> Bool{
        if let _ = KTabbarViewController?.currNavi?.view{
            if !orientationKey.isPortrait{
                KIsFullScreen = true
                GlobalDefine.forceRotateDeviceToOrientation(.landscapeLeft, fromOrientation:UIDevice.current.orientation)
            }else{
                GlobalDefine.forceRotateDeviceToOrientation(.portrait, fromOrientation:.landscapeLeft)
                KIsFullScreen = false
            }
            return true
        }
        KIsFullScreen = false
        return false
    }
    
    class func forceRotateDeviceToOrientation(_ toRotation: UIDeviceOrientation, fromOrientation: UIDeviceOrientation) {
        let orientationKey = "orientation"
        let actualDeviceOrientation = UIDevice.current.orientation
        var changedDeviceOrientation = false
        
        KGCD.async_in_main{
            if actualDeviceOrientation != toRotation {
                UIDevice.current.setValue(toRotation.rawValue, forKey: orientationKey)
            } else {
                UIDevice.current.setValue(fromOrientation.rawValue, forKey: orientationKey)
                changedDeviceOrientation = true
            }
            UIViewController.attemptRotationToDeviceOrientation()
            if changedDeviceOrientation {
                UIDevice.current.setValue(actualDeviceOrientation.rawValue, forKey: orientationKey)
            }
        }
    }

    //TODO: buildUniqueSequenceID未实现
    //    class func buildUniqueSequenceID()->String{
    //        var uuidObj = CFUUIDCreate(nil)
    //        var uniqueSequenceID = CFUUIDCreateString(nil, uuidObj)
    //        return uniqueSequenceID
    //    }
    
//    class func async_in_worker(closure: GCDClosure) {
//        gcd.async(.Default, closure: closure)
//    }
//    
//    class func async_in_main(closure: GCDClosure) {
//        gcd.async(.Main, closure: closure)
//    }
    
    class func isTextNullSupportTrim(_ string:String)->Bool{
        let len = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).lengthOfBytes(using: String.Encoding.utf8)
        return ( 0 == string.lengthOfBytes(using: String.Encoding.utf8) || 0 == len)
    }
    
    //定义提供给objectc调用的swift方法
    class func bundleLocalizedStringForKey(_ key:String)->String?{
        return KLocalizedStringForKey(key)
    }
    
    class func isIphone() -> Bool {
        let iPhone = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
        return iPhone
    }
    
    class func isIpad() -> Bool {
        let iPad = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
        return iPad
    }
    
    class func isLandscape() -> Bool {
        let orientation = UIDevice.current.orientation
        let landscape = orientation == UIDeviceOrientation.landscapeLeft || orientation == UIDeviceOrientation.landscapeRight
        return landscape
    }
    
    class func isPortrait() -> Bool {
        let orientation = UIDevice.current.orientation
        let portrait = orientation == UIDeviceOrientation.portrait
        return portrait
    }
    
    //将UIImage缩放到指定大小尺寸
    class func scaleToSize(_ img:UIImage,size:CGSize) ->UIImage{
        // 创建一个bitmap的context
        // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContext(size)
        // 绘制改变大小的图片
        img.draw(in: CGRect(x: 0,y: 0,width: size.width, height: size.height))
        //从当前context中创建一个改变大小后的图片
        let scaledImage:UIImage=UIGraphicsGetImageFromCurrentImageContext()!
        // 使当前的context出堆栈
        UIGraphicsEndImageContext()
        return scaledImage
    }
    
    //等比例压缩
    class func imageCompressForSize(_ img:UIImage,targetSize size:CGSize) ->UIImage?{
        let newImage:UIImage?
        let imageSize = img.size
        let width  = imageSize.width
        let height  = imageSize.height
        let targetWidth = size.width
        let targetHeight = size.height
        var scaleFactor : CGFloat = 0.0
        var scaledWidth = targetWidth
        var scaledHeight = targetHeight
        var thumbnailPoint = CGPoint(x: 0.0, y: 0.0)
        if(imageSize.equalTo(size) == false){
            let widthFactor = targetWidth / width
            let heightFactor = targetHeight / height
            if(widthFactor > heightFactor){
                scaleFactor = widthFactor
            }
            else{
                scaleFactor = heightFactor
            }
            scaledWidth = width * scaleFactor
            scaledHeight = height * scaleFactor
            if(widthFactor > heightFactor){
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5
            }else if(widthFactor < heightFactor){
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5
            }
        }
        
        UIGraphicsBeginImageContext(size);
        
        var thumbnailRect = CGRect.zero
        thumbnailRect.origin = thumbnailPoint
        thumbnailRect.size.width = scaledWidth
        thumbnailRect.size.height = scaledHeight
        img.draw(in: thumbnailRect)
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        if(newImage == nil){
            log.error("scale image fail")
        }
        UIGraphicsEndImageContext()
        return newImage
    }
    
    //根据宽等比压缩
    class func imageCompressForWidth(_ img:UIImage,targetSize defineWidth:CGFloat) ->UIImage?{
        var newImage:UIImage?
        let imageSize = img.size
        let width = imageSize.width
        let height = imageSize.height
        let targetWidth = defineWidth
        let targetHeight = height / (width / targetWidth)
        let size = CGSize(width: targetWidth, height: targetHeight)
        var scaleFactor:CGFloat = 0.0
        var scaledWidth = targetWidth
        var scaledHeight = targetHeight
        var thumbnailPoint = CGPoint(x: 0.0, y: 0.0)
        if(imageSize.equalTo(size) == false){
            let widthFactor = targetWidth / width
            let heightFactor = targetHeight / height
            if(widthFactor > heightFactor){
                scaleFactor = widthFactor
            }
            else{
                scaleFactor = heightFactor
            }
            scaledWidth = width * scaleFactor
            scaledHeight = height * scaleFactor
            if(widthFactor > heightFactor){
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5
            }else if(widthFactor < heightFactor){
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5
            }
        }
        UIGraphicsBeginImageContext(size)
        var thumbnailRect = CGRect.zero
        thumbnailRect.origin = thumbnailPoint
        thumbnailRect.size.width = scaledWidth
        thumbnailRect.size.height = scaledHeight
        img.draw(in: thumbnailRect)
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        if(newImage == nil){
            log.error("scale image fail")
        }
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    class func getSize(_ contentString:String, font:UIFont, width:CGFloat) -> CGSize {
        let attributedText = NSAttributedString(string: contentString, attributes: [NSFontAttributeName: font])
        
        return attributedText.boundingRect(with: CGSize(width: width,height: CGFloat.max), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil).size;
        //        var a : NSString =  "aaa"
        //        var textSize = a.boundingRectWithSize(CGSizeMake(200,CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: str.textSizeWithFont(KCardTitleTextSize)], context: nil).size
    }
    
    
    class func readFile(_ filePath: String) -> Data? {
        let fileHandler : FileHandle = FileHandle(forReadingAtPath: filePath)!
        let fileData : Data? = fileHandler.readDataToEndOfFile()
        fileHandler.closeFile()
        return fileData
    }
    
    //获取图片文件夹路径
    class func getImageCachePath(_ type:ImageCacheType) -> String {
        var paths =  NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let path = paths[0] + "/\(type.rawValue)"
        return path
    }
    
    //删除图片文件
    class func imageCacheDelete(_ fileName:String,type:ImageCacheType){
        let directoryPath = GlobalDefine.getImageCachePath(type)
        let fileFullPath = directoryPath.stringByAppendingFormat("/%@",fileName)
        let fileManager = FileManager.default
        if(!fileManager.fileExists(atPath: fileFullPath)){
            do {
                try fileManager.removeItem(atPath: directoryPath)
            } catch _ {
            }
        }
    }
    
    //判断图片是否存在
    class func imageCacheIsExist(_ fileName:String,type:ImageCacheType)->Bool{
        let directoryPath = GlobalDefine.getImageCachePath(type)
        let fileFullPath = directoryPath.stringByAppendingFormat("/%@",fileName)
        let fileManager = FileManager.default
        if(!fileManager.fileExists(atPath: fileFullPath)){
            var isOk = ObjCBool(false)
            if(!fileManager.fileExists(atPath: directoryPath, isDirectory: &isOk)){
                do {
                    try fileManager.createDirectory(atPath: directoryPath, withIntermediateDirectories: true, attributes: nil)
                } catch _ {
                }
            }
            return false
        }
        return true
    }
    
//    class func logError(_ msg:String){
//        log.error(msg)
//    }
//    
//    class func valueForKeyPathToString(_ obj:AnyObject,key:String)->String{
//        if key.components(separatedBy: ".").count > 1{
//            if let v: AnyObject = obj.value(forKeyPath: key){
//                return JSON(v).stringValue
//            }
//        }
//        return JSON(obj)[key].stringValue
//    }
//    
//    class func valueForKeyPathToInt(_ obj:AnyObject,key:String)->Int{
//        if key.components(separatedBy: ".").count > 1{
//            if let v: AnyObject = obj.value(forKeyPath: key){
//                return JSON(v).intValue
//            }
//        }
//        return JSON(obj)[key].intValue
//    }
//    
//    class func valueForKeyPathToDouble(_ obj:AnyObject,key:String)->Double{
//        if key.components(separatedBy: ".").count > 1{
//            if let v: AnyObject = obj.value(forKeyPath: key){
//                return JSON(v).doubleValue
//            }
//        }
//        return JSON(obj)[key].doubleValue
//    }
//    
//    class func valueForKeyPathToFloat(_ obj:AnyObject,key:String)->Float{
//        if key.components(separatedBy: ".").count > 1{
//            if let v: AnyObject = obj.value(forKeyPath: key){
//                return JSON(v).floatValue
//            }
//        }
//        return JSON(obj)[key].floatValue
//    }
//    
//    class func valueForKeyPathToBool(_ obj:AnyObject,key:String)->Bool{
//        if key.components(separatedBy: ".").count > 1{
//            if let v: AnyObject = obj.value(forKeyPath: key){
//                return JSON(v).boolValue
//            }
//        }
//        return JSON(obj)[key].boolValue
//    }
//    
//    class func valueForKeyPathToBool(_ obj:AnyObject,key:String,equalStr:String)->Bool{
//        return GlobalDefine.valueForKeyPathToString(obj, key: key) == equalStr
//    }
//    
//    //MARK: - 检查推送状态
//    class func isSystemVersioniOS8()->Bool{
//        let device = UIDevice.current
//        let sv = (device.systemVersion as NSString).floatValue
//        if sv >= 8.0 {
//            return true
//        }
//        return false
//        
//    }
//    
//    class func isAllowedNotification()->Bool{
//        if isSystemVersioniOS8() {
//            if #available(iOS 8.0, *) {
//                let setting:UIUserNotificationSettings = UIApplication.shared.currentUserNotificationSettings!
//                if UIUserNotificationType() != setting.types {
//                    return true
//                }
//            }
//        } else {
//            let type:UIRemoteNotificationType = UIApplication.shared.enabledRemoteNotificationTypes()
//            if UIRemoteNotificationType() != type {
//                return true
//            }
//        }
//        return false
//    }
//    
//    //MARK: - 预约列表读取
//   class func initPredictionPaths()->String {
//        let paths:NSArray = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//        let path = paths.object(at: 0)
//        let fileName = path.appendingPathComponent("yuyue.plist")
//        return fileName
//    }
//    // 读取
//    class func loadPredictionItemInfo(_ uid:String)->Bool{
//        let fileName = GlobalDefine.initPredictionPaths()
//        let dict = NSMutableDictionary(contentsOfFile: fileName)
//        if dict == nil {
//            let fm = FileManager.default
//            fm.createFile(atPath: fileName, contents: nil, attributes: nil)
//        }
//        if let b = dict?.object(forKey: uid) as? Bool{
//            if b  == true {
//                return true
//            } else {
//                return false
//            }
//        } else {
//            return false
//        }
//    }
//    // MARK: - 绘制虚线
//    /// 绘制线条
//    /// - parametar lineWidth: 线条粗细
//    /// - parametar colorStr: 线条颜色（#F2F2F2）
//    /// - parametar startPoint: 绘制起点坐标
//    /// - parametar stopPoint: 绘制终点坐标
//    /// - parametar lineDashPattern: 虚线的长度与间隔
//    /// - returns: CAShapeLayer
//    
//    class func drawLine(_ lineWidth:CGFloat = 1.0, colorStr:String = "#F2F2F2", startPoint:CGPoint = CGPoint(x: 0, y: 0), stopPoint:CGPoint = CGPoint(x: KMainScreen.width, y: 0), lineDashPattern:[NSNumber] = [3, 1.5]) -> CAShapeLayer{
//        let line = CAShapeLayer()
//        // 绘制路径
//        let path:CGMutablePathRef = CGMutablePath()
//        // 线条粗细
//        line.lineWidth = lineWidth
//        // 线条颜色
//        line.strokeColor = UIColor(rgba: colorStr).cgColor
//        // 线条填充颜色（暂时无用）
//        line.fillColor = UIColor.clear.cgColor
//        // 线条绘制起点
//        CGPathMoveToPoint(path, nil, startPoint.x, startPoint.y)
//        // 线条绘制终点
//        CGPathAddLineToPoint(path, nil, stopPoint.x, stopPoint.y)
//        line.path = path
//        //        line.lineDashPhase = 1.5
//        // 虚线时虚线的长度与虚线的间隔（前面的是长度，后面的是间隔）
//        // 如果在一条虚线中需要不同长度可以继续向后添加
//        line.lineDashPattern = lineDashPattern
//        return line
//    }
//    
//    // 正规表达式判断String是否是国内手机号码(含177，147，170)
//    class func isTelNumber(_ num:String)->Bool{
//        // 手机号码
//        let mobile = "^(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$"
//       
//        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
//        
//        if (regextestmobile.evaluate(with: num) == true){
//            return true
//        }else{
//            return false
//        }  
//    }
//    // 国际号码校验
//    class func isMobileGuoJi(_ num:String)->Bool{
//    
//        let mobile = "^\\s*\\+?\\s*(\\(\\s*\\d+\\s*\\)|\\d+)(\\s*-?\\s*(\\(\\s*\\d+\\s*\\)|\\s*\\d+\\s*))*\\s*$";
//    
//        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
//        
//        if (regextestmobile.evaluate(with: num) == true){
//            return true
//        }else{
//            return false
//        }
//    }
//    
//    /// 判断星期
//    class func getWeekdayWithTimeStemp(_ time:String) -> String {
//        var flagStr = ""
//        let timeStemp = TimeInterval(time)
//        let timeDate = Date(timeIntervalSince1970: timeStemp!)
//        // 当前日期
//        let currentDate = GlobalDefine.getIntegerFromDate(Date())
//        // 目标日期
//        let targetDate = GlobalDefine.getIntegerFromDate(timeDate)
//        // 时间差
//        let timeDifference = targetDate - currentDate
//        if timeDifference == -1 {
//            flagStr = "/昨天"
//        }else{
//            let clendar = Calendar(identifier: NSChineseCalendar)
//            if #available(iOS 8.0, *) {
//                let components = (clendar as NSCalendar?)?.component(NSCalendar.Unit.weekday, from: timeDate)
//                switch components! {
//                case 1:
//                    flagStr = "/星期日"
//                case 2:
//                    flagStr = "/星期一"
//                case 3:
//                    flagStr = "/星期二"
//                case 4:
//                    flagStr = "/星期三"
//                case 5:
//                    flagStr = "/星期四"
//                case 6:
//                    flagStr = "/星期五"
//                case 7:
//                    flagStr = "/星期六"
//                default:
//                    break
//                }
//                
//            } else {
//                flagStr = ""
//                // Fallback on earlier versions
//            }
//        }
//        
//        return flagStr
//    }
//    // 根据NSDate返回20160623格式的日期
//    class func getIntegerFromDate(_ date:Date) -> Int{
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyyMMdd"
//        let todayStr = formatter.string(from: date)
//        let presentDay:Int = Int(todayStr)!
//        return presentDay
//    }
//    //传入 秒  得到 xx:xx:xx
//    class func getMMSSFromDate(_ time:String) -> String {
//        let seconds = NSInteger(time)
//        // 小时
//        let strHour =  String(format: "%.2d", seconds!/3600)
//        // 分钟
//        let strMinute = String(format: "%.2d", (seconds!%3600)/60)
//        // 秒
//        let strSecond = String(format: "%.2d", seconds!%60)
//        // 时间
//        let formatTime = "\(strHour):\(strMinute):\(strSecond)"
//        return formatTime
//    }
//    /**
//     *   编码
//     */
//    class func base64Encoding(_ plainString:String)->String
//    {
//        
//        let plainData = plainString.data(using: String.Encoding.utf8)
//        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
//        return base64String!
//    }
//    
//    /**
//     *   解码
//     */
//    class func base64Decoding(_ encodedString:String)->String
//    {
//        let decodedData = Data(base64Encoded: encodedString, options: NSData.Base64DecodingOptions.init(rawValue: 0))
////        let decodedString = NSString(data: decodedData!, encoding: NSUTF8StringEncoding) as! String
//        if let decodedString = NSString(data: decodedData!, encoding: String.Encoding.utf8) {
//            return decodedString as String
//        }else{
//            return ""
//        }
//    }
//    
//    
//    /// 返回是否是自己登录
//    ///
//    /// - Parameters:
//    ///   - fud: 被关注人的ud
//    ///   - ud: 关注的人
//    /// - Returns: 是否是自己
//    class func isMyselfLogin(_ fud: String) -> Bool {
//        var uid = ""
//        if let ud = AccountManager.currentUser?.id {
//            uid = "\(ud)"
//        }
//        return fud == uid
//    }

}


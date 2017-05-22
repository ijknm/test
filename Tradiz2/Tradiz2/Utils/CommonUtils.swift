//
//  CommonUtils.swift
//  Tradiz2
//
//  Created by JIS on 5/9/17.
//  Copyright © 2017 Beautistar. All rights reserved.
//

import Foundation

var Email : String = ""
var ProfileImageUrl:String = ""
var Address : String = ""
var State : String = ""
var CountryCode : String = ""
var Suburb : String = ""
var PostCode : String = ""
var CurLat : Double = 0.0
var CurLong : Double = 0.0
var IsTradeMan : Bool = true
var LogoImageUrl:String = ""
var Keywords : String = ""

var FullName : String = ""
var Password : String = ""
var PhoneNumber : String = ""

var ABN : String = ""
var BusinessName : String = ""
var BusinessContactNo : String = ""
var WebSite : String = ""
var AboutYou:String = ""




func isValidEmail(testStr:String) -> Bool {
    
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
    
}

func resizeImage(srcImage: UIImage) -> UIImage {
    
    if (srcImage.size.width >= srcImage.size.height) {
        
        return srcImage.resizedImage(byMagick: "256")
    } else {
        
        return srcImage.resizedImage(byMagick: "x256")
    }
}

// save image to a file (Documents/SmarterApp/temp.png)
func saveToFile(image: UIImage!, filePath: String!, fileName: String) -> String! {
    
    let outputFileName = fileName
    
    let outputImage = resizeImage(srcImage: image)
    
    let fileManager = FileManager.default
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    var documentDirectory: NSString! = paths[0] as NSString!
    
    // current document directory
    fileManager.changeCurrentDirectoryPath(documentDirectory as String)
    
    do {
        try fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
    } catch let error as NSError {
        print(error.localizedDescription)
    }
    
    documentDirectory = documentDirectory.appendingPathComponent(filePath) as NSString!
    let savedFilePath = documentDirectory.appendingPathComponent(outputFileName)
    
    // if the file exists already, delete and write, else if create filePath
    if (fileManager.fileExists(atPath: savedFilePath)) {
        do {
            try fileManager.removeItem(atPath: savedFilePath)
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    } else {
        fileManager.createFile(atPath: savedFilePath, contents: nil, attributes: nil)
    }
    
    if let data = UIImagePNGRepresentation(outputImage) {
        
        do {
            try data.write(to:URL(fileURLWithPath:savedFilePath), options:.atomic)
        } catch {
            print(error)
        }
        
    }
    
    return savedFilePath
}


//
//  UIPheonix
//  Copyright © 2016 Mohsan Khan. All rights reserved.
//

//
//  https://github.com/MKGitHub/UIPheonix
//  http://www.xybernic.com
//  http://www.khanofsweden.com
//

//
//  Copyright 2016 Mohsan Khan
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import CoreGraphics

#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(macOS)
    import Cocoa
#endif


class SimpleLabelModel:UIPBaseCVCellModel
{
    // MARK: Public Members
    public var mText:String!
    public var mSize:CGFloat!
    public var mAlignment:String!
    public var mStyle:String!
    public var mBackgroundColorHue:CGFloat!
    public var mNotificationId:String!


    // MARK: UIPInstantiatable


    required init()
    {
        super.init()
    }


    override func setContents(with dictionary:Dictionary<String, AnyObject>)
    {
        mText = dictionary["text"] as! String

        #if os(iOS)
            let crossPlatformFontSize:CGFloat = UIPPlatformFont.systemFontSize
        #elseif os(tvOS)
            let crossPlatformFontSize:CGFloat = 20
        #elseif os(macOS)
            let crossPlatformFontSize:CGFloat = 12
        #endif
        mSize = (dictionary["size"] as? CGFloat) ?? crossPlatformFontSize    // fallback to default value

        mAlignment = (dictionary["alignment"] as? String) ?? "left"          // fallback to default value
        mStyle = (dictionary["style"] as? String) ?? "regular"               // fallback to default value

        mBackgroundColorHue = dictionary["backgroundColorHue"] as! CGFloat

        mNotificationId = (dictionary["notificationId"] as? String) ?? nil   // fallback to default value
    }


    // MARK: Life Cycle


    init(text:String, size:CGFloat, alignment:String, backgroundColorHue:CGFloat, notificationId:String)
    {
        super.init()

        mText = text
        mSize = size
        mAlignment = alignment
        mBackgroundColorHue = backgroundColorHue
        mNotificationId = notificationId
    }


    // MARK: UIPBaseCVCellModel


    override class func viewReuseIdStatic()
    -> String
    {
        return "\(self)"
    }


    override func viewReuseId()
    -> String
    {
        return "\(type(of:self))"
    }


    override func toDictionary()
    -> Dictionary<String, Any>
    {
        return [
            "mText":mText,
            "mSize":mSize,
            "mAlignment":mAlignment,
            "mBackgroundColorHue":CGFloat(mBackgroundColorHue),
            "mNotificationId":mNotificationId
        ]
    }
}


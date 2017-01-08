//
//  UIPheonix
//  Copyright © 2016/2017 Mohsan Khan. All rights reserved.
//

//
//  https://github.com/MKGitHub/UIPheonix
//  http://www.xybernic.com
//  http://www.khanofsweden.com
//

//
//  Copyright 2016/2017 Mohsan Khan
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


final class SimpleLabelModel:UIPBaseCellModel
{
    // MARK: Public Constants
    struct Key
    {
        static let text:String = "text"
        static let size:String = "size"
        static let alignment:String = "alignment"
        static let style:String = "style"
        static let backgroundColorHue:String = "backgroundColorHue"
        static let notificationId:String = "notificationId"
    }

    struct Alignment
    {
        static let left:String = "left"
        static let center:String = "center"
        static let right:String = "right"
    }

    struct Style
    {
        static let regular:String = "regular"
        static let bold:String = "bold"
    }

    // MARK: Public Members
    public var mText:String!
    public var mSize:CGFloat!
    public var mAlignment:String!
    public var mStyle:String!
    public var mBackgroundColorHue:CGFloat!
    public var mNotificationId:String!


    // MARK:- UIPBaseCellModelProtocol


    required init()
    {
        super.init()
    }


    override func setContents(with dictionary:Dictionary<String, Any>)
    {
        mText = dictionary[Key.text] as! String

        #if os(iOS)
            let crossPlatformFontSize:CGFloat = UIPPlatformFont.systemFontSize
        #elseif os(tvOS)
            let crossPlatformFontSize:CGFloat = 20
        #elseif os(macOS)
            let crossPlatformFontSize:CGFloat = 12
        #endif
        mSize = (dictionary[Key.size] as? CGFloat) ?? crossPlatformFontSize    // fallback to default value

        mAlignment = (dictionary[Key.alignment] as? String) ?? Alignment.left          // fallback to default value
        mStyle = (dictionary[Key.style] as? String) ?? Style.regular               // fallback to default value

        mBackgroundColorHue = dictionary[Key.backgroundColorHue] as! CGFloat

        mNotificationId = (dictionary[Key.notificationId] as? String) ?? nil   // fallback to default value
    }


    // MARK:- Life Cycle


    init(text:String, size:CGFloat, alignment:String, style:String, backgroundColorHue:CGFloat, notificationId:String)
    {
        super.init()

        mText = text
        mSize = size
        mAlignment = alignment
        mStyle = style
        mBackgroundColorHue = backgroundColorHue
        mNotificationId = notificationId
    }


    // MARK:- UIPBaseCellModel


    override func toDictionary()
    -> Dictionary<String, Any>
    {
        return [
            Key.text:mText,
            Key.size:mSize,
            Key.alignment:mAlignment,
            Key.backgroundColorHue:CGFloat(mBackgroundColorHue),
            Key.notificationId:mNotificationId
        ]
    }
}


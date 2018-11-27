/**
    UIPheonix
    Copyright © 2016/2017/2018 Mohsan Khan. All rights reserved.

    https://github.com/MKGitHub/UIPheonix
    http://www.xybernic.com

    Copyright 2016/2017/2018 Mohsan Khan

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

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
        static let text = "text"
        static let size = "size"
        static let alignment = "alignment"
        static let style = "style"
        static let backgroundColorHue = "backgroundColorHue"
        static let notificationId = "notificationId"
    }

    struct Alignment
    {
        static let left = "left"
        static let center = "center"
        static let right = "right"
    }

    struct Style
    {
        static let regular = "regular"
        static let bold = "bold"
    }

    // MARK: Public Members
    public var pText:String!
    public var pSize:CGFloat!
    public var pAlignment:String!
    public var pStyle:String!
    public var pBackgroundColorHue:CGFloat!
    public var pNotificationId:String!


    // MARK:- UIPBaseCellModelProtocol


    required init()
    {
        super.init()
    }


    override func setContents(with dictionary:Dictionary<String, Any>)
    {
        pText = dictionary[Key.text] as? String

        #if os(iOS)
            let crossPlatformFontSize:CGFloat = UIPPlatformFont.systemFontSize
        #elseif os(tvOS)
            let crossPlatformFontSize:CGFloat = 20
        #elseif os(macOS)
            let crossPlatformFontSize:CGFloat = 12
        #endif
        pSize = (dictionary[Key.size] as? CGFloat) ?? crossPlatformFontSize    // fallback to default value

        pAlignment = (dictionary[Key.alignment] as? String) ?? Alignment.left          // fallback to default value
        pStyle = (dictionary[Key.style] as? String) ?? Style.regular               // fallback to default value

        pBackgroundColorHue = dictionary[Key.backgroundColorHue] as? CGFloat

        pNotificationId = (dictionary[Key.notificationId] as? String) ?? nil   // fallback to default value
    }


    // MARK:- Life Cycle


    init(text:String, size:CGFloat, alignment:String, style:String, backgroundColorHue:CGFloat, notificationId:String)
    {
        super.init()

        pText = text
        pSize = size
        pAlignment = alignment
        pStyle = style
        pBackgroundColorHue = backgroundColorHue
        pNotificationId = notificationId
    }


    // MARK:- UIPBaseCellModel


    override func toDictionary() -> Dictionary<String, Any>
    {
        return [
            Key.text:pText,
            Key.size:pSize,
            Key.alignment:pAlignment,
            Key.backgroundColorHue:CGFloat(pBackgroundColorHue),
            Key.notificationId:pNotificationId
        ]
    }
}


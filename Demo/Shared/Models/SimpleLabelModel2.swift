/**
    UIPheonix
    Copyright © 2016/2017/2018/2019 Mohsan Khan. All rights reserved.

    https://github.com/MKGitHub/UIPheonix
    http://www.xybernic.com

    Copyright 2016/2017/2018/2019 Mohsan Khan

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


final class SimpleLabelModel2:UIPBaseCellModel
{
    // MARK: Public Constants
    struct Key
    {
        static let text = "text"
        static let backgroundColorHue = "backgroundColorHue"
    }

    // MARK: Public Members
    public var pText:String!
    public var pBackgroundColorHue:CGFloat!


    // MARK:- UIPBaseCellModelProtocol


    required init()
    {
        super.init()
    }


    override func setContents(with dictionary:Dictionary<String, Any>)
    {
        pText = dictionary[Key.text] as? String
        pBackgroundColorHue = dictionary[Key.backgroundColorHue] as? CGFloat
    }


    // MARK:- Life Cycle


    init(text:String, backgroundColorHue:CGFloat)
    {
        super.init()

        pText = text
        pBackgroundColorHue = backgroundColorHue
    }


    // MARK:- UIPBaseCellModel


    override func toDictionary() -> Dictionary<String, Any>
    {
        return [
            Key.text:pText ?? "",
            Key.backgroundColorHue:CGFloat(pBackgroundColorHue)
        ]
    }
}


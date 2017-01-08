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


final class SimpleUserProfileModel:UIPBaseCellModel
{
    // MARK: Public Constants
    struct Key
    {
        static let title:String = "title"
        static let description:String = "description"
    }

    // MARK: Public Members
    public var mTitle:String!
    public var mDescription:String!


    // MARK:- UIPBaseCellModelProtocol


    required init()
    {
        super.init()
    }


    override func setContents(with dictionary:Dictionary<String, Any>)
    {
        mTitle = dictionary[Key.title] as! String
        mDescription = dictionary[Key.description] as! String
    }


    // MARK:- Life Cycle


    init(title:String, description:String)
    {
        super.init()

        mTitle = title
        mDescription = description
    }


    // MARK:- UIPBaseCellModel


    override func toDictionary()
    -> Dictionary<String, Any>
    {
        return [
            Key.title:mTitle,
            Key.description:mDescription
        ]
    }
}


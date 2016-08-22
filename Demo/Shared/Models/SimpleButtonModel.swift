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


class SimpleButtonModel:UIPBaseCVCellModel
{
    // MARK: Public Members
    public var mButtonId:Int!
    public var mButtonTitle:String!

    #if os(macOS)
        public var mAlignment:String!
    #endif

    #if os(tvOS)
        public var mButtonFocus:Bool = false
    #endif


    // MARK: UIPInstantiatable


    required init()
    {
        super.init()
    }


    override func setContents(with dictionary:Dictionary<String, AnyObject>)
    {
        mButtonId = dictionary["id"] as! Int
        mButtonTitle = dictionary["title"] as! String

        #if os(macOS)
            mAlignment = (dictionary["alignment"] as? String) ?? "center"    // fallback to default value
        #endif

        #if os(tvOS)
            mButtonFocus = (dictionary["focus"] as? Bool) ?? false    // fallback to default value
        #endif
    }


    // MARK: Life Cycle


    #if os(iOS)
        init(id:Int, title:String)
        {
            super.init()

            mButtonId = id
            mButtonTitle = title
        }
    #elseif os(tvOS)
        init(id:Int, title:String, focus:Bool)
        {
            super.init()

            mButtonId = id
            mButtonTitle = title

            mButtonFocus = focus
        }
    #elseif os(macOS)
        init(id:Int, title:String, alignment:String)
        {
            super.init()

            mButtonId = id
            mButtonTitle = title

            mAlignment = alignment
        }
    #endif


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
        var dict:Dictionary<String, Any> = Dictionary<String, Any>(minimumCapacity:3)

        dict["mButtonId"] = mButtonId
        dict["mButtonTitle"] = mButtonTitle

        #if os(macOS)
            dict["mAlignment"] = mAlignment
        #endif

        #if os(tvOS)
            dict["mButtonFocus"] = mButtonFocus
        #endif

        return dict
    }
}


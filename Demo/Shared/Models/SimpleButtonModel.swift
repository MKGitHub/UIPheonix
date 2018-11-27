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


final class SimpleButtonModel:UIPBaseCellModel
{
    // MARK: Public Constants
    struct Key
    {
        static let id = "id"
        static let title = "title"
        static let alignment = "alignment"
        static let focus = "focus"
    }

    struct Alignment
    {
        static let left = "left"
        static let center = "center"
        static let right = "right"
    }

    // MARK: Public Members
    public var pId:Int!
    public var pTitle:String!

    #if os(macOS)
        public var pAlignment:String!
    #endif

    #if os(tvOS)
        public var pFocus = false
    #endif


    // MARK:- UIPBaseCellModelProtocol


    required init()
    {
        super.init()
    }


    override func setContents(with dictionary:Dictionary<String, Any>)
    {
        pId = dictionary[Key.id] as? Int
        pTitle = dictionary[Key.title] as? String

        #if os(macOS)
            pAlignment = (dictionary[Key.alignment] as? String) ?? Alignment.center    // fallback to default value
        #endif

        #if os(tvOS)
            pFocus = (dictionary[Key.focus] as? Bool) ?? false    // fallback to default value
        #endif
    }


    // MARK:- Life Cycle


    #if os(iOS)
        init(id:Int, title:String)
        {
            super.init()

            pId = id
            pTitle = title
        }
    #elseif os(tvOS)
        init(id:Int, title:String, focus:Bool)
        {
            super.init()

            pId = id
            pTitle = title

            pFocus = focus
        }
    #elseif os(macOS)
        init(id:Int, title:String, alignment:String)
        {
            super.init()

            pId = id
            pTitle = title

            pAlignment = alignment
        }
    #endif


    // MARK:- UIPBaseCellModel


    override func toDictionary() -> Dictionary<String, Any>
    {
        var dictionary = Dictionary<String, Any>(minimumCapacity:2)

        dictionary[Key.id] = pId
        dictionary[Key.title] = pTitle

        #if os(macOS)
            dictionary[Key.alignment] = pAlignment
        #endif

        #if os(tvOS)
            dictionary[Key.focus] = pFocus
        #endif

        return dictionary
    }
}


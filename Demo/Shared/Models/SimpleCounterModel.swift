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


final class SimpleCounterModel:UIPBaseCellModel
{
    // MARK: Public Constants
    struct Key
    {
        static let value = "value"
        static let notificationId = "notificationId"
    }

    // MARK: Public Members
    public var pValue:Int!
    public var pNotificationId:String!


    // MARK:- UIPBaseCellModelProtocol


    required init()
    {
        super.init()
    }


    override func setContents(with dictionary:Dictionary<String, Any>)
    {
        pValue = dictionary[Key.value] as? Int

        pNotificationId = (dictionary[Key.notificationId] as? String) ?? nil    // fallback to default value
    }


    // MARK:- Life Cycle


    init(value:Int, notificationId:String)
    {
        super.init()

        pValue = value
        pNotificationId = notificationId
    }


    // MARK:- UIPBaseCellModel


    override func toDictionary() -> Dictionary<String, Any>
    {
        return [
            Key.value:pValue,
            Key.notificationId:pNotificationId
        ]
    }
}


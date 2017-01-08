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


typealias AppDisplayStateType = (buttonId:ButtonId, jsonFileName:JSONFileName)


enum AppDisplayState /* of type AppDisplayStateType */
{
    case startUp
    case mixed
    case animations
    case switching
    case appending
    case persistent
    case specific
    case customMadeModels

    var typeValue:AppDisplayStateType
    {
        switch (self)
        {
            case .startUp: return AppDisplayStateType(buttonId:.startUp, jsonFileName:.startUp)
            case .mixed: return AppDisplayStateType(buttonId:.mixed, jsonFileName:.mixed)
            case .animations: return AppDisplayStateType(buttonId:.animations, jsonFileName:.animations)
            case .switching: return AppDisplayStateType(buttonId:.switching, jsonFileName:.switching)
            case .appending: return AppDisplayStateType(buttonId:.appending, jsonFileName:.appending)
            case .persistent: return AppDisplayStateType(buttonId:.persistent, jsonFileName:.persistent)
            case .specific: return AppDisplayStateType(buttonId:.specific, jsonFileName:.specific)
            case .customMadeModels: return AppDisplayStateType(buttonId:.customMadeModels, jsonFileName:.customMadeModels)
        }
    }
}


enum ButtonId:Int
{
    case startUp = 0

    case mixed = 100
    case animations = 101
    case switching = 102

    case appending = 1030
    case appendingReload = 1031

    case persistent = 1040
    case persistentGoBack = 1041

    case specific = 105

    case customMadeModels = 106

    case helloWorld = 999
}


enum JSONFileName:String
{
    case startUp = "DisplayState-StartUp"
    case mixed = "DisplayState-Mixed"
    case animations = "DisplayState-Animations"
    case switching = "DisplayState-Switching"
    case appending = "DisplayState-Appending"
    case persistent = "DisplayState-Persistent"
    case specific = "DisplayState-Specific"
    case customMadeModels = ""
}


struct NotificationKey
{
    static let counterValue = "CounterValue"
}


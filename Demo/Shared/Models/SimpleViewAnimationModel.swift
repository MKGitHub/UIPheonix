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


final class SimpleViewAnimationModel:UIPBaseCellModel
{
    // MARK: Public Constants
    struct Key
    {
        static let animationState:String = "animationState"
    }

    // MARK: Public Member
    public var pAnimationState:Bool = false


    // MARK: UIPBaseCellModelProtocol


    required init()
    {
        super.init()
    }


    override func setContents(with dictionary:Dictionary<String, Any>)
    {
        pAnimationState = dictionary[Key.animationState] as! Bool
    }


    // MARK: Life Cycle


    init(animationState:Bool = false)
    {
        super.init()

        pAnimationState = animationState
    }


    // MARK: UIPBaseCellModel


    override func toDictionary()
    -> Dictionary<String, Any>
    {
        return [
            Key.animationState:pAnimationState
        ]
    }
}


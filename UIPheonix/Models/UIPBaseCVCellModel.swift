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


class UIPBaseCVCellModel:UIPInstantiatable
{
    // MARK: UIPInstantiatable


    required init()
    {
        // empty
    }


    func setContents(with dictionary:Dictionary<String, AnyObject>)
    {
        fatalError("You must override \(#function) in your subclass!")
    }


    // MARK: Base Class Functions


    ///
    /// The reuse identifier for the view (in static context).
    /// E.g. "UIPBaseCVCellModel" the name of the class.
    ///
    class func viewReuseIdStatic()
    -> String
    {
        fatalError("You must override \(#function) in your subclass!")
    }


    ///
    /// The reuse identifier for the view.
    /// E.g. "UIPBaseCVCellModel" the name of the class.
    ///
    func viewReuseId()
    -> String
    {
        fatalError("You must override \(#function) in your subclass!")
    }


    func toDictionary()
    -> Dictionary<String, Any>
    {
        fatalError("You must override \(#function) in your subclass!")
    }
}


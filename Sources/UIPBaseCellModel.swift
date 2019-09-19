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


/**
    The standard base class for all cell models.
*/
class UIPBaseCellModel:UIPBaseCellModelProtocol
{
    // MARK: UIPBaseCellModelProtocol


    var nameOfClass:String { get { return "\(type(of:self))" } }

    static var nameOfClass:String { get { return "\(self)" } }


    required init()
    {
        // empty
    }


    func setContents(with dictionary:Dictionary<String, Any>)
    {
        fatalError("[UIPheonix] You must override \(#function) in your subclass!")
    }


    // MARK: - Base Class Functions


    /**
        Currently this has no purpose other than to serve as a "forced" implementation
        that may/will come in hand when there is a need to debug a model.

        - Returns: Models properties returned as a dictionary.
    */
    func toDictionary() -> Dictionary<String, Any>
    {
        fatalError("[UIPheonix] You must override \(#function) in your subclass!")
    }
}


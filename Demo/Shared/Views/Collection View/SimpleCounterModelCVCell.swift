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

#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(macOS)
    import Cocoa
#endif


final class SimpleCounterModelCVCell:UIPBaseCollectionViewCell
{
    // MARK: Private IB Outlet
    @IBOutlet fileprivate weak var ibPlusButton:UIPPlatformButton!
    @IBOutlet fileprivate weak var ibMinusButton:UIPPlatformButton!

    // MARK: Private Members
    fileprivate var mCounterValue:Double = 0
    fileprivate var mNotificationId:String?


    // MARK:- UIPBaseCollectionViewCell/UIPBaseCollectionViewCellProtocol


    override func update(withModel model:Any, delegate:Any, forIndexPath indexPath:IndexPath)
    -> UIPCellSize
    {
        // apply model to view
        let simpleCounterModel:SimpleCounterModel = model as! SimpleCounterModel

        // store for later
        mCounterValue = Double(simpleCounterModel.pValue)
        mNotificationId = simpleCounterModel.pNotificationId

        // return view size
        return UIPCellSizeUnmodified
    }


    // MARK:- IBAction


    @IBAction func valueChanged(_ sender:UIPPlatformButton)
    {
        // we use the buttons tag for the value change
        mCounterValue += Double(sender.tag)

        // send value changed notification
        if (mNotificationId != nil)
        {
            NotificationCenter.default.post(name:NSNotification.Name(mNotificationId!),
                                            object:nil, userInfo:[NotificationKey.counterValue:mCounterValue])
        }
    }
}


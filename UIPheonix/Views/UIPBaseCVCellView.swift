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

#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(macOS)
    import Cocoa
#endif


class UIPBaseCVCellView:UIPPlatformCollectionViewCell, UIPBaseCVCellProtocol
{
    #if os(tvOS)
    // MARK: Overriding Member
    override var canBecomeFocused:Bool
    {
        // by default, the cell view should not receive focus – its contents should receive focus instead
        return false
    }
    #endif


    // MARK:- Life Cycle


    ///
    /// For debugging purpose.
    ///
    /*override func didUpdateFocus(in context:UIFocusUpdateContext, with coordinator:UIFocusAnimationCoordinator)
    {
        super.didUpdateFocus(in:context, with:coordinator)

        if (context.nextFocusedView == self)
        {
            coordinator.addCoordinatedAnimations(
            {
                () -> Void in
                self.layer.backgroundColor = UIColor.blue().withAlphaComponent(0.2).cgColor
            },
            completion: nil)
        }
        else if (context.previouslyFocusedView == self)
        {
            coordinator.addCoordinatedAnimations(
            {
                () -> Void in
                self.layer.backgroundColor = UIColor.clear().cgColor
            },
            completion: nil)
        }
    }*/


    // MARK:- UIPBaseCVCellProtocol (Override Required)


    class func nibNameStatic()
    -> String
    {
        fatalError("You must override \(#function) in your subclass!")
    }


    func updateWithModel(_ objectModel:AnyObject, delegate:AnyObject, index:UInt)
    -> UIPCellSize
    {
        fatalError("You must override \(#function) in your subclass!")
    }
}


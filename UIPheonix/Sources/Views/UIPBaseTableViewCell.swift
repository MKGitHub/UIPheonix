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


class UIPBaseTableViewCell:UIPPlatformTableViewCell, UIPBaseTableViewCellProtocol
{
    // MARK: UIPPlatformTableViewCell


    #if os(tvOS)
    // MARK: Overriding Member
    override var canBecomeFocused:Bool
    {
        // by default, the cell view should not receive focus – its contents should receive focus instead
        return false
    }
    #endif


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
                self.layer.backgroundColor = UIColor.blue.withAlphaComponent(0.75).cgColor
            },
            completion: nil)
        }
        else if (context.previouslyFocusedView == self)
        {
            coordinator.addCoordinatedAnimations(
            {
                () -> Void in
                self.layer.backgroundColor = UIColor.clear.cgColor
            },
            completion: nil)
        }
    }*/


    // MARK:- UIPBaseTableViewCellProtocol


    var nameOfClass:String { get { return "\(type(of:self))" } }
    static var nameOfClass:String { get { return "\(self)" } }

    #if os(iOS) || os(tvOS)
        var rowHeight:CGFloat { get { return UITableViewAutomaticDimension } }
        var estimatedRowHeight:CGFloat { get { return UITableViewAutomaticDimension } }
    #elseif os(macOS)
        var rowHeight:CGFloat { get { return -1 } }             // macOS does not have any "Automatic Dimension" yet, -1 will crash and needs therefor to be overridden
        var estimatedRowHeight:CGFloat { get { return -1 } }    // macOS does not have any "Automatic Dimension" yet, -1 will crash and needs therefor to be overridden
    #endif


    func update(with model:Any, delegate:Any, for indexPath:IndexPath)
    {
        fatalError("[UIPheonix] You must override \(#function) in your subclass!")
    }
}


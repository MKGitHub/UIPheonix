//----------------------------------------------------------------------------------------------------
// MARK:- UIPBaseTableViewCell.swift
// MARK:-
//----------------------------------------------------------------------------------------------------
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


///
/// The standard base class for all table view cell views.
///
class UIPBaseTableViewCell:UIPPlatformTableViewCell, UIPBaseTableViewCellProtocol
{
    // MARK: UIPPlatformTableViewCell


    #if os(tvOS)
    // MARK: Overriding Member

    /// By default, the cell view should not receive focus, its contents should receive focus instead.
    override var canBecomeFocused:Bool { return false }
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


    /// Name of this class.
    var nameOfClass:String { get { return "\(type(of:self))" } }

    /// Name of this class (static context).
    static var nameOfClass:String { get { return "\(self)" } }

    #if os(iOS) || os(tvOS)
        /// The height of the row.
        var rowHeight:CGFloat { get { return UITableViewAutomaticDimension } }

        /// The estimated height of the row.
        var estimatedRowHeight:CGFloat { get { return UITableViewAutomaticDimension } }
    #elseif os(macOS)
        /// The height of the row.
        var rowHeight:CGFloat { get { return -1 } }             // macOS does not have any "Automatic Dimension" yet, -1 will crash and needs therefor to be overridden

        /// The estimated height of the row.
        var estimatedRowHeight:CGFloat { get { return -1 } }    // macOS does not have any "Automatic Dimension" yet, -1 will crash and needs therefor to be overridden
    #endif


    ///
    /// Update the cell view with a model.
    ///
    /// - Parameters:
    ///   - model: The model to update the cell view with.
    ///   - delegate: The delegate, if any actions are required to handle.
    ///   - indexPath: Index path of the cell view.
    ///
    func update(with model:Any, delegate:Any, for indexPath:IndexPath)
    {
        fatalError("[UIPheonix] You must override \(#function) in your subclass!")
    }
}


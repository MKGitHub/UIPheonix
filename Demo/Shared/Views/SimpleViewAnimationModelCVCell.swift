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


final class SimpleViewAnimationModelCVCell:UIPBaseCVCellView
{
    // MARK: Private IB Outlet
    @IBOutlet fileprivate weak var ibLeftSpaceConstraint:NSLayoutConstraint!

    // MARK: Private Member
    public var mSimpleViewAnimationModel:SimpleViewAnimationModel!


    // MARK:- UICollectionViewCell


    override func prepareForReuse()
    {
        super.prepareForReuse()
    }


    // MARK:- UIPBaseCVCellView/UIPBaseCVCellProtocol


    override class func nibNameStatic()
    -> String
    {
        return "\(self)"
    }


    override func updateWithModel(_ objectModel:AnyObject, delegate:AnyObject, index:UInt)
    -> UIPCellSize
    {
        // save model for later
        mSimpleViewAnimationModel = objectModel as! SimpleViewAnimationModel

        animateUI()

        // return view size
        return UIPCellSize(absoluteWidth:false, width:0,
                           absoluteHeight:false, height:0)
    }


    // MARK:- Private IB Action


    @IBAction func animateButtonAction(_ sender:AnyObject)
    {
        #if os(iOS) || os(tvOS)
            self.layoutIfNeeded()    // #1. Make sure all frames are at the starting position.

            UIView.animate(withDuration:1.0)
            {
                [weak self] in

                if let strongSelf = self
                {
                    strongSelf.mSimpleViewAnimationModel.mAnimationState = !strongSelf.mSimpleViewAnimationModel.mAnimationState
                    strongSelf.animateUI()

                    strongSelf.layoutIfNeeded()    // #2. Layout again to update the frames/constraints.
                }
            }
        #elseif os(macOS)
            self.view.layoutSubtreeIfNeeded()    // #1. Make sure all frames are at the starting position.

            NSAnimationContext.runAnimationGroup(
            {
                [weak self] (context) in

                context.duration = 1.0

                if let strongSelf = self
                {
                    strongSelf.mSimpleViewAnimationModel.mAnimationState = !strongSelf.mSimpleViewAnimationModel.mAnimationState
                    strongSelf.animateUI()

                    strongSelf.view.layoutSubtreeIfNeeded()    // #2. Layout again to update the frames/constraints.
                }
            },
            completionHandler:nil)
        #endif
    }


    // MARK:- Private


    fileprivate func animateUI()
    {
        #if os(iOS)
            self.ibLeftSpaceConstraint?.constant = (mSimpleViewAnimationModel.mAnimationState) ? (self.bounds.width - 70 - 8) : 8
        #elseif os(tvOS)
            self.ibLeftSpaceConstraint?.constant = (mSimpleViewAnimationModel.mAnimationState) ? (self.bounds.width - 150 - 16) : 16
        #elseif os(macOS)
            self.ibLeftSpaceConstraint?.animator().constant = (mSimpleViewAnimationModel.mAnimationState) ? (self.view.bounds.width - 70 - 8) : 8
        #endif
    }
}


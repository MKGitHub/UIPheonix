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

#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(macOS)
    import Cocoa
#endif


final class SimpleViewAnimationModelCVCell:UIPBaseCollectionViewCell
{
    // MARK: Private IB Outlet
    @IBOutlet private weak var ibLeftSpaceConstraint:NSLayoutConstraint!

    // MARK: Private Member
    public var pSimpleViewAnimationModel:SimpleViewAnimationModel!


    // MARK:- UICollectionViewCell


    override func prepareForReuse()
    {
        super.prepareForReuse()
    }


    // MARK:- UIPBaseCollectionViewCell/UIPBaseCollectionViewCellProtocol


    override func update(withModel model:Any, delegate:Any, collectionView:UIPPlatformCollectionView, indexPath:IndexPath) -> UIPCellSize
    {
        // save model for later
        pSimpleViewAnimationModel = model as? SimpleViewAnimationModel

        animateUI()

        // return view size
        return UIPCellSize(replaceWidth:true, width:collectionView.bounds.size.width,
                           replaceHeight:false, height:0)
    }


    // MARK:- Private IB Action


    @IBAction func animateButtonAction(_ sender:AnyObject)
    {
        #if os(iOS) || os(tvOS)
            self.layoutIfNeeded()    // #1. Make sure all frames are at the starting position.

            UIView.animate(withDuration:1.0)
            {
                [weak self] in

                if let self = self
                {
                    self.pSimpleViewAnimationModel.pAnimationState = !self.pSimpleViewAnimationModel.pAnimationState
                    self.animateUI()

                    self.layoutIfNeeded()    // #2. Layout again to update the frames/constraints.
                }
            }
        #elseif os(macOS)
            self.view.layoutSubtreeIfNeeded()    // #1. Make sure all frames are at the starting position.

            NSAnimationContext.runAnimationGroup(
            {
                [weak self] (context) in

                context.duration = 1.0

                if let self = self
                {
                    self.pSimpleViewAnimationModel.pAnimationState = !self.pSimpleViewAnimationModel.pAnimationState
                    self.animateUI()

                    self.view.layoutSubtreeIfNeeded()    // #2. Layout again to update the frames/constraints.
                }
            },
            completionHandler:nil)
        #endif
    }


    // MARK:- Private


    private func animateUI()
    {
        #if os(iOS)
            self.ibLeftSpaceConstraint?.constant = (pSimpleViewAnimationModel.pAnimationState) ? (self.bounds.width - 70 - 8) : 8
        #elseif os(tvOS)
            self.ibLeftSpaceConstraint?.constant = (pSimpleViewAnimationModel.pAnimationState) ? (self.bounds.width - 150 - 16) : 16
        #elseif os(macOS)
            self.ibLeftSpaceConstraint?.animator().constant = (pSimpleViewAnimationModel.pAnimationState) ? (self.view.bounds.width - 70 - 8) : 8
        #endif
    }
}


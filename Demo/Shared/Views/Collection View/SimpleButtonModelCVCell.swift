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


final class SimpleButtonModelCVCell:UIPBaseCollectionViewCell
{
    // MARK: Private IB Outlet
    @IBOutlet fileprivate weak var ibButton:UIPPlatformButton!
    @IBOutlet fileprivate weak var ibCenterConstraint:NSLayoutConstraint!

    // MARK: Private Members
    fileprivate weak var mDelegate:UIPButtonDelegate?
    fileprivate var mButtonId:Int!


    // MARK:- UICollectionViewCell


    override func prepareForReuse()
    {
        super.prepareForReuse()

        mDelegate = nil
    }


    deinit
    {
        mDelegate = nil
    }


    // MARK:- UIPBaseCollectionViewCell/UIPBaseCollectionViewCellProtocol


    override func update(with model:Any, delegate:Any, for indexPath:IndexPath)
    -> UIPCellSize
    {
        // apply model to view
        let simpleButtonModel:SimpleButtonModel = model as! SimpleButtonModel

        #if os(iOS) || os(tvOS)
            UIView.performWithoutAnimation(
            {
                [weak self] in
                self?.ibButton.setTitle(simpleButtonModel.mTitle, for:UIControlState())
                self?.ibButton.layoutIfNeeded()
            })
        #elseif os(macOS)
            ibButton.title = simpleButtonModel.mTitle
            ibButton.sizeToFit()
            alignButton(with:simpleButtonModel.mAlignment)
        #endif

        // view delegate handling
        mDelegate = delegate as? UIPButtonDelegate
        mButtonId = simpleButtonModel.mId

        // layer drawing
        #if os(iOS) || os(tvOS)
            ibButton.layer.cornerRadius = CGFloat.valueForPlatform(mac:10, mobile:10, tv:40)
        #elseif os(macOS)
            ibButton.layer?.cornerRadius = CGFloat.valueForPlatform(mac:10, mobile:10, tv:40)
        #endif

        // return view size
        return UIPCellSizeUnmodified
    }


    // MARK:- IBAction


    @IBAction func buttonAction(_ sender:AnyObject)
    {
        mDelegate?.buttonAction(mButtonId)
    }


    // MARK:- Private


    #if os(macOS)
        fileprivate func alignButton(with aligment:String)
        {
            let buttonWidth:CGFloat = ibButton.bounds.size.width
            let cellViewHalfWidth:CGFloat = (self.view.bounds.size.width / 2)

            switch (aligment)
            {
                case SimpleButtonModel.Alignment.left:
                    ibCenterConstraint.constant = -cellViewHalfWidth + (buttonWidth / 2) + 13
                break

                case SimpleButtonModel.Alignment.center:
                    ibCenterConstraint.constant = 0
                break

                case SimpleButtonModel.Alignment.right:
                    ibCenterConstraint.constant = cellViewHalfWidth - (buttonWidth / 2) - 13
                break

                default:
                break
            }
        }
    #endif
}


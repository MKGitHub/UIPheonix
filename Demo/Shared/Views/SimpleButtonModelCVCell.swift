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


final class SimpleButtonModelCVCell:UIPBaseCVCellView
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


    // MARK:- UIPBaseCVCellView/UIPBaseCVCellProtocol


    override class func nibNameStatic()
    -> String
    {
        return "\(self)"
    }


    override func updateWithModel(_ objectModel:AnyObject, delegate:AnyObject, index:UInt)
    -> UIPCellSize
    {
        // apply model to view
        let simpleButtonModel:SimpleButtonModel = objectModel as! SimpleButtonModel

        #if os(iOS) || os(tvOS)
            UIView.performWithoutAnimation(
            {
                [weak self] in
                self?.ibButton.setTitle(simpleButtonModel.mButtonTitle, for:UIControlState())
                self?.ibButton.layoutIfNeeded()
            })

        #elseif os(macOS)
            ibButton.title = simpleButtonModel.mButtonTitle
            ibButton.sizeToFit()
            alignButton(with:simpleButtonModel.mAlignment)
        #endif

        // view delegate handling
        mDelegate = delegate as? UIPButtonDelegate
        mButtonId = simpleButtonModel.mButtonId

        // return view size
        return UIPCellSize(absoluteWidth:false, width:0,
                           absoluteHeight:false, height:0)
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
                case "left":
                    ibCenterConstraint.constant = -cellViewHalfWidth + (buttonWidth / 2) + 13
                break

                case "center":
                    ibCenterConstraint.constant = 0
                break

                case "right":
                    ibCenterConstraint.constant = cellViewHalfWidth - (buttonWidth / 2) - 13
                break

                default:
                break
            }
        }
    #endif
}


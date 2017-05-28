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


final class SimpleTextFieldModelCVCell:UIPBaseCollectionViewCell
{
    // MARK: Private IB Outlet
    @IBOutlet fileprivate weak var ibTextField:UIPPlatformTextField!

    // MARK: Private Weak Reference
    fileprivate weak var mSimpleTextFieldModelReference:SimpleTextFieldModel?


    // MARK:- UICollectionViewCell


    override func prepareForReuse()
    {
        super.prepareForReuse()
    }


    // MARK:- UIPBaseCollectionViewCell/UIPBaseCollectionViewCellProtocol


    override func update(withModel model:Any, delegate:Any, forIndexPath indexPath:IndexPath)
    -> UIPCellSize
    {
        // apply model to view
        let simpleTextFieldModel:SimpleTextFieldModel = model as! SimpleTextFieldModel

        #if os(iOS) || os(tvOS)
            ibTextField.text = simpleTextFieldModel.pText
        #elseif os(macOS)
            ibTextField.stringValue = simpleTextFieldModel.pText
        #endif

        // keep a reference to the model
        mSimpleTextFieldModelReference = model as? SimpleTextFieldModel

        // return view size
        return UIPCellSizeUnmodified
    }


    // MARK:- IBAction


    @IBAction func editingChanged(_ sender:UIPPlatformTextField)
    {
        // update reference model
        #if os(iOS) || os(tvOS)
            mSimpleTextFieldModelReference?.pText = sender.text
        #elseif os(macOS)
            mSimpleTextFieldModelReference?.pText = sender.stringValue
        #endif
    }
}


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

import Foundation
import CoreGraphics


final class SimpleVerticalSpaceModelCVCell:UIPBaseCollectionViewCell
{
    // MARK:- UICollectionViewCell


    override func prepareForReuse()
    {
        super.prepareForReuse()
    }


    // MARK:- UIPBaseCollectionViewCell/UIPBaseCollectionViewCellProtocol


    override func update(withModel model:Any, delegate:Any, collectionView:UIPPlatformCollectionView, indexPath:IndexPath) -> UIPCellSize
    {
        // apply model to view
        let simpleVerticalSpaceModel = model as! SimpleVerticalSpaceModel

        #if os(iOS) || os(tvOS)
            backgroundColor = UIPPlatformColor.lightGray
        #elseif os(macOS)
            view.layer?.backgroundColor = UIPPlatformColor.lightGray.cgColor
        #endif

        // return view size
        return UIPCellSize(replaceWidth:true, width:(collectionView.bounds.size.width-20),
                           replaceHeight:true, height:simpleVerticalSpaceModel.pSize)
    }
}


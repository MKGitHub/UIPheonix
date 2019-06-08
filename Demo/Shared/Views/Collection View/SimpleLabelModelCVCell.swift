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


final class SimpleLabelModelCVCell:UIPBaseCollectionViewCell
{
    // MARK: Private IB Outlet
    @IBOutlet private weak var ibLabel:UIPPlatformLabel!


    // MARK: Private Member
    private var mNotificationId:String?


    // MARK:- UICollectionViewCell


    override func prepareForReuse()
    {
        super.prepareForReuse()

        // uninstall notification
        toggleNotification(state:false)
    }


    // MARK:- UIPBaseCollectionViewCell/UIPBaseCollectionViewCellProtocol


    override func update(withModel model:Any, delegate:Any, collectionView:UIPPlatformCollectionView, indexPath:IndexPath) -> UIPCellSize
    {
        // apply model to view
        let simpleLabelModel:SimpleLabelModel = model as! SimpleLabelModel

        #if os(iOS) || os(tvOS)
            ibLabel.text = simpleLabelModel.pText
            ibLabel.textAlignment = textAligment(with:simpleLabelModel.pAlignment)
        #elseif os(macOS)
            ibLabel.stringValue = simpleLabelModel.pText
            ibLabel.alignment = textAligment(with:simpleLabelModel.pAlignment)
        #endif

        ibLabel.font = fontStyle(with:simpleLabelModel.pStyle, size:simpleLabelModel.pSize)

        #if os(iOS) || os(tvOS)
            self.backgroundColor = UIPPlatformColor(hue:simpleLabelModel.pBackgroundColorHue, saturation:0.5, brightness:1, alpha:1)
        #elseif os(macOS)
            self.view.layer?.backgroundColor = UIPPlatformColor(hue:simpleLabelModel.pBackgroundColorHue, saturation:0.5, brightness:1, alpha:1).cgColor
        #endif

        // install notification
        if (simpleLabelModel.pNotificationId != nil)
        {
            // store notification id for later
            mNotificationId = simpleLabelModel.pNotificationId

            toggleNotification(state:true)
        }

        // layer drawing
        #if os(iOS) || os(tvOS)
            self.layer.cornerRadius = CGFloat.valueForPlatform(mac:2, mobile:2, tv:10)
        #elseif os(macOS)
            self.view.layer?.cornerRadius = CGFloat.valueForPlatform(mac:2, mobile:2, tv:10)
        #endif

        // return view size
        return UIPCellSize(replaceWidth:true, width:collectionView.bounds.size.width-20,
                           replaceHeight:false, height:0)
    }


    // MARK:- Private


    private func toggleNotification(state:Bool)
    {
        guard (mNotificationId != nil) else { return }

        if (state)
        {
            NotificationCenter.default.addObserver(self, selector:#selector(handleNotification),
                                                   name:NSNotification.Name(mNotificationId!), object:nil)
        }
        else {
            NotificationCenter.default.removeObserver(self, name:NSNotification.Name(mNotificationId!), object:nil)
        }
    }


    @objc private func handleNotification(notification:NSNotification)
    {
        let value:Double = notification.userInfo?[NotificationKey.counterValue] as? Double ?? Double.nan

        #if os(iOS) || os(tvOS)
            ibLabel.text = "The counter value is: \(Int(value))"
        #elseif os(macOS)
            ibLabel.stringValue = "The counter value is: \(Int(value))"
        #endif
    }


    private func textAligment(with aligment:String) -> NSTextAlignment
    {
        switch (aligment)
        {
            case SimpleLabelModel.Alignment.left:
                return NSTextAlignment.left

            case SimpleLabelModel.Alignment.center:
                return NSTextAlignment.center

            case SimpleLabelModel.Alignment.right:
                return NSTextAlignment.right

            default:
                return NSTextAlignment.left
        }
    }


    private func fontStyle(with style:String, size:CGFloat) -> UIPPlatformFont
    {
        switch (style)
        {
            case SimpleLabelModel.Style.regular:
                return UIPPlatformFont.systemFont(ofSize:size)

            case SimpleLabelModel.Style.bold:
                return UIPPlatformFont.boldSystemFont(ofSize:size)

            default:
                return UIPPlatformFont.systemFont(ofSize:size)
        }
    }
}


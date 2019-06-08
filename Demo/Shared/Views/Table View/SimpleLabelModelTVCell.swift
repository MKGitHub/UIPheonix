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


final class SimpleLabelModelTVCell:UIPBaseTableViewCell
{
    // MARK:- UIPBaseTableViewCell/UIPBaseTableViewCellProtocol


    /**
        We do this because this is a default pre-defined "Basic" type cell,
        and the image we use is very big, that tries to resize the cell to a really really enormous size.
    */
    #if os(iOS)
        override var rowHeight:CGFloat { get { return 44 } }    // return default build-in row height
        override var estimatedRowHeight:CGFloat { get { return 44 } }
    #elseif os(tvOS)
        override var rowHeight:CGFloat { get { return 66 } }    // return default build-in row height
        override var estimatedRowHeight:CGFloat { get { return 66 } }
    #elseif os(macOS)
        override var rowHeight:CGFloat { get { return 17 } }    // return default build-in row height
        override var estimatedRowHeight:CGFloat { get { return 17 } }
    #endif


    override func update(withModel model:Any, delegate:Any, tableView:UIPPlatformTableView, indexPath:IndexPath) -> UIPCellSize
    {
        // apply model to view
        let simpleLabelModel2 = model as! SimpleLabelModel2

        #if os(iOS) || os(tvOS)
            self.textLabel?.text = simpleLabelModel2.pText
        #elseif os(macOS)
            self.textField?.stringValue = simpleLabelModel2.pText
        #endif

        #if os(iOS) || os(tvOS)
            self.backgroundColor = UIPPlatformColor(hue:simpleLabelModel2.pBackgroundColorHue, saturation:0.5, brightness:1, alpha:1)
        #elseif os(macOS)
            self.layer?.backgroundColor = UIPPlatformColor(hue:simpleLabelModel2.pBackgroundColorHue, saturation:0.5, brightness:1, alpha:1).cgColor
        #endif

        return UIPCellSizeUnmodified
    }
}


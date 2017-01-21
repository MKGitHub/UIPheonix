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

import CoreGraphics

#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(macOS)
    import Cocoa
#endif


// MARK: Compiler Warning Generators


@available(*, deprecated:0.0.1, message:"THIS IS A FIXME, SEE COMMENT!")
func FIXME()
{
    // If you see this warning then the code needs to be fixed!
}

@available(*, deprecated:0.0.1, message:"THIS IS A NOTE, SEE COMMENT!")
func NOTE()
{
    // If you see this warning then the code needs attention!
}


// MARK:- Constants


struct UIPConstants
{
    static let modelType:String = "type"

    struct Collection
    {
        static let modelViewRelationships:String = "UIPCVModelViewRelationships"
        static let cellModels:String = "UIPCVCellModels"
    }
}


// MARK:- Return Types


///
/// `absoluteWidth` & `absoluteHeight`:
/// - true = use the size as it is provided
/// - false = the size is relative and should be added/subtracted to the original size
///
typealias UIPCellSize = (absoluteWidth:Bool, width:CGFloat, absoluteHeight:Bool, height:CGFloat)

///
/// Convenient variable for an unmodified cell size.
///
var UIPCellSizeUnmodified = UIPCellSize(absoluteWidth:false, width:0, absoluteHeight:false, height:0)


// MARK:- Cross Platform Types


///
/// Because Apple fails to keep it consistent!
/// UXKit any time soon?
///
#if os(iOS) || os(tvOS)
    typealias UIPPlatformFloat = Float
    typealias UIPPlatformRect = CGRect
    typealias UIPPlatformImage = UIImage
    typealias UIPPlatformColor = UIColor
    typealias UIPPlatformFont = UIFont
    typealias UIPPlatformView = UIView
    typealias UIPPlatformImageView = UIImageView
    typealias UIPPlatformTextField = UITextField
    typealias UIPPlatformLabel = UILabel
    typealias UIPPlatformButton = UIButton
    typealias UIPPlatformCollectionViewCell = UICollectionViewCell
    typealias UIPPlatformTableViewCell = UITableViewCell
    typealias UIPPlatformCollectionView = UICollectionView
    typealias UIPPlatformTableView = UITableView
    typealias UIPPlatformViewController = UIViewController
#elseif os(macOS)
    typealias UIPPlatformFloat = CGFloat
    typealias UIPPlatformRect = NSRect
    typealias UIPPlatformImage = NSImage
    typealias UIPPlatformColor = NSColor
    typealias UIPPlatformFont = NSFont
    typealias UIPPlatformView = NSView
    typealias UIPPlatformImageView = NSImageView
    typealias UIPPlatformTextField = NSTextField
    typealias UIPPlatformLabel = NSTextField
    typealias UIPPlatformButton = NSButton
    typealias UIPPlatformCollectionViewCell = NSCollectionViewItem
    typealias UIPPlatformTableViewCell = NSTableCellView
    typealias UIPPlatformCollectionView = NSCollectionView
    typealias UIPPlatformTableView = NSTableView
    typealias UIPPlatformViewController = NSViewController
#endif


// MARK:- Cross Platform


extension CGFloat
{
    static func valueForPlatform(mac:CGFloat, mobile:CGFloat, tv:CGFloat)
    -> CGFloat
    {
        #if os(iOS)
            return mobile
        #elseif os(tvOS)
            return tv
        #elseif os(macOS)
            return mac
        #endif
    }
}


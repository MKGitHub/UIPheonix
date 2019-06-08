// UIPheonix 3.0

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


/**
    The standard base class for all cell models.
*/
class UIPBaseCellModel:UIPBaseCellModelProtocol
{
    // MARK: UIPBaseCellModelProtocol


    var nameOfClass:String { get { return "\(type(of:self))" } }

    static var nameOfClass:String { get { return "\(self)" } }


    required init()
    {
        // empty
    }


    func setContents(with dictionary:Dictionary<String, Any>)
    {
        fatalError("[UIPheonix] You must override \(#function) in your subclass!")
    }


    // MARK: - Base Class Functions


    /**
        Currently this has no purpose other than to serve as a "forced" implementation
        that may/will come in hand when there is a need to debug a model.

        - Returns: Models properties returned as a dictionary.
    */
    func toDictionary() -> Dictionary<String, Any>
    {
        fatalError("[UIPheonix] You must override \(#function) in your subclass!")
    }
}

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


/**
    The base cell model protocol.
*/
protocol UIPBaseCellModelProtocol:class
{
    // We can't use "className" because that belongs to Objective-C NSObject. //

    /// Name of this class.
    var nameOfClass:String { get }

    /// Name of this class (static context).
    static var nameOfClass:String { get }

    init()

    /**
        Set the contents of the model using the dictionary i.e. model mapping.

        - Parameter dictionary: Dictionary containing data for the model.
    */
    func setContents(with dictionary:Dictionary<String, Any>)
}

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


/**
    The standard base class for all collection view cell views.
*/
class UIPBaseCollectionViewCell:UIPPlatformCollectionViewCell, UIPBaseCollectionViewCellProtocol
{
    // MARK: UIPPlatformCollectionViewCell


    #if os(tvOS)
        // MARK: Overriding Member

        /// By default, the cell view should not receive focus, its contents should receive focus instead.
        override var canBecomeFocused:Bool { return false }
    #endif


    /**
        For debugging purpose.
    */
    /*override func didUpdateFocus(in context:UIFocusUpdateContext, with coordinator:UIFocusAnimationCoordinator)
    {
        super.didUpdateFocus(in:context, with:coordinator)

        if (context.nextFocusedView == self)
        {
            coordinator.addCoordinatedAnimations(
            {
                () -> Void in
                self.layer.backgroundColor = UIColor.blue().withAlphaComponent(0.2).cgColor
            },
            completion: nil)
        }
        else if (context.previouslyFocusedView == self)
        {
            coordinator.addCoordinatedAnimations(
            {
                () -> Void in
                self.layer.backgroundColor = UIColor.clear().cgColor
            },
            completion: nil)
        }
    }*/


    // MARK: - UIPBaseCollectionViewCellProtocol


    var nameOfClass:String { get { return "\(type(of:self))" } }

    static var nameOfClass:String { get { return "\(self)" } }


    func update(withModel model:Any, delegate:Any, collectionView:UIPPlatformCollectionView, indexPath:IndexPath) -> UIPCellSize
    {
        fatalError("[UIPheonix] You must override \(#function) in your subclass!")
    }
}

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

import CoreGraphics

#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(macOS)
    import Cocoa
#endif


/**
    The standard protocol for all collection view cell views.
*/
protocol UIPBaseCollectionViewCellProtocol:class
{
    // We can't use "className" because that belongs to Objective-C NSObject. //

    /// Name of this class.
    var nameOfClass:String { get }

    /// Name of this class (static context).
    static var nameOfClass:String { get }

    /**
        Update the cell view with a model.

        - Parameters:
            - model: The model to update the cell view with.
            - delegate: The delegate, if any actions are required to handle.
            - collectionView: The associated collection view.
            - indexPath: Index path of the cell view.

        - Returns: The size of the cell view, if you need to modify it. Else return `UIPCellSizeUnmodified`.
    */
    func update(withModel model:Any, delegate:Any, collectionView:UIPPlatformCollectionView, indexPath:IndexPath) -> UIPCellSize
}

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


/**
    The standard base class for all table view cell views.
*/
class UIPBaseTableViewCell:UIPPlatformTableViewCell, UIPBaseTableViewCellProtocol
{
    // MARK: UIPPlatformTableViewCell


    #if os(tvOS)
        // MARK: Overriding Member

        /// By default, the cell view should not receive focus, its contents should receive focus instead.
        override var canBecomeFocused:Bool { return false }
    #endif


    /**
        For debugging purpose.
    */
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


    // MARK: - UIPBaseTableViewCellProtocol


    var nameOfClass:String { get { return "\(type(of:self))" } }

    static var nameOfClass:String { get { return "\(self)" } }

    #if os(iOS) || os(tvOS)
        var rowHeight:CGFloat { get { return UITableView.automaticDimension } }

        var estimatedRowHeight:CGFloat { get { return UITableView.automaticDimension } }
    #elseif os(macOS)
        var rowHeight:CGFloat { get { return -1 } }  // macOS does not have any "Automatic Dimension" yet, -1 will crash and needs therefor to be overridden

        var estimatedRowHeight:CGFloat { get { return -1 } }  // macOS does not have any "Automatic Dimension" yet, -1 will crash and needs therefor to be overridden
    #endif


    func update(withModel model:Any, delegate:Any, tableView:UIPPlatformTableView, indexPath:IndexPath) -> UIPCellSize
    {
        fatalError("[UIPheonix] You must override \(#function) in your subclass!")
    }
}

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

import CoreGraphics

#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(macOS)
    import Cocoa
#endif


/**
    The standard protocol for all table view cell views.
*/
protocol UIPBaseTableViewCellProtocol:class
{
    // We can't use "className" because that belongs to Objective-C NSObject. //

    /// Name of this class.
    var nameOfClass:String { get }

    /// Name of this class (static context).
    static var nameOfClass:String { get }

    /// The height of the row.
    var rowHeight:CGFloat { get }

    /// The estimated height of the row.
    var estimatedRowHeight:CGFloat { get }

    /**
        Update the cell view with a model.

        - Parameters:
            - model: The model to update the cell view with.
            - delegate: The delegate, if any actions are required to handle.
            - tableView: The associated table view.
            - indexPath: Index path of the cell view.

        - Returns: The size of the cell view, if you need to modify it. Else return `UIPCellSizeUnmodified`.
    */
    func update(withModel model:Any, delegate:Any, tableView:UIPPlatformTableView, indexPath:IndexPath) -> UIPCellSize
}

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


/**
    The base view controller protocol.
*/
protocol UIPBaseViewControllerProtocol:class
{
    // We can't use "className" because that belongs to Objective-C NSObject. //

    /// Name of this class.
    var nameOfClass:String { get }

    /// Name of this class (static context).
    static var nameOfClass:String { get }
}


#if os(iOS) || os(tvOS)

    /**
        The base view controller. Subclass this to gain its features.
        Example code is provided in this file.
    */
    class UIPBaseViewController:UIViewController, UIPBaseViewControllerProtocol
    {
        /**
            We have to implement this because we use `self` in the `makeViewController` function.
        */
        override required public init(nibName nibNameOrNil:String?, bundle nibBundleOrNil:Bundle?)
        {
            super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
        }


        /**
            We have to implement this because we use `self` in the `makeViewController` function.
        */
        required public init?(coder aDecoder:NSCoder)
        {
            super.init(coder:aDecoder)
        }


        // MARK: UIPBaseViewControllerProtocol


        /// Name of this class.
        var nameOfClass:String { get { return "\(type(of:self))" } }

        /// Name of this class (static context).
        static var nameOfClass:String { get { return "\(self)" } }

        // MARK: Public Member
        var newInstanceAttributes = Dictionary<String, Any>()

        // MARK: Public Weak Reference
        weak var parentVC:UIPBaseViewController?


        // MARK: Life Cycle


        /**
            Example implementation, copy & paste into your concrete class.

            Create a new instance of this view controller
            with attributes
            and a parent view controller for sending attributes back.
        */
        class func makeViewController<T:UIPBaseViewController>(attributes:Dictionary<String, Any>, parentVC:UIPBaseViewController?) -> T
        {
            // with nib
            guard let vc:T = self.init(nibName:"\(self)", bundle:nil) as? T else
            {
                fatalError("[UIPheonix] New instance of type '\(self)' failed to init!")
            }

            // init members
            vc.newInstanceAttributes = attributes
            vc.parentVC = parentVC

            return vc 
        }


        /**
            This view controller is about to be dismissed.
            The child view controller should implement this to send data back to its parent view controller.

            - Returns: A dictionary for our parent view controller, default nil.
        */
        func dismissInstance() -> Dictionary<String, Any>?
        {
            // by default we return nil
            return nil
        }


        override func willMove(toParent parent:UIViewController?)
        {
            super.willMove(toParent:parent)

            // `self` view controller is being removed
            // i.e. we are moving back to our parent
            if (parent == nil)
            {
                if let parentVC = parentVC,
                   let dict = dismissInstance()
                {
                    parentVC.childViewController(self, willDismissWithAttributes:dict)
                }
            }
        }


        /**
            Assuming that this view controller is a parent, then its child is about to be dismissed.
            The parent view controller should implement this to receive data back from its child view controller.
        */
        func childViewController(_ childViewController:UIPBaseViewController, willDismissWithAttributes attributes:Dictionary<String, Any>)
        {
            fatalError("[UIPheonix] You must override \(#function) in your subclass!")
        }
    }

#elseif os(macOS)

    /**
        The base view controller. Subclass this to gain its features.
        Example code is provided in this file.
    */
    class UIPBaseViewController:NSViewController, UIPBaseViewControllerProtocol
    {
        /**
            We have to implement this because we use `self` in the `makeViewController` function.
        */
        override required public init(nibName nibNameOrNil:NSNib.Name?, bundle nibBundleOrNil:Bundle?)
        {
            super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
        }


        /**
            We have to implement this because we use `self` in the `makeViewController` function.
        */
        required public init?(coder aDecoder:NSCoder)
        {
            super.init(coder:aDecoder)
        }


        // MARK: UIPBaseViewControllerProtocol


        /// Name of this class.
        var nameOfClass:String { get { return "\(type(of:self))" } }

        /// Name of this class (static context).
        static var nameOfClass:String { get { return "\(self)" } }

        // MARK: Public Member
        var newInstanceAttributes = Dictionary<String, Any>()

        // MARK: Public Weak Reference
        weak var parentVC:UIPBaseViewController?


        // MARK: Life Cycle


        /**
            Example implementation, copy & paste into your concrete class.

            Create a new instance of this view controller
            with attributes
            and a parent view controller for sending attributes back.
        */
        class func makeViewController<T:UIPBaseViewController>(attributes:Dictionary<String, Any>, parentVC:UIPBaseViewController?) -> T
        {
            // with nib
            guard let vc:T = self.init(nibName:NSNib.Name("\(self)"), bundle:nil) as? T else
            {
                fatalError("[UIPheonix] New instance of type '\(self)' failed to init!")
            }

            // init members
            vc.newInstanceAttributes = attributes
            vc.parentVC = parentVC

            return vc
        }


        /**
            This view controller is about to be dismissed.
            The child view controller should implement this to send data back to its parent view controller.

            - Returns: A dictionary for our parent view controller, default nil.
        */
        func dismissInstance() -> Dictionary<String, Any>?
        {
            // by default we return nil
            return nil
        }


        /**
            Assuming that this view controller is a parent, then its child is about to be dismissed.
            The parent view controller should implement this to receive data back from its child view controller.
        */
        func childViewController(_ childViewController:UIPBaseViewController, willDismissWithAttributes attributes:Dictionary<String, Any>)
        {
            fatalError("[UIPheonix] You must override \(#function) in your subclass!")
        }
    }

#endif

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


/**
    A simple/example button delegate for handling button actions.
*/
protocol UIPButtonDelegate:class
{
    /**
        Handles a buttons action i.e. press/tap.

        - Parameter buttonId: The buttons id.
    */
    func handleAction(forButtonId buttonId:Int)
}

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

import CoreGraphics

#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(macOS)
    import Cocoa
#endif


// MARK: - Constants


/**
    Internal framework constants.
*/
struct UIPConstants
{
    static let modelAppearance = "appearance"

    struct Collection
    {
        static let modelViewRelationships = "UIPCVModelViewRelationships"
        static let cellModels = "UIPCVCellModels"
    }
}


// MARK: - Return Types


/**
    `replaceWidth` & `replaceHeight`:
    - true = use the size as it is provided
    - false = the size is relative and should be added/subtracted to the original size
*/
typealias UIPCellSize = (replaceWidth:Bool, width:CGFloat, replaceHeight:Bool, height:CGFloat)

/**
    Convenient variable for providing an unmodified cell size.
*/
var UIPCellSizeUnmodified = UIPCellSize(replaceWidth:false, width:0, replaceHeight:false, height:0)


// MARK: - Cross Platform Types


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


// MARK: - Cross Platform


extension CGFloat
{
    /**
        Convenient function to handle values cross platform.

        - Parameters:
            - mac: The macOS value.
            - mobile: The iOS iPhone/iPod/iPad value.
            - tv: The tvOS value.

        - Returns: The value which matches the current running platform.
    */
    static func valueForPlatform(mac:CGFloat, mobile:CGFloat, tv:CGFloat) -> CGFloat
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

import CoreGraphics

#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(macOS)
    import Cocoa
#endif


private enum UIPDelegateViewAppearance
{
    case collection
    case table
}


/**
    The core class of UIPheonix.
*/
@available(OSX 10.11, iOS 9.0, tvOS 9.0, *)
final class UIPheonix
{
    // MARK: Private Members
    private var mApplicationNameDot:String!
    private var mUIPDelegateViewAppearance:UIPDelegateViewAppearance!
    private var mModelViewRelationships = Dictionary<String, String>()
    private var mViewReuseIds = Dictionary<String, Any>()
    private var mDisplayModels = Dictionary<Int, Array<UIPBaseCellModelProtocol>>()

    // MARK: Private Weak References
    private weak var mDelegate:AnyObject?
    private weak var mDelegateCollectionView:UIPPlatformCollectionView?
    private weak var mDelegateTableView:UIPPlatformTableView?


    // MARK: - Life Cycle


    /**
        Init with `UICollectionView`.

        - Parameters:
            - collectionView: A collection view.
    */
    init(collectionView:UIPPlatformCollectionView, delegate:AnyObject)
    {
        // init members
        mUIPDelegateViewAppearance = UIPDelegateViewAppearance.collection
        mApplicationNameDot = applicationName() + "."

        mDelegateCollectionView = collectionView
        mDelegate = delegate
    }


    /**
        Init with `UITableView`.

        - Parameters:
            - tableView: A table view.
    */
    init(tableView:UIPPlatformTableView, delegate:AnyObject)
    {
        // init members
        mUIPDelegateViewAppearance = UIPDelegateViewAppearance.table
        mApplicationNameDot = applicationName() + "."

        mDelegateTableView = tableView
        mDelegate = delegate
    }


    // MARK: - Model-View Relationships


    /**
        Creates relationships between models and views.

        - Parameter dictionary: A dictionary with model-name:view-name relationship.
    */
    func setModelViewRelationships(withDictionary dictionary:Dictionary<String, String>)
    {
        guard (!dictionary.isEmpty) else {
            fatalError("[UIPheonix] Can't set model-view relationships from dictionary that is empty!")
        }

        mModelViewRelationships = dictionary

        connectWithDelegateViewType()
    }


    // MARK: - Display Models


    /**
        Set/Append the models to display for a Collection View or Table View.

        - Parameters:
            - models: An array containing dictionary objects with model data.
            - section: The section in which the models you want to set.
            - append: Append to, or replace, the current model list.
    */
    func setDisplayModels(_ models:Array<Any>, forSection section:Int, append:Bool)
    {
        guard (!models.isEmpty) else {
            fatalError("[UIPheonix] Model data array is empty!")
        }

        guard (section >= 0) else {
            fatalError("[UIPheonix] Section is out of range!")
        }

        // don't append, but replace
        if (!append)
        {
            // prepare a new empty display models list
            mDisplayModels[section] = Array<UIPBaseCellModelProtocol>()
        }

        // instantiate model classes with their data in the display dictionary
        // add the models to the display list
        var groupModels = Array<UIPBaseCellModelProtocol>()

        for m:Any in models
        {
            let modelDictionary = m as! Dictionary<String, Any>
            let modelAppearanceName = modelDictionary[UIPConstants.modelAppearance] as? String

            // `appearance` field does not exist
            if (modelAppearanceName == nil) {
                fatalError("[UIPheonix] The key `appearance` was not found for the model '\(m)'!")
            }

            // create models
            if let modelClassType:UIPBaseCellModelProtocol.Type = NSClassFromString(mApplicationNameDot + modelAppearanceName!) as? UIPBaseCellModelProtocol.Type
            {
                let aModelObj:UIPBaseCellModelProtocol = modelClassType.init()
                aModelObj.setContents(with:modelDictionary)

                groupModels.append(aModelObj)
            }
        }

        // add models to group
        mDisplayModels[section] = groupModels
    }

    
    /**
        Sets the models to display for a Collection View or Table View.

        - Parameters:
            - array: An array containing dictionary objects with model data.
            - section: The section in which the models you want to set.
    */
    func setDisplayModels(_ models:Array<UIPBaseCellModelProtocol>, forSection section:Int)
    {
        mDisplayModels[section] = models
    }


    /**
        Update a model to display for a Collection View or Table View.

        - Parameters:
            - newModel: The new model.
            - section: The section in which the model you want to update.
            - index: The index of the model.
    */
    func updateDisplayModel(_ newModel:UIPBaseCellModel, forSection section:Int, atIndex index:Int)
    {
        // get section
        if var sectionModels = mDisplayModels[section]
        {
            // get model
            if ((sectionModels[index] as? UIPBaseCellModel) != nil)
            {
                // replace model
                sectionModels[index] = newModel

                // replace section
                mDisplayModels[section] = sectionModels
            }
        }
    }


    /**
        Append the models to display for a Collection View or Table View.

        - Parameters:
            - array: An array containing dictionary objects with model data.
            - section: The section in which the models you want to add.
    */
    func addDisplayModels(_ models:Array<UIPBaseCellModelProtocol>, inSection section:Int)
    {
        if var currentGroupModels = mDisplayModels[section]
        {
            currentGroupModels.append(contentsOf:models)

            mDisplayModels[section] = currentGroupModels
        }
        else
        {
            fatalError("[UIPheonix] Section '\(section)' does not exist!")
        }
    }


        /**
            - Parameters:
                - section: The section for which the models you want to get.

            - Returns: Array containing models.
    */
    func displayModels(forSection section:Int) -> Array<UIPBaseCellModelProtocol>
    {
        if let currentGroupModels = mDisplayModels[section]
        {
            return currentGroupModels
        }
        else
        {
            fatalError("[UIPheonix] Section '\(section)' does not exist!")
        }
    }


    /**
        - Parameters:
            - section: The section for which the models you want to count.

        - Returns: The number of models.
    */
    func displayModelsCount(forSection section:Int) -> Int
    {
        if let currentGroupModels = mDisplayModels[section]
        {
            return currentGroupModels.count
        }

        return 0
    }


    /**
        - Parameters:
            - section: The section in which a specific model you want to get.
            - index: The index of the model.

        - Returns: The model.
    */
    func displayModel(forSection section:Int, atIndex index:Int) -> UIPBaseCellModel?
    {
        if let currentGroupModels = mDisplayModels[section]
        {
            if let cellModel:UIPBaseCellModel = currentGroupModels[index] as? UIPBaseCellModel
            {
                return cellModel
            }
        }

        return nil
    }


    // MARK: - UICollectionView


    /**
        Call this after setting content on the cell to have a fitting layout size returned.
        **Note!** The cell's size is determined using Auto Layout & constraints.

        - Parameters:
            - cell: The cell.
            - preferredWidth: The preferred width of the cell.

        - Returns: The fitting layout size.
    */
    @inline(__always)
    class func calculateLayoutSizeForCell(_ cell:UIPPlatformCollectionViewCell, preferredWidth:CGFloat) -> CGSize
    {
        var size:CGSize

        #if os(iOS) || os(tvOS)
            // set bounds, and match with the `contentView`
            cell.bounds = CGRect(x:0, y:0, width:preferredWidth, height:cell.bounds.size.height)
            cell.contentView.bounds = cell.bounds

            // layout subviews
            cell.setNeedsLayout()
            cell.layoutIfNeeded()

            // we use the `preferredWidth`
            // and the fitting height because of the layout pass done above
            size = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            size.width = preferredWidth
            //size.height = CGFloat(ceilf(Float(size.height)))    // don't need to do this as per Apple's advice
        #elseif os(macOS)
            cell.view.bounds = CGRect(x:0, y:0, width:preferredWidth, height:cell.view.bounds.size.height)

            // layout subviews
            cell.view.layoutSubtreeIfNeeded()

            // we use the `preferredWidth`
            // and the height from the layout pass done above
            size = cell.view.bounds.size
            size.width = preferredWidth
        #endif

        return size
    }


    /**
        Use the base size and add or subtract another size.

        - Parameters:
            - baseSize: Base size.
            - addedSize: Added or subtract size.

        - Returns: The new size.
    */
    @inline(__always)
    class func viewSize(with baseSize:CGSize, adding addedSize:UIPCellSize) -> CGSize
    {
        // by default, we use the cells layout size
        var finalSize:CGSize = baseSize

        // Replace or add/subtract size. //

        // width
        if (addedSize.replaceWidth)
        {
            finalSize.width = addedSize.width
        }
        else
        {
            finalSize.width += addedSize.width
        }

        // height
        if (addedSize.replaceHeight)
        {
            finalSize.height = addedSize.height
        }
        else
        {
            finalSize.height += addedSize.height
        }

        return finalSize
    }


    /**
        Dequeue a reusable collection view cell view.

        - Parameters:
            - reuseIdentifier: The cell identifier.
            - indexPath: Index path of cell.

        - Returns: A collection view cell view.
    */
    func dequeueView(withReuseIdentifier reuseIdentifier:String, forIndexPath indexPath:IndexPath) -> UIPBaseCollectionViewCell?
    {
        guard (mDelegateCollectionView != nil) else {
            fatalError("[UIPheonix] `dequeueView` failed, `mDelegateCollectionView` is nil!")
        }

        #if os(iOS) || os(tvOS)
            if let cellView = mDelegateCollectionView!.dequeueReusableCell(withReuseIdentifier:reuseIdentifier, for:indexPath) as? UIPBaseCollectionViewCell
            {
                return cellView
            }
        #elseif os(macOS)
            if let cellView = mDelegateCollectionView!.makeItem(withIdentifier:NSUserInterfaceItemIdentifier(rawValue:reuseIdentifier), for:indexPath) as? UIPBaseCollectionViewCell
            {
                return cellView
            }
        #endif

        return nil
    }


    /**
        Get a collection view cell view.

        - Parameter viewReuseId: The cell identifier.

        - Returns: A collection view cell view.
    */
    func view(forReuseIdentifier viewReuseId:String) -> UIPBaseCollectionViewCell?
    {
        return mViewReuseIds[viewReuseId] as? UIPBaseCollectionViewCell
    }


    #if os(iOS) || os(tvOS)
        /**
            Convenience function, use it in your:
            func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
        */
        func collectionViewCell(forIndexPath indexPath:IndexPath) -> UICollectionViewCell
        {
            guard (mDelegate != nil) else {
                fatalError("[UIPheonix] `collectionViewCell` failed, `mDelegate` is nil!")
            }

            guard (mDelegateCollectionView != nil) else {
                fatalError("[UIPheonix] `collectionViewCell` failed, `mDelegateCollectionView` is nil!")
            }

            guard let cellModel = displayModel(forSection:indexPath.section, atIndex:indexPath.item) else
            {
                fatalError("[UIPheonix] `collectionViewCell` failed, `model` is nil!")
            }

            let cellView:UIPBaseCollectionViewCell = dequeueView(withReuseIdentifier:cellModel.nameOfClass, forIndexPath:indexPath)!
            _ = cellView.update(withModel:cellModel, delegate:mDelegate!, collectionView:mDelegateCollectionView!, indexPath:indexPath)

            cellView.layoutIfNeeded()

            return cellView
        }

        /**
            Convenience function, use it in your:
            func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
        */
        func collectionViewCellSize(forIndexPath indexPath:IndexPath) -> CGSize
        {
            guard (mDelegate != nil) else {
                fatalError("[UIPheonix] `collectionViewCellSize` failed, `mDelegate` is nil!")
            }

            guard (mDelegateCollectionView != nil) else {
                fatalError("[UIPheonix] `collectionViewCellSize` failed, `mDelegateCollectionView` is nil!")
            }

            guard let cellModel = displayModel(forSection:indexPath.section, atIndex:indexPath.item) else
            {
                fatalError("[UIPheonix] `collectionViewCellSize` failed, `model` is nil!")
            }

            let cellView:UIPBaseCollectionViewCell = view(forReuseIdentifier:cellModel.nameOfClass)!
            let modelCellSize:UIPCellSize = cellView.update(withModel:cellModel, delegate:mDelegate!, collectionView:mDelegateCollectionView!, indexPath:indexPath)
            let layoutCellSize:CGSize = UIPheonix.calculateLayoutSizeForCell(cellView, preferredWidth:modelCellSize.width)

            return UIPheonix.viewSize(with:layoutCellSize, adding:modelCellSize)
        }
    #elseif os(macOS)
        /**
            Convenience function, use it in your:
            func collectionView(_ collectionView:NSCollectionView, itemForRepresentedObjectAt indexPath:IndexPath) -> NSCollectionViewItem
        */
        func collectionViewItem(forIndexPath indexPath:IndexPath) -> NSCollectionViewItem
        {
            guard (mDelegate != nil) else {
                fatalError("[UIPheonix] `collectionViewItem` failed, `mDelegate` is nil!")
            }

            guard (mDelegateCollectionView != nil) else {
                fatalError("[UIPheonix] `collectionViewItem` failed, `mDelegateCollectionView` is nil!")
            }

            let cellModel = displayModel(forSection:0, atIndex:indexPath.item)!
            let cellView:UIPBaseCollectionViewCell = dequeueView(withReuseIdentifier:cellModel.nameOfClass, forIndexPath:indexPath)!
            _ = cellView.update(withModel:cellModel, delegate:mDelegate!, collectionView:mDelegateCollectionView!, indexPath:indexPath)

            return cellView
        }

        /**
            Convenience function, use it in your:
            func collectionView(_ collectionView:NSCollectionView, layout collectionViewLayout:NSCollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
        */
        func collectionViewItemSize(forIndexPath indexPath:IndexPath) -> CGSize
        {
            guard (mDelegate != nil) else {
                fatalError("[UIPheonix] `collectionViewCellSize` failed, `mDelegate` is nil!")
            }

            guard (mDelegateCollectionView != nil) else {
                fatalError("[UIPheonix] `collectionViewCellSize` failed, `mDelegateCollectionView` is nil!")
            }

            let cellModel = displayModel(forSection:0, atIndex:indexPath.item)!
            let cellView:UIPBaseCollectionViewCell = view(forReuseIdentifier:cellModel.nameOfClass)!
            let modelCellSize = cellView.update(withModel:cellModel, delegate:mDelegate!, collectionView:mDelegateCollectionView!, indexPath:indexPath)
            let layoutCellSize = UIPheonix.calculateLayoutSizeForCell(cellView, preferredWidth:modelCellSize.width)

            return UIPheonix.viewSize(with:layoutCellSize, adding:modelCellSize)
        }
    #endif


    // MARK: - UITableView


    #if os(iOS) || os(tvOS)
        /**
            Convenience function, use it in your:
            func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell
        */
        func tableViewCell(forIndexPath indexPath:IndexPath, delegate:Any) -> UITableViewCell
        {
            guard (mDelegate != nil) else {
                fatalError("[UIPheonix] `tableViewCell` failed, `mDelegate` is nil!")
            }

            guard (mDelegateTableView != nil) else {
                fatalError("[UIPheonix] `tableViewCell` failed, `mDelegateTableView` is nil!")
            }

            guard let cellModel = displayModel(forSection:indexPath.section, atIndex:indexPath.item) else
            {
                fatalError("[UIPheonix] `tableViewCell` failed, `model` is nil!")
            }

            let cellView:UIPBaseTableViewCell = dequeueView(withReuseIdentifier:cellModel.nameOfClass, forIndexPath:indexPath)!

            _ = cellView.update(withModel:cellModel, delegate:delegate, tableView:mDelegateTableView!, indexPath:indexPath)

            return cellView
        }

        /**
            Convenience function, use it in your:
            func tableView(_ tableView:UITableView, heightForRowAt indexPath:IndexPath) -> CGFloat
        */
        func tableViewCellHeight(forIndexPath indexPath:IndexPath) -> CGFloat
        {
            guard (mDelegate != nil) else {
                fatalError("[UIPheonix] `tableView heightForRowAt` failed, `mDelegate` is nil!")
            }

            guard let cellModel = displayModel(forSection:indexPath.section, atIndex:indexPath.item) else
            {
                fatalError("[UIPheonix] `tableView heightForRowAt` failed, `model` is nil!")
            }

            let cellView:UIPBaseTableViewCell = view(forReuseIdentifier:cellModel.nameOfClass)!

            return cellView.rowHeight
        }

        /**
            Convenience function, use it in your:
            func tableView(_ tableView:UITableView, estimatedHeightForRowAt indexPath:IndexPath) -> CGFloat
        */
        func tableViewCellEstimatedHeight(forIndexPath indexPath:IndexPath) -> CGFloat
        {
            guard (mDelegate != nil) else {
                fatalError("[UIPheonix] `tableViewCellEstimatedHeight` failed, `mDelegate` is nil!")
            }

            guard let cellModel = displayModel(forSection:indexPath.section, atIndex:indexPath.item) else
            {
                fatalError("[UIPheonix] `tableViewCellEstimatedHeight` failed, `model` is nil!")
            }

            let cellView:UIPBaseTableViewCell = view(forReuseIdentifier:cellModel.nameOfClass)!

            return cellView.estimatedRowHeight
        }
    #elseif os(macOS)
        /**
            Convenience function, use it in your:
            func tableView(_ tableView:NSTableView, viewFor tableColumn:NSTableColumn?, row:Int) -> NSView?
        */
        func tableViewCell(forRow row:Int) -> NSView
        {
            guard (mDelegate != nil) else {
                fatalError("[UIPheonix] `tableViewCell` failed, `mDelegate` is nil!")
            }

            let indexPath = IndexPath(item:row, section:0)
            let cellModel = displayModel(forSection:0, atIndex:row)!
            let cellView:UIPBaseTableViewCell = dequeueView(withReuseIdentifier:cellModel.nameOfClass, forIndexPath:indexPath)!

            _ = cellView.update(withModel:cellModel, delegate:self, tableView:mDelegateTableView!, indexPath:indexPath)

            return cellView
        }

        /**
            Convenience function, use it in your:
            func tableView(_ tableView:NSTableView, heightOfRow row:Int) -> CGFloat
        */
        func tableViewCellHeight(forRow row:Int) -> CGFloat
        {
            guard (mDelegate != nil) else {
                fatalError("[UIPheonix] `tableViewCellHeight` failed, `mDelegate` is nil!")
            }

            let cellModel = displayModel(forSection:0, atIndex:row)!
            let cellView:UIPBaseTableViewCell = view(forReuseIdentifier:cellModel.nameOfClass)!

            return cellView.rowHeight
        }

        /**
            Convenience function, use it in your:
            func tableView(_ tableView:NSTableView, estimatedHeightForRowAt indexPath:IndexPath) -> CGFloat
        */
        func tableViewCellEstimatedHeight(forIndexPath indexPath:IndexPath) -> CGFloat
        {
            guard (mDelegate != nil) else {
                fatalError("[UIPheonix] `tableViewCellEstimatedHeight` failed, `mDelegate` is nil!")
            }

            let cellModel = displayModel(forSection:0, atIndex:indexPath.item)!
            let cellView:UIPBaseTableViewCell = view(forReuseIdentifier:cellModel.nameOfClass)!

            return cellView.estimatedRowHeight
        }
    #endif


    /**
        Dequeue a reusable table view cell view.

        - Parameters:
            - reuseIdentifier: The cell identifier.
            - indexPath: Index path of cell. NOTE! macOS target does not use this `indexPath`.

        - Returns: A table view cell view.
    */
    func dequeueView(withReuseIdentifier reuseIdentifier:String, forIndexPath indexPath:IndexPath) -> UIPBaseTableViewCell?
    {
        guard (mDelegateTableView != nil) else {
            fatalError("[UIPheonix] `view for reuseIdentifier` failed, `mDelegateTableView` is nil!")
        }

        #if os(iOS) || os(tvOS)
            if let cellView = mDelegateTableView!.dequeueReusableCell(withIdentifier:reuseIdentifier, for:indexPath) as? UIPBaseTableViewCell
            {
                return cellView
            }
        #elseif os(macOS)
            if let cellView = mDelegateTableView!.makeView(withIdentifier:NSUserInterfaceItemIdentifier(rawValue:reuseIdentifier), owner:nil) as? UIPBaseTableViewCell
            {
                return cellView
            }
        #endif

        return nil
    }


    /**
        Get a table view cell view.

        - Parameter viewReuseId: The cell identifier.

        - Returns: A table view cell view.
    */
    func view(forReuseIdentifier viewReuseId:String) -> UIPBaseTableViewCell?
    {
        return mViewReuseIds[viewReuseId] as? UIPBaseTableViewCell
    }


    // MARK: - Private


    private func applicationName() -> String
    {
        let appNameAndClassName = NSStringFromClass(UIPheonix.self)                               // i.e. "<AppName>.<ClassName>" = UIPheonix_iOS.UIPheonix
        let appNameAndClassNameArray = appNameAndClassName.split{$0 == "."}.map(String.init)    // = ["UIPheonix_iOS", "UIPheonix"]

        //print(appNameAndClassName)
        //print(appNameAndClassNameArray)

        return appNameAndClassNameArray[0]
    }


    /**
        • Uses the model's name as the cell-view's reuse-id.
        • Registers all cell-views with the delegate view.
    */
    private func connectWithDelegateViewType()
    {
        if (mUIPDelegateViewAppearance == UIPDelegateViewAppearance.collection)
        {
            guard (mDelegateCollectionView != nil) else {
                fatalError("[UIPheonix] `connectWithDelegateViewType` failed, `mDelegateCollectionView` is nil!")
            }
        }
        else if (mUIPDelegateViewAppearance == UIPDelegateViewAppearance.table)
        {
            guard (mDelegateTableView != nil) else {
                fatalError("[UIPheonix] `connectWithDelegateViewType` failed, `mDelegateTableView` is nil!")
            }
        }

        guard (mModelViewRelationships.count != 0) else {
            fatalError("[UIPheonix] Model-View relationships dictionary is empty!")
        }


        var modelClassNames = Array<String>()
        var nibNames = Array<String>()

        for (modelClassName, viewClassName) in mModelViewRelationships
        {
            modelClassNames.append(modelClassName)
            nibNames.append(viewClassName)
        }

        guard (modelClassNames.count == nibNames.count) else {
            fatalError("[UIPheonix] Number of `modelClassNames` & `nibNames` count does not match!")
        }


        for i in 0 ..< modelClassNames.count
        {
            let modelName = modelClassNames[i]
            let nibName = nibNames[i]

            // only add new models/views that have not been registered
            if (mViewReuseIds[modelName] == nil)
            {
                #if os(iOS) || os(tvOS)
                    let nibContents:[Any]? = Bundle.main.loadNibNamed(nibName, owner:nil, options:nil)

                    guard let elementsArray:[Any] = nibContents else {
                        fatalError("[UIPheonix] Nib could not be loaded #1: \(nibName)")
                    }
                #elseif os(macOS)
                    var array:NSArray? = NSArray()
                    let nibContents:AutoreleasingUnsafeMutablePointer<NSArray?>? = AutoreleasingUnsafeMutablePointer<NSArray?>?(&array)

                    let isNibLoaded = Bundle.main.loadNibNamed(NSNib.Name(nibName), owner:nil, topLevelObjects:nibContents)

                    guard (isNibLoaded) else {
                        fatalError("[UIPheonix] Nib could not be loaded #1: \(nibName)")
                    }

                    guard let nibElements:AutoreleasingUnsafeMutablePointer<NSArray?> = nibContents else {
                        fatalError("[UIPheonix] Nib could not be loaded #2: \(nibName)")
                    }

                    guard let elementsArray:NSArray = nibElements.pointee else {
                        fatalError("[UIPheonix] Nib could not be loaded #3: \(nibName)")
                    }
                #endif

                guard (elementsArray.count > 0) else {
                    fatalError("[UIPheonix] Nib is empty: \(nibName)")
                }


                // find the element we are looking for, since the xib contents order is not guaranteed
                let filteredNibContents:[Any] = elementsArray.filter(
                {
                    (element:Any) -> Bool in
                    return (String(describing:type(of:element)) == nibName)
                })

                guard (filteredNibContents.count == 1) else {
                    fatalError("[UIPheonix] Nib \"\(nibName)\" contains more elements, expected only 1!")
                }


                // with the reuse-id, connect the cell-view in the nib
                #if os(iOS) || os(tvOS)
                    mViewReuseIds[modelName] = nibContents!.first
                #elseif os(macOS)
                    mViewReuseIds[modelName] = filteredNibContents.first
                #endif

                // register nib with the delegate collection view
                #if os(iOS) || os(tvOS)
                    let nib = UINib(nibName:nibName, bundle:nil)

                    if (mUIPDelegateViewAppearance == UIPDelegateViewAppearance.collection)
                    {
                        mDelegateCollectionView!.register(nib, forCellWithReuseIdentifier:modelName)
                    }
                    else if (mUIPDelegateViewAppearance == UIPDelegateViewAppearance.table)
                    {
                        mDelegateTableView!.register(nib, forCellReuseIdentifier:modelName)
                    }
                #elseif os(macOS)
                    let nib = NSNib(nibNamed:NSNib.Name(nibName), bundle:nil)

                    guard (nib != nil) else {
                        fatalError("[UIPheonix] Nib could not be instantiated: \(nibName)")
                    }

                    if (mUIPDelegateViewAppearance == UIPDelegateViewAppearance.collection)
                    {
                        mDelegateCollectionView!.register(nib, forItemWithIdentifier:NSUserInterfaceItemIdentifier(rawValue:modelName))
                    }
                    else if (mUIPDelegateViewAppearance == UIPDelegateViewAppearance.table)
                    {
                        mDelegateTableView!.register(nib, forIdentifier:NSUserInterfaceItemIdentifier(rawValue:modelName))
                    }
                #endif
            }
        }
    }
}


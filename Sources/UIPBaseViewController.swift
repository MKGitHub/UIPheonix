//----------------------------------------------------------------------------------------------------
// MARK:- UIPBaseViewController.swift
// MARK:-
//----------------------------------------------------------------------------------------------------
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


///
/// The base view controller protocol.
///
protocol UIPBaseViewControllerProtocol:class
{
    // We can't use "className" because that belongs to Objective-C NSObject. //

    /// Name of this class.
    var nameOfClass:String { get }

    /// Name of this class (static context).
    static var nameOfClass:String { get }
}


#if os(iOS) || os(tvOS)

    ///
    /// The base view controller. Subclass this to gain its features.
    /// Example code is provided in this file.
    ///
    class UIPBaseViewController:UIViewController, UIPBaseViewControllerProtocol
    {
        ///
        /// We have to implement this because we use `self` in the `newInstance` function.
        ///
        override required public init(nibName nibNameOrNil:String?, bundle nibBundleOrNil:Bundle?)
        {
            super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
        }


        ///
        /// We have to implement this because we use `self` in the `newInstance` function.
        ///
        required public init?(coder aDecoder:NSCoder)
        {
            super.init(coder:aDecoder)
        }


        // MARK: UIPBaseViewControllerProtocol


        /// Name of this class.
        var nameOfClass:String { get { return "\(type(of:self))" } }

        /// Name of this class (static context).
        static var nameOfClass:String { get { return "\(self)" } }

        // MARK: Public Members
        var newInstanceAttributes:Dictionary<String, Any> = Dictionary<String, Any>()

        // MARK: Public Weak References
        weak var parentVC:UIPBaseViewController?


        // MARK: Life Cycle


        ///
        /// Example implementation, copy & paste into your concrete class.
        ///
        /// Create a new instance of this view controller
        /// with attributes
        /// and a parent view controller for sending attributes back.
        ///
        class func newInstance<T:UIPBaseViewController>(with attributes:Dictionary<String, Any>, parentViewController:UIPBaseViewController?)
        -> T
        {
            // with nib
            guard let vc:T = self.init(nibName:"\(self)", bundle:nil) as? T else
            {
                fatalError("[UIPheonix] New instance of type '\(self)' failed to init!")
            }

            // init members
            vc.newInstanceAttributes = attributes
            vc.parentVC = parentViewController

            return vc 
        }


        ///
        /// This view controller is about to be dismissed.
        /// The child view controller should implement this to send data back to its parent view controller.
        ///
        /// - Returns: A dictionary for our parent view controller, default nil.
        ///
        func dismissInstance() -> Dictionary<String, Any>?
        {
            // by default we return nil
            return nil
        }


        override func willMove(toParentViewController parent:UIViewController?)
        {
            super.willMove(toParentViewController:parent)

            // `self` view controller is being removed
            // i.e. we are moving to our parent
            if (parent == nil)
            {
                if let parentVC = parentVC,
                   let dict:Dictionary<String, Any> = dismissInstance()
                {
                    parentVC.childViewController(self, willDismissWithAttributes:dict)
                }
            }
        }


        ///
        /// Assuming that this view controller is a parent, then its child is about to be dismissed.
        /// The parent view controller should implement this to receive data back from its child view controller.
        ///
        func childViewController(_ childViewController:UIPBaseViewController, willDismissWithAttributes attributes:Dictionary<String, Any>)
        {
            fatalError("[UIPheonix] You must override \(#function) in your subclass!")
        }
    }

#elseif os(macOS)

    ///
    /// The base view controller. Subclass this to gain its features.
    /// Example code is provided in this file.
    ///
    class UIPBaseViewController:NSViewController, UIPBaseViewControllerProtocol
    {
        ///
        /// We have to implement this because we use `self` in the `newInstance` function.
        ///
        override required public init?(nibName nibNameOrNil:String?, bundle nibBundleOrNil:Bundle?)
        {
            super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
        }


        ///
        /// We have to implement this because we use `self` in the `newInstance` function.
        ///
        required public init?(coder aDecoder:NSCoder)
        {
            super.init(coder:aDecoder)
        }


        // MARK: UIPBaseViewControllerProtocol


        /// Name of this class.
        var nameOfClass:String { get { return "\(type(of:self))" } }

        /// Name of this class (static context).
        static var nameOfClass:String { get { return "\(self)" } }

        // MARK: Public Members
        var newInstanceAttributes:Dictionary<String, Any> = Dictionary<String, Any>()


        // MARK: Life Cycle


        ///
        /// Example implementation, copy & paste into your concrete class.
        ///
        /// Create a new instance of this view controller
        /// with attributes
        /// and a parent view controller for sending attributes back.
        ///
        class func newInstance<T:UIPBaseViewController>(with attributes:Dictionary<String, Any>, parentViewController:UIPBaseViewController?)
        -> T
        {
            // with nib
            guard let vc:T = self.init(nibName:"\(self)", bundle:nil) as? T else
            {
                fatalError("[UIPheonix] New instance of type '\(self)' failed to init!")
            }

            // init members
            vc.newInstanceAttributes = attributes

            return vc
        }
    }

#endif


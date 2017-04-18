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

    ///
    /// Create a new instance of a view controller with provided dictionary to initialize its contents.
    ///
    /// - Parameter attributes: Dictionary with attributes.
    /// - Returns: A new instance of the view controller.
    ///
    //static func newInstance<T:UIPBaseViewControllerProtocol>(with attributes:Dictionary<String, Any>) -> T
}


#if os(iOS) || os(tvOS)

    ///
    /// The base view controller. Subclass this to gain its features.
    /// Example code is provided in this file.
    ///
    class UIPBaseViewController:UIViewController, UIPBaseViewControllerProtocol
    {
        // MARK: UIPBaseViewControllerProtocol


        /// Name of this class.
        var nameOfClass:String { get { return "\(type(of:self))" } }

        /// Name of this class (static context).
        static var nameOfClass:String { get { return "\(self)" } }


        // MARK: Private Members
        var mNewInstanceAttributes:Dictionary<String, Any> = Dictionary<String, Any>()    /// The provided dictionary with attributes when the view controller was instanced.


        // MARK: Life Cycle


        ///
        /// Example implementation, copy & paste into your concrete class.
        ///
        /// Create a new instance of self with nib.
        ///
        class func newInstance<T:UIPBaseViewController>(with attributes:Dictionary<String, Any>)
        -> T
        {
            let vc:UIPBaseViewController = UIPBaseViewController.init(nibName:"\(self)", bundle:nil)

            // init member
            vc.mNewInstanceAttributes = attributes

            return vc as! T
        }
    }

#elseif os(macOS)

    ///
    /// The base view controller. Subclass this to gain its features.
    /// Example code is provided in this file.
    ///
    class UIPBaseViewController:NSViewController, UIPBaseViewControllerProtocol
    {
        // MARK: UIPBaseViewControllerProtocol


        /// Name of this class.
        var nameOfClass:String { get { return "\(type(of:self))" } }

        /// Name of this class (static context).
        static var nameOfClass:String { get { return "\(self)" } }


        // MARK: Private Members
        var mNewInstanceAttributes:Dictionary<String, Any> = Dictionary<String, Any>()    /// The provided dictionary with attributes when the view controller was instanced.


        // MARK: Life Cycle


        ///
        /// Example implementation, copy & paste into your concrete class.
        ///
        /// Create a new instance of self with nib.
        ///
        class func newInstance<T:UIPBaseViewController>(with attributes:Dictionary<String, Any>)
        -> T
        {
            guard let vc:UIPBaseViewController = UIPBaseViewController.init(nibName:"\(self)", bundle:nil) else
            {
                fatalError("[UIPheonix] `newInstance` failed, could not create new instance of \"\(self)\" from nib!")
            }

            // init member
            vc.mNewInstanceAttributes = attributes

            return vc as! T
        }
    }

#endif


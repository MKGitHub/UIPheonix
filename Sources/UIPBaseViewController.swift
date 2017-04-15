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
protocol UIPBaseViewControllerProtocol
{
    ///
    /// Create a new instance of a view controller with provided dictionary to initialize its contents.
    ///
    /// - Parameter attributes: Dictionary with attributes.
    /// - Returns: A new instance of the view controller.
    ///
    static func newInstance<T:UIPBaseViewControllerProtocol>(with attributes:Dictionary<String, Any>) -> T
}


#if os(iOS) || os(tvOS)

    ///
    /// The base view controller. Subclass this to gain its features.
    /// Example code is provided in this file.
    ///
    class UIPBaseViewController:UIViewController
    {
        /// The provided dictionary with attributes when the view controller was instanced.
        var mNewInstanceAttributes:Dictionary<String, Any> = Dictionary<String, Any>()


        /*
            Example implementation, copy & paste into your concrete class.

            ///
            /// Create a new instance of self with nib.
            ///
            static func newInstance<T:UIPBaseViewControllerProtocol>(with attributes:Dictionary<String, Any>)
            -> T
            {
                let vc:FooBarViewController = FooBarViewController.init(nibName:"\(self)", bundle:nil)

                // init member
                vc.mNewInstanceAttributes = attributes

                return vc as! T
            }
        */
    }

#elseif os(macOS)

    ///
    /// The base view controller. Subclass this to gain its features.
    /// Example code is provided in this file.
    ///
    class UIPBaseViewController:NSViewController
    {
        /// The provided dictionary with attributes when the view controller was instanced.
        var mNewInstanceAttributes:Dictionary<String, Any> = Dictionary<String, Any>()


        /*
            Example implementation, copy & paste into your concrete class.

            ///
            /// Create a new instance of self with nib.
            ///
            static func newInstance<T:UIPBaseViewControllerProtocol>(with attributes:Dictionary<String, Any>)
            -> T
            {
                let vc:FooBarViewController = FooBarViewController.init(nibName:"\(self)", bundle:nil)

                // init member
                vc.mNewInstanceAttributes = attributes

                return vc as! T
            }
        */
    }

#endif


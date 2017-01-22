//----------------------------------------------------------------------------------------------------
// MARK:- UIPBaseTableViewCellProtocol.swift
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

import Foundation
import CoreGraphics


///
/// The standard protocol for all table view cell views.
///
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

    ///
    /// Update the cell view with a model.
    ///
    /// - Parameters:
    ///   - model: The model to update the cell view with.
    ///   - delegate: The delegate, if any actions are required to handle.
    ///   - indexPath: Index path of the cell view.
    ///
    func update(with model:Any, delegate:Any, for indexPath:IndexPath)
}


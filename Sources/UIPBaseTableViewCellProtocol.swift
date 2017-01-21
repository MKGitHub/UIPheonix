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


protocol UIPBaseTableViewCellProtocol:class
{
    // we can't use "className" because that belongs to Objective-C NSObject
    var nameOfClass:String { get }
    static var nameOfClass:String { get }

    var rowHeight:CGFloat { get }
    var estimatedRowHeight:CGFloat { get }

    func update(with model:Any, delegate:Any, for indexPath:IndexPath)
}


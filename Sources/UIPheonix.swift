//----------------------------------------------------------------------------------------------------
// MARK:- UIPheonix.swift
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

import CoreGraphics

#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(macOS)
    import Cocoa
#endif


fileprivate enum UIPDelegateViewType
{
    case collection
    case table
}


///
/// The core class of UIPheonix.
///
@available(OSX 10.11, iOS 9.0, tvOS 9.0, *)
final class UIPheonix
{
    // MARK: Private Members (uninitialized)
    fileprivate var mApplicationNameDot:String!
    fileprivate var mUIPDelegateViewType:UIPDelegateViewType!

    // (initialized as empty for convenience)
    fileprivate var mModelViewRelationships:Dictionary<String, String> = Dictionary<String, String>()
    fileprivate var mViewReuseIds:Dictionary<String, Any> = Dictionary<String, Any>()
    fileprivate var mDisplayModels:Dictionary<Int, Array<UIPBaseCellModelProtocol>> = Dictionary<Int, Array<UIPBaseCellModelProtocol>>()

    // MARK: Private Weak Reference
    fileprivate weak var mDelegate:AnyObject?
    fileprivate weak var mDelegateCollectionView:UIPPlatformCollectionView?
    fileprivate weak var mDelegateTableView:UIPPlatformTableView?


    // MARK:- Life Cycle


    ///
    /// Init for UICollectionView.
    ///
    /// - Parameters:
    ///   - collectionView: The collection view.
    ///
    init(with collectionView:UIPPlatformCollectionView?, delegate:AnyObject?)
    {
        // init members
        mUIPDelegateViewType = UIPDelegateViewType.collection
        mApplicationNameDot = getApplicationName() + "."

        mDelegateCollectionView = collectionView
        mDelegate = delegate
    }


    ///
    /// Init for UITableView.
    ///
    /// - Parameters:
    ///   - tableView: The table view.
    ///
    init(with tableView:UIPPlatformTableView?, delegate:AnyObject?)
    {
        // init members
        mUIPDelegateViewType = UIPDelegateViewType.table
        mApplicationNameDot = getApplicationName() + "."

        mDelegateTableView = tableView
        mDelegate = delegate
    }


    // MARK:- Model-View Relationships


    ///
    /// Creates relationships between models and views.
    ///
    /// - Parameter dictionary: A dictionary with model-name:view-name relationship.
    ///
    func setModelViewRelationships(_ dictionary:Dictionary<String, String>)
    {
        guard (dictionary.count != 0) else {
            fatalError("[UIPheonix] Can't set model-view relationships with dictionary because it is empty!")
        }

        mModelViewRelationships = dictionary

        connectWithDelegateViewType()
    }


    // MARK:- Display Models


    ///
    /// Set/Append the models to display for a Collection View or Table View.
    ///
    /// - Parameters:
    ///   - rawModelsArray: An array containing dictionary objects with model data.
    ///   - section: The section in which the models you want to set.
    ///   - append: Append to, or replace, the current model list.
    ///
    func setDisplayModels(_ dictionaryObjectsArray:Array<Any>, forSection section:Int, append:Bool)
    {
        guard (dictionaryObjectsArray.count != 0) else {
            fatalError("[UIPheonix] Raw model data array is empty!")
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
        var groupModels:Array<UIPBaseCellModelProtocol> = Array<UIPBaseCellModelProtocol>()

        for aModelType:Any in dictionaryObjectsArray
        {
            let modelDict:Dictionary<String, Any> = aModelType as! Dictionary<String, Any>
            let modelTypeName:String? = modelDict[UIPConstants.modelType] as? String

            // `type` field does not exist
            if (modelTypeName == nil) {
                fatalError("[UIPheonix] The key `type` was not found for the model `\(aModelType)`!")
            }

            // create models
            if let modelClassType:UIPBaseCellModelProtocol.Type = NSClassFromString(mApplicationNameDot + modelTypeName!) as? UIPBaseCellModelProtocol.Type
            {
                let aModelObj:UIPBaseCellModelProtocol = modelClassType.init()
                aModelObj.setContents(with:modelDict)

                groupModels.append(aModelObj)
            }
        }

        // add models to group
        mDisplayModels[section] = groupModels
    }


    ///
    /// Sets the models to display for a Collection View or Table View.
    ///
    /// - Parameters:
    ///   - array: An array containing dictionary objects with model data.
    ///   - section: The section in which the models you want to set.
    ///
    func setDisplayModels(_ array:Array<UIPBaseCellModelProtocol>, forSection section:Int)
    {
        mDisplayModels[section] = array
    }


    ///
    /// Append the models to display for a Collection View or Table View.
    ///
    /// - Parameters:
    ///   - array: An array containing dictionary objects with model data.
    ///   - section: The section in which the models you want to add.
    ///
    func addDisplayModels(_ array:Array<UIPBaseCellModelProtocol>, forSection section:Int)
    {
        if var currentGroupModels:Array<UIPBaseCellModelProtocol> = mDisplayModels[section]
        {
            currentGroupModels.append(contentsOf:array)

            mDisplayModels[section] = currentGroupModels
        }
        else
        {
            fatalError("[UIPheonix] Section '\(section)' does not exist!")
        }
    }


    ///
    /// - Parameters:
    ///   - section: The section for which the models you want to get.
    ///
    /// - Returns: Array containing models.
    ///
    func displayModels(forSection section:Int) -> Array<UIPBaseCellModelProtocol>
    {
        if let currentGroupModels:Array<UIPBaseCellModelProtocol> = mDisplayModels[section]
        {
            return currentGroupModels
        }
        else
        {
            fatalError("[UIPheonix] Section '\(section)' does not exist!")
        }
    }


    ///
    /// - Parameters:
    ///   - section: The section for which the models you want to count.
    ///
    /// - Returns: The number of models.
    ///
    func displayModelsCount(forSection section:Int) -> Int
    {
        if let currentGroupModels:Array<UIPBaseCellModelProtocol> = mDisplayModels[section]
        {
            return currentGroupModels.count
        }

        return 0
    }


    ///
    /// - Parameters:
    ///   - section: The section in which a specific model you want to get.
    ///   - index: The index of the model.
    ///
    /// - Returns: The model.
    ///
    func displayModel(forSection section:Int, atIndex index:Int) -> UIPBaseCellModel?
    {
        if let currentGroupModels:Array<UIPBaseCellModelProtocol> = mDisplayModels[section]
        {
            if let cellModel:UIPBaseCellModel = currentGroupModels[index] as? UIPBaseCellModel
            {
                return cellModel
            }
        }

        return nil
    }


    // MARK:- UICollectionView


    ///
    /// Call this after setting content on the cell to have a fitting layout size returned.
    /// **Note!** The cell's size is determined using Auto Layout & constraints.
    ///
    /// - Parameters:
    ///   - cell: The cell.
    ///   - preferredWidth: The preferred width of the cell.
    /// - Returns: A size.
    ///
    @inline(__always)
    class func calculateLayoutSizeForCell(_ cell:UIPPlatformCollectionViewCell, preferredWidth:CGFloat)
    -> CGSize
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
            size = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
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


    ///
    /// Use the base size and add or subtract another size.
    ///
    /// - Parameters:
    ///   - baseSize: Base size.
    ///   - addedSize: Added or subtract size.
    /// - Returns: The new size.
    ///
    @inline(__always)
    class func viewSize(usingBaseSize baseSize:CGSize, addedSize:UIPCellSize)
    -> CGSize
    {
        // by default, we use the cells layout size
        var finalSize:CGSize = baseSize

        // Replace or add/subtract size. //

        // width
        if (addedSize.absoluteWidth)
        {
            finalSize.width = addedSize.width
        }
        else
        {
            finalSize.width += addedSize.width
        }

        // height
        if (addedSize.absoluteHeight)
        {
            finalSize.height = addedSize.height
        }
        else
        {
            finalSize.height += addedSize.height
        }

        return finalSize
    }


    ///
    /// Dequeue a reusable collection view cell view.
    ///
    /// - Parameters:
    ///   - reuseIdentifier: The cell identifier.
    ///   - indexPath: Index path of cell.
    /// - Returns: A collection view cell view.
    ///
    func dequeueView(withReuseIdentifier reuseIdentifier:String, forIndexPath indexPath:IndexPath)
    -> UIPBaseCollectionViewCell?
    {
        guard (mDelegateCollectionView != nil) else {
            fatalError("[UIPheonix] `dequeueView` failed, `mDelegateCollectionView` is nil!")
        }

        #if os(iOS) || os(tvOS)
            if let cellView:UIPBaseCollectionViewCell = mDelegateCollectionView!.dequeueReusableCell(withReuseIdentifier:reuseIdentifier, for:indexPath) as? UIPBaseCollectionViewCell
            {
                return cellView
            }
        #elseif os(macOS)
            if let cellView:UIPBaseCollectionViewCell = mDelegateCollectionView!.makeItem(withIdentifier:NSUserInterfaceItemIdentifier(rawValue:reuseIdentifier), for:indexPath) as? UIPBaseCollectionViewCell
            {
                return cellView
            }
        #endif

        return nil
    }


    ///
    /// Get a collection view cell view.
    ///
    /// - Parameter viewReuseId: The cell identifier.
    /// - Returns: A collection view cell view.
    ///
    func view(forReuseIdentifier viewReuseId:String) -> UIPBaseCollectionViewCell?
    {
        return mViewReuseIds[viewReuseId] as? UIPBaseCollectionViewCell
    }


    #if os(iOS) || os(tvOS)
        ///
        /// Convenience function, use it in your:
        ///
        /// func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
        ///
        func collectionViewCell(forIndexPath indexPath:IndexPath) -> UICollectionViewCell
        {
            guard (mDelegate != nil) else {
                fatalError("[UIPheonix] `collectionViewCell` failed, `mDelegate` is nil!")
            }

            guard let cellModel:UIPBaseCellModel = displayModel(forSection:indexPath.section, atIndex:indexPath.item) else
            {
                fatalError("[UIPheonix] `collectionViewCell` failed, `model` is nil!")
            }

            let cellView:UIPBaseCollectionViewCell = dequeueView(withReuseIdentifier:cellModel.nameOfClass, forIndexPath:indexPath)!
            let _:UIPCellSize = cellView.update(withModel:cellModel, delegate:mDelegate!, forIndexPath:indexPath)

            cellView.layoutIfNeeded()

            return cellView
        }

        ///
        /// Convenience function, use it in your:
        ///
        /// func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
        ///
        func collectionViewCellSize(forIndexPath indexPath:IndexPath, preferredWidth:CGFloat)
        -> CGSize
        {
            guard (mDelegate != nil) else {
                fatalError("[UIPheonix] `collectionViewCellSize` failed, `mDelegate` is nil!")
            }

            guard (mDelegateCollectionView != nil) else {
                fatalError("[UIPheonix] `collectionViewCellSize` failed, `mDelegateCollectionView` is nil!")
            }

            guard let cellModel:UIPBaseCellModel = displayModel(forSection:indexPath.section, atIndex:indexPath.item) else
            {
                fatalError("[UIPheonix] `collectionViewCell` failed, `model` is nil!")
            }

            let cellView:UIPBaseCollectionViewCell = view(forReuseIdentifier:cellModel.nameOfClass)!
            let modelCellSize:UIPCellSize = cellView.update(withModel:cellModel, delegate:mDelegate!, forIndexPath:indexPath)
            let layoutCellSize:CGSize = UIPheonix.calculateLayoutSizeForCell(cellView, preferredWidth:preferredWidth)

            return UIPheonix.viewSize(usingBaseSize:layoutCellSize, addedSize:modelCellSize)
        }
    #elseif os(macOS)
        ///
        /// Convenience function, use it in your:
        ///
        /// func collectionView(_ collectionView:NSCollectionView, itemForRepresentedObjectAt indexPath:IndexPath) -> NSCollectionViewItem
        ///
        func collectionViewItem(forIndexPath indexPath:IndexPath) -> NSCollectionViewItem
        {
            guard (mDelegate != nil) else {
                fatalError("[UIPheonix] `collectionViewCellSize` failed, `mDelegate` is nil!")
            }

            guard (mDelegateCollectionView != nil) else {
                fatalError("[UIPheonix] `collectionViewCellSize` failed, `mDelegateCollectionView` is nil!")
            }

            let cellModel:UIPBaseCellModel = displayModel(forSection:0, atIndex:indexPath.item)!
            let cellView:UIPBaseCollectionViewCell = dequeueView(withReuseIdentifier:cellModel.nameOfClass, forIndexPath:indexPath)!
            let _:UIPCellSize = cellView.update(withModel:cellModel, delegate:mDelegate!, forIndexPath:indexPath)

            return cellView
        }

        ///
        /// Convenience function, use it in your:
        ///
        /// func collectionView(_ collectionView:NSCollectionView, layout collectionViewLayout:NSCollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
        ///
        func collectionViewItemSize(forIndexPath indexPath:IndexPath, preferredWidth:CGFloat)
        -> CGSize
        {
            guard (mDelegate != nil) else {
                fatalError("[UIPheonix] `collectionViewCellSize` failed, `mDelegate` is nil!")
            }

            guard (mDelegateCollectionView != nil) else {
                fatalError("[UIPheonix] `collectionViewCellSize` failed, `mDelegateCollectionView` is nil!")
            }

            let cellModel:UIPBaseCellModel = displayModel(forSection:0, atIndex:indexPath.item)!
            let cellView:UIPBaseCollectionViewCell = view(forReuseIdentifier:cellModel.nameOfClass)!
            let modelCellSize:UIPCellSize = cellView.update(withModel:cellModel, delegate:mDelegate!, forIndexPath:indexPath)
            let layoutCellSize:CGSize = UIPheonix.calculateLayoutSizeForCell(cellView, preferredWidth:preferredWidth)

            return UIPheonix.viewSize(usingBaseSize:layoutCellSize, addedSize:modelCellSize)
        }
    #endif


    // MARK:- UITableView


    #if os(iOS) || os(tvOS)
        ///
        /// Convenience function, use it in your:
        ///
        /// func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell
        ///
        func tableViewCell(forIndexPath indexPath:IndexPath, delegate:Any) -> UITableViewCell
        {
            guard (mDelegate != nil) else {
                fatalError("[UIPheonix] `tableViewCell` failed, `mDelegate` is nil!")
            }

            guard let cellModel:UIPBaseCellModel = displayModel(forSection:indexPath.section, atIndex:indexPath.item) else
            {
                fatalError("[UIPheonix] `collectionViewCell` failed, `model` is nil!")
            }

            let cellView:UIPBaseTableViewCell = dequeueView(withReuseIdentifier:cellModel.nameOfClass, forIndexPath:indexPath)!

            cellView.update(with:cellModel, delegate:delegate, for:indexPath)

            return cellView
        }

        ///
        /// Convenience function, use it in your:
        ///
        /// func tableView(_ tableView:UITableView, heightForRowAt indexPath:IndexPath) -> CGFloat
        ///
        func tableViewCellHeight(forIndexPath indexPath:IndexPath) -> CGFloat
        {
            guard (mDelegate != nil) else {
                fatalError("[UIPheonix] `tableViewCellHeight` failed, `mDelegate` is nil!")
            }

            guard let cellModel:UIPBaseCellModel = displayModel(forSection:indexPath.section, atIndex:indexPath.item) else
            {
                fatalError("[UIPheonix] `collectionViewCell` failed, `model` is nil!")
            }

            let cellView:UIPBaseTableViewCell = view(forReuseIdentifier:cellModel.nameOfClass)!

            return cellView.rowHeight
        }

        ///
        /// Convenience function, use it in your:
        ///
        /// func tableView(_ tableView:UITableView, estimatedHeightForRowAt indexPath:IndexPath) -> CGFloat
        ///
        func tableViewCellEstimatedHeight(forIndexPath indexPath:IndexPath) -> CGFloat
        {
            guard (mDelegate != nil) else {
                fatalError("[UIPheonix] `tableViewCellEstimatedHeight` failed, `mDelegate` is nil!")
            }

            guard let cellModel:UIPBaseCellModel = displayModel(forSection:indexPath.section, atIndex:indexPath.item) else
            {
                fatalError("[UIPheonix] `collectionViewCell` failed, `model` is nil!")
            }

            let cellView:UIPBaseTableViewCell = view(forReuseIdentifier:cellModel.nameOfClass)!

            return cellView.estimatedRowHeight
        }
    #elseif os(macOS)
        ///
        /// Convenience function, use it in your:
        ///
        /// func tableView(_ tableView:NSTableView, viewFor tableColumn:NSTableColumn?, row:Int) -> NSView?
        ///
        func tableViewCell(forRow row:Int) -> NSView
        {
            guard (mDelegate != nil) else {
                fatalError("[UIPheonix] `tableViewCell` failed, `mDelegate` is nil!")
            }

            let indexPath:IndexPath = IndexPath(item:row, section:0)
            let cellModel:UIPBaseCellModel = displayModel(forSection:0, atIndex:row)!
            let cellView:UIPBaseTableViewCell = dequeueView(withReuseIdentifier:cellModel.nameOfClass, forIndexPath:indexPath)!

            cellView.update(with:cellModel, delegate:self, for:indexPath)

            return cellView
        }

        ///
        /// Convenience function, use it in your:
        ///
        /// func tableView(_ tableView:NSTableView, heightOfRow row:Int) -> CGFloat
        ///
        func tableViewCellHeight(forRow row:Int) -> CGFloat
        {
            guard (mDelegate != nil) else {
                fatalError("[UIPheonix] `tableViewCellHeight` failed, `mDelegate` is nil!")
            }

            let cellModel:UIPBaseCellModel = displayModel(forSection:0, atIndex:row)!
            let cellView:UIPBaseTableViewCell = view(forReuseIdentifier:cellModel.nameOfClass)!

            return cellView.rowHeight
        }

        ///
        /// Convenience function, use it in your:
        ///
        /// func tableView(_ tableView:NSTableView, estimatedHeightForRowAt indexPath:IndexPath) -> CGFloat
        ///
        func tableViewCellEstimatedHeight(forIndexPath indexPath:IndexPath) -> CGFloat
        {
            guard (mDelegate != nil) else {
                fatalError("[UIPheonix] `tableViewCellEstimatedHeight` failed, `mDelegate` is nil!")
            }

            let cellModel:UIPBaseCellModel = displayModel(forSection:0, atIndex:indexPath.item)!
            let cellView:UIPBaseTableViewCell = view(forReuseIdentifier:cellModel.nameOfClass)!

            return cellView.estimatedRowHeight
        }
    #endif


    ///
    /// Dequeue a reusable table view cell view.
    ///
    /// - Parameters:
    ///   - reuseIdentifier: The cell identifier.
    ///   - indexPath: Index path of cell. NOTE! macOS target does not use this `indexPath`.
    /// - Returns: A table view cell view.
    ///
    func dequeueView(withReuseIdentifier reuseIdentifier:String, forIndexPath indexPath:IndexPath)
    -> UIPBaseTableViewCell?
    {
        guard (mDelegateTableView != nil) else {
            fatalError("[UIPheonix] `view for reuseIdentifier` failed, `mDelegateTableView` is nil!")
        }

        #if os(iOS) || os(tvOS)
            if let cellView:UIPBaseTableViewCell = mDelegateTableView!.dequeueReusableCell(withIdentifier:reuseIdentifier, for:indexPath) as? UIPBaseTableViewCell
            {
                return cellView
            }
        #elseif os(macOS)
            if let cellView:UIPBaseTableViewCell = mDelegateTableView!.makeView(withIdentifier:NSUserInterfaceItemIdentifier(rawValue:reuseIdentifier), owner:nil) as? UIPBaseTableViewCell
            {
                return cellView
            }
        #endif

        return nil
    }


    ///
    /// Get a table view cell view.
    ///
    /// - Parameter viewReuseId: The cell identifier.
    /// - Returns: A table view cell view.
    ///
    func view(forReuseIdentifier viewReuseId:String) -> UIPBaseTableViewCell?
    {
        return mViewReuseIds[viewReuseId] as? UIPBaseTableViewCell
    }


    // MARK:- Private


    fileprivate func getApplicationName() -> String
    {
        let appNameAndClassName:String = NSStringFromClass(UIPheonix.self)                                          // i.e. "<AppName>.<ClassName>" = UIPheonix_iOS.UIPheonix
        let appNameAndClassNameArray:[String] = appNameAndClassName.characters.split{$0 == "."}.map(String.init)    // = ["UIPheonix_iOS", "UIPheonix"]

        //print(appNameAndClassName)
        //print(appNameAndClassNameArray)

        return appNameAndClassNameArray[0]
    }


    ///
    /// * Uses the model's name as the cell-view's reuse-id.
    /// * Registers all cell-views with the delegate view.
    ///
    fileprivate func connectWithDelegateViewType()
    {
        if (mUIPDelegateViewType == UIPDelegateViewType.collection)
        {
            guard (mDelegateCollectionView != nil) else {
                fatalError("[UIPheonix] `connectWithDelegateViewType` failed, `mDelegateCollectionView` is nil!")
            }
        }
        else if (mUIPDelegateViewType == UIPDelegateViewType.table)
        {
            guard (mDelegateTableView != nil) else {
                fatalError("[UIPheonix] `connectWithDelegateViewType` failed, `mDelegateTableView` is nil!")
            }
        }

        guard (mModelViewRelationships.count != 0) else {
            fatalError("[UIPheonix] Model-View relationships dictionary is empty!")
        }


        var modelClassNames:Array<String> = Array<String>()
        var nibNames:Array<String> = Array<String>()

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
            let modelName:String = modelClassNames[i]
            let nibName:String = nibNames[i]

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

                    let isNibLoaded:Bool = Bundle.main.loadNibNamed(NSNib.Name(rawValue:nibName), owner:nil, topLevelObjects:nibContents)

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
                    let nib:UINib = UINib(nibName:nibName, bundle:nil)

                    if (mUIPDelegateViewType == UIPDelegateViewType.collection)
                    {
                        mDelegateCollectionView!.register(nib, forCellWithReuseIdentifier:modelName)
                    }
                    else if (mUIPDelegateViewType == UIPDelegateViewType.table)
                    {
                        mDelegateTableView!.register(nib, forCellReuseIdentifier:modelName)
                    }
                #elseif os(macOS)
                    let nib:NSNib? = NSNib(nibNamed:NSNib.Name(rawValue:nibName), bundle:nil)

                    guard (nib != nil) else {
                        fatalError("[UIPheonix] Nib could not be instantiated: \(nibName)")
                    }

                    if (mUIPDelegateViewType == UIPDelegateViewType.collection)
                    {
                        mDelegateCollectionView!.register(nib, forItemWithIdentifier:NSUserInterfaceItemIdentifier(rawValue:modelName))
                    }
                    else if (mUIPDelegateViewType == UIPDelegateViewType.table)
                    {
                        mDelegateTableView!.register(nib, forIdentifier:NSUserInterfaceItemIdentifier(rawValue:modelName))
                    }
                #endif
            }
        }
    }
}


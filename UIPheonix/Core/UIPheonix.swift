//
//  UIPheonix
//  Copyright © 2016 Mohsan Khan. All rights reserved.
//

//
//  https://github.com/MKGitHub/UIPheonix
//  http://www.xybernic.com
//  http://www.khanofsweden.com
//

//
//  Copyright 2016 Mohsan Khan
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
    //case table
    //case stack
}


final class UIPheonix
{
    // MARK: Private Members (uninitialized)
    fileprivate var mApplicationNameDot:String!
    fileprivate var mUIPDelegateViewType:UIPDelegateViewType!

    // (initialized as empty for convenience)
    fileprivate var mDisplayDictionary:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
    fileprivate var mViewReuseIds:Dictionary<String, Any> = Dictionary<String, Any>()
    fileprivate var mUIDisplayList:Array<UIPInstantiatable> = Array<UIPInstantiatable>()

    // MARK: Private Weak Reference
    fileprivate weak var mDelegate:UIPDelegate?
    fileprivate weak var mDelegateCollectionView:UIPPlatformCollectionView?


    // MARK:- Life Cycle


    ///
    /// Init for UICollectionView.
    ///
    init(delegate:UIPDelegate?, collectionView:UIPPlatformCollectionView?, displayDictionary:Dictionary<String, AnyObject>)
    {
        // init members
        mUIPDelegateViewType = UIPDelegateViewType.collection
        mApplicationNameDot = getApplicationName() + "."

        mDelegate = delegate
        mDelegateCollectionView = collectionView
        mDisplayDictionary = displayDictionary

        // connect & display
        connectCollectionView()
        createDisplayList(append:false)
    }


    // MARK:- JSON


    ///
    /// Convenience JSON file loader.
    ///
    class func loadJSONFile(_ filePath:String)
    -> Dictionary<String, AnyObject>?
    {
        if let jsonFilePath:String = Bundle.main.path(forResource:filePath, ofType:"json")
        {
            do
            {
                let fileUrl:URL = URL(fileURLWithPath:jsonFilePath)
                let jsonData:Data = try Data(contentsOf:fileUrl, options:NSData.ReadingOptions.uncached)
                let jsonDictionary:Dictionary<String, AnyObject> = try JSONSerialization.jsonObject(with:jsonData, options:JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, AnyObject>

                return jsonDictionary
            }
            catch let error
            {
                print("[UIPheonix] \(error.localizedDescription)")
            }
        }
        else
        {
            print("[UIPheonix] Filename/path not found: \(filePath)")
        }

        return nil
    }


    // MARK:- Display List


    func setDisplayList(_ displayDictionary:Dictionary<String, AnyObject>, append:Bool=false)
    {
        guard (mDelegate != nil) else {
            fatalError("[UIPheonix] `setUIDisplayList` failed, `mDelegate` is nil!")
        }

        mDisplayDictionary = displayDictionary

        // connect & display
        connectCollectionView()
        createDisplayList(append:append)

        mDelegate!.displayListDidSet()
    }


    func setDisplayList(_ array:Array<UIPInstantiatable>)
    {
        guard (mDelegate != nil) else {
            fatalError("[UIPheonix] `setUIDisplayList` failed, `mDelegate` is nil!")
        }

        mUIDisplayList = array

        mDelegate!.displayListDidSet()
    }


    func displayList()
    -> Array<UIPInstantiatable>
    {
        return mUIDisplayList
    }


    // MARK:- UICollectionView


    class func calculateLayoutSizeForCell(_ cell:UIPPlatformCollectionViewCell, preferredWidth:CGFloat)
    -> CGSize
    {
        var size:CGSize

        // The cell's size is determined in the nib.
        // We need to set it's width (in this case), and inside the cell view use its width
        // to set any label's `preferredMaxLayoutWidth`, thus, the height can be determined.
        #if os(iOS) || os(tvOS)
            cell.bounds = CGRect(x:0, y:0, width:preferredWidth, height:cell.bounds.size.height)
            cell.contentView.bounds = cell.bounds

            // layout subviews, this will let labels on this cell to set `preferredMaxLayoutWidth`
            cell.setNeedsLayout()
            cell.layoutIfNeeded()

            // we only need the fitting height
            size = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
            size.width = preferredWidth
            size.height = CGFloat(ceilf(Float(size.height)))
        #elseif os(macOS)
            cell.view.bounds = CGRect(x:0, y:0, width:preferredWidth, height:cell.view.bounds.size.height)

            // layout subviews
            cell.view.layoutSubtreeIfNeeded()

            // use size
            size = cell.view.bounds.size
            size.width = preferredWidth    // TODO: is this really needed?
        #endif

        return size
    }


    func viewForModel(with viewReuseId:String)
    -> UIPBaseCVCellView?
    {
        return mViewReuseIds[viewReuseId] as? UIPBaseCVCellView
    }


    // MARK:- Private


    func getApplicationName()
    -> String
    {
        let appNameAndClassName:String = NSStringFromClass(UIPheonix.self)                                          // i.e. "<AppName>.<ClassName>" = UIPheonix_iOS.UIPheonix
        let appNameAndClassNameArray:[String] = appNameAndClassName.characters.split{$0 == "."}.map(String.init)    // = ["UIPheonix_iOS", "UIPheonix"]

        //print(appNameAndClassName)
        //print(appNameAndClassNameArray)

        return appNameAndClassNameArray[0]
    }


    ///
    /// Registers all cell-views with the delegate UICollectionView,
    /// by using the model's name as the cell-view's reuse-id.
    ///
    fileprivate func connectCollectionView()
    {
        guard (mDelegateCollectionView != nil) else {
            fatalError("[UIPheonix] `connectCollectionView` failed, `delegateCollectionView` is nil!")
        }

        // read the model-view relationship from the display dictionary
        let modelViewRelationshipsDict:Dictionary<String, String> = mDisplayDictionary["UIPCVModelViewRelationships"] as! Dictionary<String, String>

        guard (modelViewRelationshipsDict.count != 0) else {
            fatalError("[UIPheonix] The key `UIPCVModelViewRelationships` could not be found in the display dictionary!")
        }

        var modelClassNames:Array<String> = Array<String>()
        var nibNames:Array<String> = Array<String>()

        for (modelClassName, viewClassName) in modelViewRelationshipsDict
        {
            modelClassNames.append(modelClassName)
            nibNames.append(viewClassName)
        }

        guard (modelClassNames.count == nibNames.count) else {
            fatalError("[UIPheonix] Number of `modelClassNames` & `nibNames` count does not match!")
        }

        for i in 0 ..< modelClassNames.count
        {
            let nibName:String = nibNames[i]
            let modelName:String = modelClassNames[i]

            // only add new models/views that have not been registered
            if (mViewReuseIds[modelName] == nil)
            {
                #if os(iOS) || os(tvOS)
                    let nibContents:[Any]? = Bundle.main.loadNibNamed(nibName, owner:nil, options:nil)
                #elseif os(macOS)
                    var nibContents:NSArray? = NSArray()

                    let isNibLoaded:Bool = Bundle.main.loadNibNamed(nibName, owner:nil, topLevelObjects:&nibContents!)
                    guard (isNibLoaded) else {
                        fatalError("[UIPheonix] Nib could not be loaded: \(nibName)")
                    }
                #endif

                guard ((nibContents != nil) && (nibContents!.count > 0)) else {
                    fatalError("[UIPheonix] Nib is empty: \(nibName)")
                }

                // find the element we are looking for, since the xib contents order is not guaranteed
                let filteredNibContents:[Any] = nibContents!.filter(
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

                    mDelegateCollectionView!.register(nib, forCellWithReuseIdentifier:modelName)
                #elseif os(macOS)
                    let nib:NSNib? = NSNib(nibNamed:nibName, bundle:nil)

                    guard (nib != nil) else {
                        fatalError("[UIPheonix] Nib could not be instantiated: \(nibName)")
                    }

                    mDelegateCollectionView!.register(nib, forItemWithIdentifier:modelName)
                #endif
            }
        }
    }


    fileprivate func createDisplayList(append:Bool)
    {
        // read models
        let uipCVCellModelsArray:Array<AnyObject> = mDisplayDictionary["UIPCVCellModels"] as! Array<AnyObject>

        guard (uipCVCellModelsArray.count != 0) else {
            fatalError("[UIPheonix] The key `UIPCVCellModels` could not be found in the display dictionary!")
        }

        // don't append, but replace
        if (!append)
        {
            // prepare a new empty display list
            mUIDisplayList.removeAll(keepingCapacity:false)
        }

        // instantiate model classes with their data in the display dictionary
        // add the models to the display list
        for aModelType:AnyObject in uipCVCellModelsArray
        {
            let modelDict:Dictionary<String, AnyObject> = aModelType as! Dictionary<String, AnyObject>
            let modelTypeName:String? = modelDict["type"] as? String

            // `type` field does not exist
            if (modelTypeName == nil) {
                fatalError("[UIPheonix] The key `type` was not found for the model `\(aModelType)`!")
            }

            // create & add models
            if let modelClassType:UIPInstantiatable.Type = NSClassFromString(mApplicationNameDot + modelTypeName!) as? UIPInstantiatable.Type
            {
                let aModelObj:UIPInstantiatable = modelClassType.init()
                aModelObj.setContents(with:modelDict)

                mUIDisplayList.append(aModelObj)
            }
        }
    }
}


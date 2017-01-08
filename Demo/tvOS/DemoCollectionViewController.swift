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

import UIKit


final class DemoCollectionViewController:UIPBaseViewController, UIPBaseViewControllerProtocol, UIPButtonDelegate,
                                         UICollectionViewDataSource, /*UICollectionViewDataSourcePrefetching,*/ UICollectionViewDelegateFlowLayout
{
    // MARK: Public Inner Struct
    struct AttributeKeyName
    {
        static let appDisplayState:String = "AppDisplayState"
    }

    // MARK: Public IB Outlet
    @IBOutlet weak var ibCollectionView:UICollectionView!

    // MARK: Private Members
    fileprivate var mAppDisplayStateType:AppDisplayStateType!
    fileprivate var mUIPheonix:UIPheonix!
    fileprivate var mViewToFocus:UIView? = nil
    // (for demo purpose only)
    fileprivate var mPersistentDisplayModels:Array<UIPBaseCellModelProtocol>?

    // MARK: Overriding Member
    override weak var preferredFocusedView:UIView?
    {
        // the cell view to focus
        if (mViewToFocus != nil) {
            return mViewToFocus
        }
        else {
            return super.preferredFocusedView
        }
    }


    // MARK:- UIPBaseViewController/UIPBaseViewControllerProtocol


    ///
    /// Create a new instance of self with nib.
    ///
    static func newInstance<T:UIPBaseViewControllerProtocol>(with attributes:Dictionary<String, Any>)
    -> T
    {
        let vc:DemoCollectionViewController = DemoCollectionViewController.init(nibName:"\(self)", bundle:nil)

        // init member
        vc.mPreparedAttributes = attributes

        return vc as! T
    }


    // MARK:- Life Cycle


    override func viewDidLoad()
    {
        super.viewDidLoad()

        // init member
        mAppDisplayStateType = (mPreparedAttributes[AttributeKeyName.appDisplayState] as! AppDisplayState).typeValue

        initUIPheonix()
        setupCollectionView()
        updateView()
    }


    // MARK:- UICollectionViewDataSource


    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int)
    -> Int
    {
        return mUIPheonix.count()
    }


    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath)
    -> UICollectionViewCell
    {
        let cellModel:UIPBaseCellModel = mUIPheonix.model(at:indexPath.item)!
        let cellView:UIPBaseCollectionViewCell = mUIPheonix.dequeueView(withReuseIdentifier:cellModel.nameOfClass, for:indexPath)!

        let _:UIPCellSize = cellView.update(with:cellModel, delegate:self, for:indexPath)

        cellView.layoutIfNeeded()

        // tvOS, focus on the item that wants focus (only buttons in this case)
        if (cellModel.nameOfClass == SimpleButtonModel.nameOfClass)
        {
            let buttonModel:SimpleButtonModel = cellModel as! SimpleButtonModel

            // wants focus
            if (buttonModel.mFocus) {
                mViewToFocus = cellView
            }
        }

        return cellView
    }


    // MARK:- UICollectionViewDataSourcePrefetching


    ///
    /// Not used in this example.
    ///
    /*@available(iOS 10.0, *)
    func collectionView(_ collectionView:UICollectionView, prefetchItemsAt indexPaths:[IndexPath])
    {
        // empty for now
    }*/


    // MARK:- UICollectionViewDelegate


    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section:Int)
    -> UIEdgeInsets
    {
        return UIEdgeInsets(top:10, left:0, bottom:10, right:0)
    }


    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, minimumLineSpacingForSectionAt section:Int)
    -> CGFloat
    {
        return 10
    }


    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath)
    -> CGSize
    {
        let cellModel:UIPBaseCellModel = mUIPheonix.model(at:indexPath.item)!
        let cellView:UIPBaseCollectionViewCell = mUIPheonix.view(forReuseIdentifier:cellModel.nameOfClass)!

        // default: full width, no margins
        let defaultCellWidth:CGFloat = collectionView.bounds.size.width - 0 - 0

        let modelCellSize:UIPCellSize = cellView.update(with:cellModel, delegate:self, for:indexPath)
        let layoutCellSize:CGSize = UIPheonix.calculateLayoutSizeForCell(cellView, preferredWidth:defaultCellWidth)

        return UIPheonix.viewSize(with:layoutCellSize, addedSize:modelCellSize)
    }


    // MARK:- UIPButtonDelegate


    func buttonAction(_ buttonId:Int)
    {
        var isTheAppendModelsDemo:Bool = false
        var isThePersistentModelsDemo:Bool = false
        var isTheCustomMadeModelsDemo:Bool = false
        var shouldAnimateChange:Bool = true

        // set the display state depending on which button we clicked
        switch (buttonId)
        {
            case ButtonId.startUp.rawValue: mAppDisplayStateType = AppDisplayState.startUp.typeValue; break

            case ButtonId.mixed.rawValue: mAppDisplayStateType = AppDisplayState.mixed.typeValue; break

            case ButtonId.animations.rawValue: mAppDisplayStateType = AppDisplayState.animations.typeValue; break

            case ButtonId.switching.rawValue: mAppDisplayStateType = AppDisplayState.switching.typeValue; break

            case ButtonId.appending.rawValue: mAppDisplayStateType = AppDisplayState.appending.typeValue; break

                case ButtonId.appendingReload.rawValue:
                    mAppDisplayStateType = AppDisplayState.appending.typeValue
                    isTheAppendModelsDemo = true
                    shouldAnimateChange = false
                break

            case ButtonId.persistent.rawValue:
                mAppDisplayStateType = AppDisplayState.persistent.typeValue
                isThePersistentModelsDemo = true
            break

                case ButtonId.persistentGoBack.rawValue:
                    mAppDisplayStateType = AppDisplayState.startUp.typeValue
                    // when we leave the state, store the current display models for later reuse
                    // so that when we re-enter the state, we can just use them as they were
                    mPersistentDisplayModels = mUIPheonix.displayModels()
                break

            case ButtonId.specific.rawValue: mAppDisplayStateType = AppDisplayState.specific.typeValue; break

            case ButtonId.customMadeModels.rawValue:
                mAppDisplayStateType = AppDisplayState.customMadeModels.typeValue;
                isTheCustomMadeModelsDemo = true
            break

            default: mAppDisplayStateType = AppDisplayState.startUp.typeValue; break
        }


        // update UI
        if (shouldAnimateChange)
        {
            animateView(animationState:false, completionHandler:
            {
                [weak self] in
                guard let strongSelf:DemoCollectionViewController = self else { fatalError("DemoCollectionViewController buttonAction: `self` does not exist anymore!") }

                strongSelf.updateView(isTheAppendModelsDemo:isTheAppendModelsDemo,
                                      isThePersistentDemo:isThePersistentModelsDemo,
                                      isTheCustomMadeModelsDemo:isTheCustomMadeModelsDemo)

                strongSelf.animateView(animationState:true, completionHandler:
                {
                    [weak self] in
                    guard let strongSelf:DemoCollectionViewController = self else { fatalError("DemoCollectionViewController buttonAction: `self` does not exist anymore!") }

                    // force update view focus
                    strongSelf.setNeedsFocusUpdate()
                    strongSelf.updateFocusIfNeeded()
                })
            })
        }
        else
        {
            updateView(isTheAppendModelsDemo:isTheAppendModelsDemo,
                       isThePersistentDemo:isThePersistentModelsDemo,
                       isTheCustomMadeModelsDemo:isTheCustomMadeModelsDemo)
        }
    }


    // MARK:- Private


    fileprivate func initUIPheonix()
    {
        mUIPheonix = UIPheonix(with:ibCollectionView)
    }


    fileprivate func setupCollectionView()
    {
        ///
        /// Does not seem to work, bug reported to Apple.
        ///
        /*if #available(tvOS 10.0, *)
        {
            (ibCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
            //(ibCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize(width:ibCollectionView.bounds.width, height:50)
        }
        else
        {
            // fallback on earlier versions
            (ibCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize(width:ibCollectionView.bounds.width, height:50)
        }*/

        ibCollectionView.delegate = self
        ibCollectionView.dataSource = self

        ///
        /// Not used in this example.
        ///
        /*if #available(tvOS 10.0, *)
        {
            ibCollectionView.prefetchDataSource = self
            // ibCollectionView.isPrefetchingEnabled, true by default
        }
        else {
            // fallback on earlier versions
        }*/
    }


    fileprivate func setupWithJSON()
    {
        if let jsonDictionary:Dictionary<String, Any> = DataProvider.loadJSON(inFilePath:mAppDisplayStateType.jsonFileName.rawValue)
        {
            mUIPheonix.setModelViewRelationships(jsonDictionary[UIPConstants.Collection.modelViewRelationships] as! Dictionary<String, String>)
            mUIPheonix.setDisplayModels(jsonDictionary[UIPConstants.Collection.cellModels] as! Array<Any>, append:false)
        }
        else
        {
            fatalError("DemoCollectionViewController setupWithJSON: Failed to init with JSON file!")
        }
    }


    fileprivate func setupWithModels()
    {
        mUIPheonix.setModelViewRelationships([SimpleButtonModel.nameOfClass:SimpleButtonModelCVCell.nameOfClass,
                                              SimpleCounterModel.nameOfClass:SimpleCounterModelCVCell.nameOfClass,
                                              SimpleLabelModel.nameOfClass:SimpleLabelModelCVCell.nameOfClass,
                                              SimpleTextFieldModel.nameOfClass:SimpleTextFieldModelCVCell.nameOfClass,
                                              SimpleVerticalSpaceModel.nameOfClass:SimpleVerticalSpaceModelCVCell.nameOfClass,
                                              SimpleViewAnimationModel.nameOfClass:SimpleViewAnimationModelCVCell.nameOfClass])

        var models:[UIPBaseCellModel] = [UIPBaseCellModel]()

        for i in 1 ... 8
        {
            let simpleLabelModel:SimpleLabelModel = SimpleLabelModel(text:"  Label \(i)",
                                                                     size:(24.0 + CGFloat(i) * 4.0),
                                                                     alignment:SimpleLabelModel.Alignment.left,
                                                                     style:SimpleLabelModel.Style.regular,
                                                                     backgroundColorHue:(CGFloat(i) * 0.10),
                                                                     notificationId:"")
            models.append(simpleLabelModel)
        }

        let simpleButtonModel:SimpleButtonModel = SimpleButtonModel(id:ButtonId.startUp.rawValue,
                                                                    title:"Enough with the RAINBOW!",
                                                                    focus:true)

        models.append(simpleButtonModel)

        mUIPheonix.setDisplayModels(models)
    }


    fileprivate func updateView(isTheAppendModelsDemo:Bool=false, isThePersistentDemo:Bool=false, isTheCustomMadeModelsDemo:Bool=false)
    {
        if (isTheAppendModelsDemo)
        {
            // append the current display models list to itself
            mUIPheonix.addDisplayModels(mUIPheonix.displayModels())
        }
        else if (isThePersistentDemo)
        {
            if (mPersistentDisplayModels == nil) {
                setupWithJSON()
            }
            else
            {
                // set the persistent display models
                mUIPheonix!.setDisplayModels(mPersistentDisplayModels!)
            }
        }
        else if (isTheCustomMadeModelsDemo)
        {
            setupWithModels()
        }
        else
        {
            setupWithJSON()
        }

        // reload the collection view
        ibCollectionView.reloadData()
    }


    fileprivate func animateView(animationState:Bool, completionHandler:(()->Void)?)
    {
        // do a nice fading animation
        UIView.animate(withDuration:0.25, animations:
        {
            [weak self] in

            guard let strongSelf:DemoCollectionViewController = self else { fatalError("DemoCollectionViewController animateView: `self` does not exist anymore!") }

            strongSelf.ibCollectionView.alpha = animationState ? 1.0 : 0.0
        },
        completion:
        {
            (animationCompleted:Bool) in

            completionHandler?()
        })
    }
}


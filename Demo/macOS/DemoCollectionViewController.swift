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

import Cocoa


final class DemoCollectionViewController:UIPBaseViewController, UIPBaseViewControllerProtocol, UIPButtonDelegate,
                                         NSCollectionViewDataSource, NSCollectionViewDelegateFlowLayout

{
    // MARK: Public Inner Struct
    struct AttributeKeyName
    {
        static let appDisplayState:String = "AppDisplayState"
    }

    // MARK: Public IB Outlet
    @IBOutlet fileprivate weak var ibCollectionView:NSCollectionView!

    // MARK: Private Members
    fileprivate var mAppDisplayStateType:AppDisplayStateType!
    fileprivate var mUIPheonix:UIPheonix!
    // (for demo purpose only)
    fileprivate var mPersistentDisplayModels:Array<UIPBaseCellModelProtocol>?


    // MARK:- UIPBaseViewController/UIPBaseViewControllerProtocol


    ///
    /// Create a new instance of self with nib.
    ///
    static func newInstance<T:UIPBaseViewControllerProtocol>(with attributes:Dictionary<String, Any>)
    -> T
    {
        guard let vc:DemoCollectionViewController = DemoCollectionViewController.init(nibName:"\(self)", bundle:nil) else {
            fatalError("DemoCollectionViewController newInstance: Could not create new instance of `DemoCollectionViewController` from nib!")
        }

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


    // MARK:- NSCollectionViewDataSource


    func collectionView(_ collectionView:NSCollectionView, numberOfItemsInSection section:Int)
    -> Int
    {
        return mUIPheonix.count()
    }


    func collectionView(_ collectionView:NSCollectionView, itemForRepresentedObjectAt indexPath:IndexPath)
    -> NSCollectionViewItem
    {
        return mUIPheonix.collectionViewItem(for:indexPath)
    }


    // MARK:- NSCollectionViewDelegate


    func collectionView(_ collectionView:NSCollectionView, layout collectionViewLayout:NSCollectionViewLayout, insetForSectionAt section:Int)
    -> EdgeInsets
    {
        return EdgeInsets(top:10, left:0, bottom:0, right:0)
    }


    func collectionView(_ collectionView:NSCollectionView, layout collectionViewLayout:NSCollectionViewLayout, minimumLineSpacingForSectionAt section:Int)
    -> CGFloat
    {
        return 10
    }


    func collectionView(_ collectionView:NSCollectionView, layout collectionViewLayout:NSCollectionViewLayout, sizeForItemAt indexPath:IndexPath)
    -> CGSize
    {
        // default: full width, no margins
        let defaultCellWidth:CGFloat = collectionView.bounds.size.width - 0 - 0

        return mUIPheonix.collectionViewItemSize(for:indexPath, preferredWidth:defaultCellWidth)
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

                strongSelf.animateView(animationState:true, completionHandler:nil)
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
        mUIPheonix = UIPheonix(with:ibCollectionView, delegate:self)
    }


    fileprivate func setupCollectionView()
    {
        ibCollectionView.delegate = self
        ibCollectionView.dataSource = self
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

        for i in 1 ... 20
        {
            let simpleLabelModel:SimpleLabelModel = SimpleLabelModel(text:" Label \(i)",
                                                                     size:(12.0 + CGFloat(i) * 2.0),
                                                                     alignment:SimpleLabelModel.Alignment.left,
                                                                     style:SimpleLabelModel.Style.regular,
                                                                     backgroundColorHue:(CGFloat(i) * 0.05),
                                                                     notificationId:"")
            models.append(simpleLabelModel)
        }

        let simpleButtonModel:SimpleButtonModel = SimpleButtonModel(id:ButtonId.startUp.rawValue, title:"Enough with the RAINBOW!", alignment:SimpleButtonModel.Alignment.center)
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
        NSAnimationContext.runAnimationGroup(
        {
            [weak self] (context:NSAnimationContext) in

            guard let strongSelf:DemoCollectionViewController = self else { fatalError("DemoCollectionViewController animateView: `self` does not exist anymore!") }

            context.duration = 0.25
            strongSelf.view.animator().alphaValue = animationState ? 1.0 : 0.0
        },
        completionHandler:completionHandler)
    }
}


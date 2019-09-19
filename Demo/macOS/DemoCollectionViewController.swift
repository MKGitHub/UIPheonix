/**
    UIPheonix
    Copyright © 2016/2017/2018/2019 Mohsan Khan. All rights reserved.

    https://github.com/MKGitHub/UIPheonix
    http://www.xybernic.com

    Copyright 2016/2017/2018/2019 Mohsan Khan

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

import Cocoa


final class DemoCollectionViewController:UIPBaseViewController, UIPButtonDelegate,
                                         NSCollectionViewDataSource, NSCollectionViewDelegateFlowLayout

{
    // MARK: Public Inner Struct
    struct AttributeKeyName
    {
        static let appDisplayState = "AppDisplayState"
    }

    // MARK: Public IB Outlet
    @IBOutlet private weak var ibCollectionView:NSCollectionView!

    // MARK: Private Members
    private var mAppDisplayStateType:AppDisplayStateType!
    private var mUIPheonix:UIPheonix!

    // (for demo purpose only)
    private var mPersistentDisplayModels:Array<UIPBaseCellModelProtocol>?


    // MARK:- Life Cycle


    override func viewDidLoad()
    {
        super.viewDidLoad()

        // init member
        mAppDisplayStateType = (newInstanceAttributes[AttributeKeyName.appDisplayState] as! AppDisplayState).value

        initUIPheonix()
        setupCollectionView()
        updateView()
    }


    // MARK:- NSCollectionViewDataSource


    func collectionView(_ collectionView:NSCollectionView, numberOfItemsInSection section:Int) -> Int
    {
        return mUIPheonix.displayModelsCount(forSection:0)
    }


    func collectionView(_ collectionView:NSCollectionView, itemForRepresentedObjectAt indexPath:IndexPath) -> NSCollectionViewItem
    {
        return mUIPheonix.collectionViewItem(forIndexPath:indexPath)
    }


    // MARK:- NSCollectionViewDelegate


    func collectionView(_ collectionView:NSCollectionView, layout collectionViewLayout:NSCollectionViewLayout, insetForSectionAt section:Int) -> NSEdgeInsets
    {
        return NSEdgeInsets(top:10, left:0, bottom:0, right:0)
    }


    func collectionView(_ collectionView:NSCollectionView, layout collectionViewLayout:NSCollectionViewLayout, minimumLineSpacingForSectionAt section:Int) -> CGFloat
    {
        return 10
    }


    func collectionView(_ collectionView:NSCollectionView, layout collectionViewLayout:NSCollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        return mUIPheonix.collectionViewItemSize(forIndexPath:indexPath)
    }


    // MARK:- UIPButtonDelegate


    func handleAction(forButtonId buttonId:Int)
    {
        var isTheAppendModelsDemo = false
        var isThePersistentModelsDemo = false
        var isTheCustomMadeModelsDemo = false
        var shouldAnimateChange = true

        // set the display state depending on which button we clicked
        switch (buttonId)
        {
            case ButtonId.startUp.rawValue: mAppDisplayStateType = AppDisplayState.startUp.value; break

            case ButtonId.mixed.rawValue: mAppDisplayStateType = AppDisplayState.mixed.value; break

            case ButtonId.animations.rawValue: mAppDisplayStateType = AppDisplayState.animations.value; break

            case ButtonId.switching.rawValue: mAppDisplayStateType = AppDisplayState.switching.value; break

            case ButtonId.appending.rawValue: mAppDisplayStateType = AppDisplayState.appending.value; break

                case ButtonId.appendingReload.rawValue:
                    mAppDisplayStateType = AppDisplayState.appending.value
                    isTheAppendModelsDemo = true
                    shouldAnimateChange = false
                break

            case ButtonId.persistent.rawValue:
                mAppDisplayStateType = AppDisplayState.persistent.value
                isThePersistentModelsDemo = true
            break

                case ButtonId.persistentGoBack.rawValue:
                    mAppDisplayStateType = AppDisplayState.startUp.value
                    // when we leave the state, store the current display models for later reuse
                    // so that when we re-enter the state, we can just use them as they were
                    mPersistentDisplayModels = mUIPheonix.displayModels(forSection:0)
                break

            case ButtonId.specific.rawValue: mAppDisplayStateType = AppDisplayState.specific.value; break

            case ButtonId.customMadeModels.rawValue:
                mAppDisplayStateType = AppDisplayState.customMadeModels.value;
                isTheCustomMadeModelsDemo = true
            break

            default: mAppDisplayStateType = AppDisplayState.startUp.value; break
        }


        // update UI
        if (shouldAnimateChange)
        {
            animateView(animationState:false, completionHandler:
            {
                [weak self] in
                guard let self = self else { fatalError("DemoCollectionViewController buttonAction: `self` does not exist anymore!") }

                self.updateView(isTheAppendModelsDemo:isTheAppendModelsDemo,
                                      isThePersistentDemo:isThePersistentModelsDemo,
                                      isTheCustomMadeModelsDemo:isTheCustomMadeModelsDemo)

                self.animateView(animationState:true, completionHandler:nil)
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


    private func initUIPheonix()
    {
        mUIPheonix = UIPheonix(collectionView:ibCollectionView, delegate:self)
    }


    private func setupCollectionView()
    {
        ibCollectionView.delegate = self
        ibCollectionView.dataSource = self
    }


    private func setupWithJSON()
    {
        if let jsonDictionary = DataProvider.loadJSON(inFilePath:mAppDisplayStateType.jsonFileName.rawValue)
        {
            mUIPheonix.setModelViewRelationships(withDictionary:jsonDictionary[UIPConstants.Collection.modelViewRelationships] as! Dictionary<String, String>)
            mUIPheonix.setDisplayModels(jsonDictionary[UIPConstants.Collection.cellModels] as! Array<Any>, forSection:0, append:false)
        }
        else
        {
            fatalError("DemoCollectionViewController setupWithJSON: Failed to init with JSON file!")
        }
    }


    private func setupWithModels()
    {
        mUIPheonix.setModelViewRelationships(withDictionary:[SimpleButtonModel.nameOfClass:SimpleButtonModelCVCell.nameOfClass,
                                                             SimpleCounterModel.nameOfClass:SimpleCounterModelCVCell.nameOfClass,
                                                             SimpleLabelModel.nameOfClass:SimpleLabelModelCVCell.nameOfClass,
                                                             SimpleTextFieldModel.nameOfClass:SimpleTextFieldModelCVCell.nameOfClass,
                                                             SimpleVerticalSpaceModel.nameOfClass:SimpleVerticalSpaceModelCVCell.nameOfClass,
                                                             SimpleViewAnimationModel.nameOfClass:SimpleViewAnimationModelCVCell.nameOfClass])

        var models = [UIPBaseCellModel]()

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

        let simpleButtonModel = SimpleButtonModel(id:ButtonId.startUp.rawValue, title:"Enough with the RAINBOW!", alignment:SimpleButtonModel.Alignment.center)
        models.append(simpleButtonModel)

        mUIPheonix.setDisplayModels(models, forSection:0)
    }


    private func updateView(isTheAppendModelsDemo:Bool=false, isThePersistentDemo:Bool=false, isTheCustomMadeModelsDemo:Bool=false)
    {
        if (isTheAppendModelsDemo)
        {
            // append the current display models list to itself
            mUIPheonix.addDisplayModels(mUIPheonix.displayModels(forSection:0), inSection:0)
        }
        else if (isThePersistentDemo)
        {
            if (mPersistentDisplayModels == nil) {
                setupWithJSON()
            }
            else
            {
                // set the persistent display models
                mUIPheonix!.setDisplayModels(mPersistentDisplayModels!, forSection:0)
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


    private func animateView(animationState:Bool, completionHandler:(()->Void)?)
    {
        // do a nice fading animation
        NSAnimationContext.runAnimationGroup(
        {
            [weak self] (context:NSAnimationContext) in
            guard let self = self else { fatalError("DemoCollectionViewController animateView: `self` does not exist anymore!") }

            context.duration = 0.25
            self.view.animator().alphaValue = animationState ? 1.0 : 0.0
        },
        completionHandler:completionHandler)
    }
}


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

import UIKit


final class DemoViewController:UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,
                               UIPDelegate, UIPButtonDelegate
{
    // MARK: Public IB Outlet
    @IBOutlet weak var ibCollectionView:UICollectionView!

    // MARK: Private Members
    fileprivate var mUIPheonix:UIPheonix!
    fileprivate var mCurrentDisplayState:UIDisplayState!
    fileprivate var mViewToFocus:UIView? = nil

    // MARK: (for demo purpose only)
    fileprivate var mExamplePersistentDisplayList:Array<UIPInstantiatable>?
    fileprivate var mAnimateViewReload:Bool = true

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


    // MARK:- Life Cycle


    ///
    /// Create a new instance of self with nib.
    ///
    class func newInstance(with uiDisplayState:UIDisplayState)
    -> DemoViewController
    {
        let vc:DemoViewController = self.init(nibName:"\(self)", bundle:nil)

        vc.mCurrentDisplayState = uiDisplayState

        return vc
    }


    override func viewDidLoad()
    {
        super.viewDidLoad()

        // delegate & data source
        ibCollectionView.delegate = self
        ibCollectionView.dataSource = self

        updateView()
    }


    // MARK:- UICollectionViewDataSource


    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int)
    -> Int
    {
        return mUIPheonix.displayList().count
    }


    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath)
    -> UICollectionViewCell
    {
        let cellModel:UIPBaseCVCellModel = mUIPheonix.displayList()[indexPath.item] as! UIPBaseCVCellModel
        let cellView:UIPBaseCVCellView = ibCollectionView.dequeueReusableCell(withReuseIdentifier:cellModel.viewReuseId(), for:indexPath) as! UIPBaseCVCellView

        let _:UIPCellSize = cellView.updateWithModel(cellModel, delegate:self, index:UInt(indexPath.item))

        cellView.layoutIfNeeded()

        // tvOS, focus on item that wants focus (only buttons in this case)
        if (cellModel.viewReuseId() == SimpleButtonModel.viewReuseIdStatic())
        {
            let buttonModel:SimpleButtonModel = cellModel as! SimpleButtonModel

            // wants focus
            if (buttonModel.mButtonFocus) {
                mViewToFocus = cellView
            }
        }

        return cellView
    }


    // MARK:- UICollectionViewDelegate


    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section:Int)
    -> UIEdgeInsets
    {
        return UIEdgeInsets(top:30, left:0, bottom:0, right:0)
    }


    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, minimumLineSpacingForSectionAt section:Int)
    -> CGFloat
    {
        return 10
    }


    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath)
    -> CGSize
    {
        let cellModel:UIPBaseCVCellModel = mUIPheonix.displayList()[indexPath.item] as! UIPBaseCVCellModel

        guard let cellView:UIPBaseCVCellView = mUIPheonix.viewForModel(with:cellModel.viewReuseId()) else {
            fatalError("[UIPheonix] Could not find cell-view for cell-model: \(cellModel.viewReuseId())")
        }

        // default: full width, no margins
        let defaultCellWidth:CGFloat = collectionView.bounds.size.width - 0 - 0

        let modelCellSize:UIPCellSize = cellView.updateWithModel(cellModel, delegate:self, index:UInt(indexPath.item))
        let layoutCellSize:CGSize = UIPheonix.calculateLayoutSizeForCell(cellView, preferredWidth:defaultCellWidth)

        var sizeToUse:CGSize = layoutCellSize    // by default, we use the cells layout size

        // replace or add/subtract size
        if (modelCellSize.absoluteWidth) {
            sizeToUse.width = modelCellSize.width
        }
        else {
            sizeToUse.width += modelCellSize.width
        }

        if (modelCellSize.absoluteHeight) {
            sizeToUse.height = modelCellSize.height
        }
        else {
            sizeToUse.height += modelCellSize.height
        }

        return sizeToUse
    }


    // MARK:- UIPDelegate


    func displayListDidSet()
    {
        if (mAnimateViewReload)
        {
            // Do some nice fading animation when the display-list is changed. //

            self.view.layoutIfNeeded()     // #1. Make sure all frames are at the starting position.

            UIView.animate(withDuration:0.25, animations:
            {
                [weak self] in

                self?.ibCollectionView.alpha = 0.0

                self?.view.layoutIfNeeded()    // #2. Layout again to update the frames/constraints.
            },
            completion:
            {
                [weak self] (animationCompleted:Bool) in

                // reload
                self?.ibCollectionView.reloadData()
                self?.ibCollectionView.performBatchUpdates(nil, completion:
                {
                    (allRelatedAnimationsCompletedSuccessfully:Bool) in

                    UIView.animate(withDuration:0.25, animations:
                    {
                        [weak self] in

                        self?.ibCollectionView.alpha = 1.0

                        self?.view.layoutIfNeeded()    // #2. Layout again to update the frames/constraints.
                    },
                    completion:
                    {
                        [weak self] (finished:Bool) in

                        // force update view focus
                        self?.setNeedsFocusUpdate()
                        self?.updateFocusIfNeeded()
                    })
                })
            })
        }
        else
        {
            // just reload
            self.ibCollectionView.reloadData()
        }
    }


    // MARK:- UIPButtonDelegate


    func buttonAction(_ buttonId:Int)
    {
        // reset view animation state
        mAnimateViewReload = true

        var append:Bool = false
        var isThePersistentDemo:Bool = false

        switch (buttonId)
        {
            case 0:
                mCurrentDisplayState = UIDisplayState.startUp
            break

            case 100:
                mCurrentDisplayState = UIDisplayState.mixed
            break

            case 101:
                mCurrentDisplayState = UIDisplayState.animations
            break

            case 102:
                mCurrentDisplayState = UIDisplayState.switching
            break

            case 1030:
                mCurrentDisplayState = UIDisplayState.appending
            break

                case 1031:
                    mCurrentDisplayState = UIDisplayState.appending
                    append = true

                    // set view animation state
                    mAnimateViewReload = false
                break

            case 1040:
                mCurrentDisplayState = UIDisplayState.persistent
                isThePersistentDemo = true
            break

                case 1041:
                    mCurrentDisplayState = UIDisplayState.startUp
                    // when we leave the state
                    // store the current display list for later reuse
                    // so that when we re-enter the state, we can just use the stored display list
                    mExamplePersistentDisplayList = mUIPheonix.displayList()
                break

            case 105:
                mCurrentDisplayState = UIDisplayState.specific
            break

            default:
                mCurrentDisplayState = UIDisplayState.startUp
            break
        }

        updateView(append:append, isThePersistentDemo:isThePersistentDemo)
    }


    // MARK:- Private


    func updateView(append:Bool=false, isThePersistentDemo:Bool=false)
    {
        // for the persistent demo
        if (isThePersistentDemo && (mExamplePersistentDisplayList != nil))
        {
            // update UIPheonix with the persistent display list
            mUIPheonix?.setDisplayList(mExamplePersistentDisplayList!)
            return
        }


        // load JSON file
        let jsonFileName:String = mCurrentDisplayState.rawValue

        if let displayDictionary:Dictionary<String, AnyObject> = UIPheonix.loadJSONFile(jsonFileName)
        {
            if (mUIPheonix == nil)
            {
                // init UIPheonix
                mUIPheonix = UIPheonix(delegate:self, collectionView:ibCollectionView, displayDictionary:displayDictionary)
            }
            else
            {
                // update UIPheonix
                mUIPheonix?.setDisplayList(displayDictionary, append:append)
            }
        }
    }
}


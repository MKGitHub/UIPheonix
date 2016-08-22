//
// Template
//

#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(macOS)
    import Cocoa
#endif


final class TemplateModelCVCell:UIPBaseCVCellView
{
    // MARK: Private IB Outlet
    @IBOutlet fileprivate weak var ibLabel:UIPPlatformLabel!


    // MARK:- UICollectionViewCell


    /*override func prepareForReuse()
    {
        super.prepareForReuse()
    }*/


    // MARK:- UIPBaseCVCellView/UIPBaseCVCellProtocol


    override class func nibNameStatic()
    -> String
    {
        return "\(self)"
    }


    override func updateWithModel(_ objectModel:AnyObject, delegate:AnyObject, index:UInt)
    -> UIPCellSize
    {
        // apply model to view
        let simpleLabelModel:SimpleLabelModel = objectModel as! SimpleLabelModel

        #if os(iOS) || os(tvOS)
            ibLabel.text = simpleLabelModel.mText
            ibLabel.textAlignment = textAligment(with:simpleLabelModel.mAlignment)
        #elseif os(macOS)
            ibLabel.stringValue = simpleLabelModel.mText
            ibLabel.alignment = textAligment(with:simpleLabelModel.mAlignment)
        #endif

        ibLabel.font = fontStyle(with:simpleLabelModel.mStyle, size:simpleLabelModel.mSize)

        #if os(iOS) || os(tvOS)
            self.backgroundColor = UIPPlatformColor(hue:simpleLabelModel.mBackgroundColorHue, saturation:0.5, brightness:1, alpha:1)
        #elseif os(macOS)
            self.view.layer?.backgroundColor = UIPPlatformColor(hue:simpleLabelModel.mBackgroundColorHue, saturation:0.5, brightness:1, alpha:1).cgColor
        #endif

        // layer drawing
        #if os(iOS) || os(tvOS)
            self.layer.cornerRadius = CGFloat.valueForPlatform(mac:5, mobile:5, tv:20)
        #elseif os(macOS)
            self.view.layer?.cornerRadius = CGFloat.valueForPlatform(mac:5, mobile:5, tv:20)
        #endif

        // return view size
        return UIPCellSize(absoluteWidth:false, width:-20,
                           absoluteHeight:false, height:0)
    }


    // MARK:- Private


    fileprivate func textAligment(with aligment:String)
    -> NSTextAlignment
    {
        switch (aligment)
        {
            case "left":
                return NSTextAlignment.left

            case "center":
                return NSTextAlignment.center

            case "right":
                return NSTextAlignment.right

            default:
                return NSTextAlignment.left
        }
    }


    fileprivate func fontStyle(with style:String, size:CGFloat)
    -> UIPPlatformFont
    {
        switch (style)
        {
            case "regular":
                return UIPPlatformFont.systemFont(ofSize:size)

            case "bold":
                return UIPPlatformFont.boldSystemFont(ofSize:size)

            default:
                return UIPPlatformFont.systemFont(ofSize:size)
        }
    }
}


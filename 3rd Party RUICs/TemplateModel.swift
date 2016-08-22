//
// Template
//

import CoreGraphics

#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(macOS)
    import Cocoa
#endif


class TemplateModel:UIPBaseCVCellModel
{
    // MARK: Public Members
    public var mText:String!
    public var mSize:CGFloat!
    public var mAlignment:String!
    public var mStyle:String!
    public var mBackgroundColorHue:CGFloat!


    // MARK: UIPInstantiatable


    required init()
    {
        super.init()
    }


    override func setContents(with dictionary:Dictionary<String, AnyObject>)
    {
        mText = dictionary["text"] as! String

        #if os(iOS)
            let crossPlatformFontSize:CGFloat = UIPPlatformFont.systemFontSize
        #elseif os(tvOS)
            let crossPlatformFontSize:CGFloat = 20
        #elseif os(macOS)
            let crossPlatformFontSize:CGFloat = 12
        #endif
        mSize = (dictionary["size"] as? CGFloat) ?? crossPlatformFontSize    // fallback to default value

        mAlignment = (dictionary["alignment"] as? String) ?? "left"          // fallback to default value
        mStyle = (dictionary["style"] as? String) ?? "regular"               // fallback to default value

        mBackgroundColorHue = dictionary["backgroundColorHue"] as! CGFloat
    }


    // MARK: Life Cycle


    init(text:String, size:CGFloat, alignment:String, backgroundColorHue:CGFloat)
    {
        super.init()

        mText = text
        mSize = size
        mAlignment = alignment
        mBackgroundColorHue = backgroundColorHue
    }


    // MARK: UIPBaseCVCellModel


    override class func viewReuseIdStatic()
    -> String
    {
        return "\(self)"
    }


    override func viewReuseId()
    -> String
    {
        return "\(type(of:self))"
    }


    override func toDictionary()
    -> Dictionary<String, Any>
    {
        return [
            "mText":mText,
            "mSize":mSize,
            "mAlignment":mAlignment,
            "mBackgroundColorHue":CGFloat(mBackgroundColorHue)
        ]
    }
}


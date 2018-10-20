import UIKit

class BaseTableViewCell: UITableViewCell
{
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.clipsToBounds = true
    }
    
    class func nib() -> UINib
    {
        return UINib.init(nibName: self.className(), bundle: Bundle.main)
    }
    
    class func identifier() -> String
    {
        return self.className()
    }
    
    class func height() -> CGFloat
    {
        return 0.0
    }
}

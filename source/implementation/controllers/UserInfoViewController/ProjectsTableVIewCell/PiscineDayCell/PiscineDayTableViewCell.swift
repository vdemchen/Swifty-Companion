import UIKit

class PiscineDayTableViewCell: BaseTableViewCell {
    @IBOutlet weak var piscineDay: UILabel!
    @IBOutlet weak var piscineMark: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)   
    }
    
}

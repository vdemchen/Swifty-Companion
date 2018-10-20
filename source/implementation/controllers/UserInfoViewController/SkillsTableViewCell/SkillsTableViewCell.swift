import UIKit

class SkillsTableViewCell: BaseTableViewCell {

    @IBOutlet weak var skillName: UILabel!
    @IBOutlet weak var skillPoints: UILabel!
    @IBOutlet weak var skillProgresBar: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.sizeToFit()
//        self.skillProgresBar.transform = skillProgresBar.transform.scaledBy(x: 1, y: 10)
        
        // Configure the view for the selected state
    }
    
}

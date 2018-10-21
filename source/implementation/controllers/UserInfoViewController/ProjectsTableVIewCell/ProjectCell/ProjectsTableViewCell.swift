import UIKit

class ProjectsTableViewCell: BaseTableViewCell {

    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var projectMark: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.projectName.sizeToFit()
        // Configure the view for the selected state
    }
    
}

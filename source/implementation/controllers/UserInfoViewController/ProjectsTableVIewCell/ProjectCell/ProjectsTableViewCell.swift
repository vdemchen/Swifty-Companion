import UIKit

class ProjectsTableViewCell: BaseTableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var projectMark: UILabel!

    // MARK: - Override
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.projectName.sizeToFit()
    }
    
}

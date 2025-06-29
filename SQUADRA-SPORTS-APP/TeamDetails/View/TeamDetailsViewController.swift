//
//  TeamDetailsViewController.swift
//  SQUADRA-SPORTS-APP
//
//  Created by Adham Mohamed on 01/06/2025.
//

import UIKit

protocol TeamDetailsProtocol {
    func displayTeamDetails(res: TeamModel, sportName: String)
}

class TeamDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TeamDetailsProtocol{

    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamDetailsTableView: UITableView!
    
    var teamDetailsPresenter : TeamDetailsPresenter!
    
    var team : TeamModel!
    var sportName : String!
    
    var coachesArray : [Coach] = []
    var playersArray : [Player] = []
    var goalKeepersArray : [Player] = []
    var defendersArray : [Player] = []
    var midfieldersArray : [Player] = []
    var forwardsArray : [Player] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        teamDetailsTableView.delegate = self
        teamDetailsTableView.dataSource = self

        let nib = UINib(nibName: "PlayerTableViewCell", bundle: nil)
        teamDetailsTableView.register(nib, forCellReuseIdentifier: "PlayerCell")
        
        let nib2 = UINib(nibName: "CoachTableViewCell", bundle: nil)
        teamDetailsTableView.register(nib2, forCellReuseIdentifier: "CoachCell")
        
        teamDetailsPresenter.getTeamDetails()
    }
    
    func displayTeamDetails(res: TeamModel, sportName: String) {
        DispatchQueue.main.async {
            self.sportName = sportName
            self.team = res
            let teamDetailsTitle = NSLocalizedString("TeamDetailsTitle", comment: "")
            self.navigationItem.title = "\(self.team.teamName!) \(teamDetailsTitle)"

            self.teamNameLabel.text = self.team.teamName!
            
            if let teamImageView = self.team.teamLogo {
                self.teamImageView.kf.setImage(with: URL(string: teamImageView))
            }else{
                self.teamImageView.image = UIImage(named: "UnkownTeam")
            }
            if let coachesArray = self.team.coaches {
                self.coachesArray = coachesArray
            }else{
                self.coachesArray = []
            }
            if let playersArray = self.team.players {
                self.playersArray = playersArray
                self.goalKeepersArray = playersArray.filter { $0.playerType == "Goalkeepers" }
                self.defendersArray = playersArray.filter { $0.playerType == "Defenders" }
                self.midfieldersArray = playersArray.filter { $0.playerType == "Midfielders" }
                self.forwardsArray = playersArray.filter { $0.playerType == "Forwards" }
            }else{
                self.playersArray = []
            }
            self.teamDetailsTableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return coachesArray.count
        case 1:
            return goalKeepersArray.count
        case 2:
            return defendersArray.count
        case 3:
            return midfieldersArray.count
        case 4:
            return forwardsArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            // Configure the cell
        case 0:
            guard let cell = teamDetailsTableView.dequeueReusableCell(withIdentifier: "CoachCell", for: indexPath) as? CoachTableViewCell
            else {
                fatalError("Could not dequeue cell")
            }
            let coach = coachesArray[indexPath.row]
            
            cell.coachImageView.image = UIImage(named: "UnkownCoach")
            if let coachName = coach.coachName {
                cell.coachNameLabel.text = coachName
            } else {
                cell.coachNameLabel.text = "Unkown Coach"
            }
            
            return cell
            
        case 1:
            guard let cell = teamDetailsTableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerTableViewCell
            else {
                fatalError("Could not dequeue cell")
            }
            let player = goalKeepersArray[indexPath.row]
            
            if let playerLogo = player.playerImage,
                let url = URL(string: playerLogo) {
                    cell.playerImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownPlayer"))
                } else {
                    cell.playerImageView.image = UIImage(named: "UnkownPlayer")
                }
            if let playerName = player.playerName {
                cell.playerNameLabel.text = playerName
            } else {
                cell.playerNameLabel.text = "Unkown Player"
            }
            if let playerAge = player.playerAge {
                cell.playerAgeLabel.text = playerAge
            } else {
                cell.playerAgeLabel.text = "Unkown Age"
            }
            if let playerPosition = player.playerType {
                cell.playerPositionLabel.text = playerPosition
            } else {
                cell.playerPositionLabel.text = "Unkown Position"
            }
            if let playerNumber = player.playerNumber {
                cell.playerNumberLabel.text = playerNumber
            } else {
                cell.playerNumberLabel.text = "Unkown Number"
            }
            
            return cell
        
        case 2:
            guard let cell = teamDetailsTableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerTableViewCell
            else {
                fatalError("Could not dequeue cell")
            }
            let player = defendersArray[indexPath.row]
            
            if let playerLogo = player.playerImage,
                let url = URL(string: playerLogo) {
                    cell.playerImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownPlayer"))
                } else {
                    cell.playerImageView.image = UIImage(named: "UnkownPlayer")
                }
            if let playerName = player.playerName {
                cell.playerNameLabel.text = playerName
            } else {
                cell.playerNameLabel.text = "Unkown Player"
            }
            if let playerAge = player.playerAge {
                cell.playerAgeLabel.text = playerAge
            } else {
                cell.playerAgeLabel.text = "Unkown Age"
            }
            if let playerPosition = player.playerType {
                cell.playerPositionLabel.text = playerPosition
            } else {
                cell.playerPositionLabel.text = "Unkown Position"
            }
            if let playerNumber = player.playerNumber {
                cell.playerNumberLabel.text = playerNumber
            } else {
                cell.playerNumberLabel.text = "Unkown Number"
            }
            
            return cell
            
        case 3:
            guard let cell = teamDetailsTableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerTableViewCell
            else {
                fatalError("Could not dequeue cell")
            }
            let player = midfieldersArray[indexPath.row]
            
            if let playerLogo = player.playerImage,
                let url = URL(string: playerLogo) {
                    cell.playerImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownPlayer"))
                } else {
                    cell.playerImageView.image = UIImage(named: "UnkownPlayer")
                }
            if let playerName = player.playerName {
                cell.playerNameLabel.text = playerName
            } else {
                cell.playerNameLabel.text = "Unkown Player"
            }
            if let playerAge = player.playerAge {
                cell.playerAgeLabel.text = playerAge
            } else {
                cell.playerAgeLabel.text = "Unkown Age"
            }
            if let playerPosition = player.playerType {
                cell.playerPositionLabel.text = playerPosition
            } else {
                cell.playerPositionLabel.text = "Unkown Position"
            }
            if let playerNumber = player.playerNumber {
                cell.playerNumberLabel.text = playerNumber
            } else {
                cell.playerNumberLabel.text = "Unkown Number"
            }
            
            return cell
            
        case 4:
            guard let cell = teamDetailsTableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerTableViewCell
            else {
                fatalError("Could not dequeue cell")
            }
            let player = forwardsArray[indexPath.row]
            
            if let playerLogo = player.playerImage,
                let url = URL(string: playerLogo) {
                    cell.playerImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownPlayer"))
                } else {
                    cell.playerImageView.image = UIImage(named: "UnkownPlayer")
                }
            if let playerName = player.playerName {
                cell.playerNameLabel.text = playerName
            } else {
                cell.playerNameLabel.text = "Unkown Player"
            }
            if let playerAge = player.playerAge {
                cell.playerAgeLabel.text = playerAge
            } else {
                cell.playerAgeLabel.text = "Unkown Age"
            }
            if let playerPosition = player.playerType {
                cell.playerPositionLabel.text = playerPosition
            } else {
                cell.playerPositionLabel.text = "Unkown Position"
            }
            if let playerNumber = player.playerNumber {
                cell.playerNumberLabel.text = playerNumber
            } else {
                cell.playerNumberLabel.text = "Unkown Number"
            }
            
            return cell
            
        default:
            guard let cell = teamDetailsTableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerTableViewCell
            else {
                fatalError("Could not dequeue cell")
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: self.teamDetailsTableView.bounds.size.width, height: 40))
        let label = UILabel(frame: CGRect(x: 5, y: -10, width: (self.teamDetailsTableView.bounds.size.width ) - 32, height: 30))
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        if traitCollection.userInterfaceStyle == .dark {
            header.backgroundColor = UIColor.systemBackground
            label.textColor = UIColor.white
        } else {
            header.backgroundColor = UIColor.systemBackground
            label.textColor = UIColor.black
        }
        
        switch section{
        case 0:
            if(sportName == "football"){
                label.text = NSLocalizedString("CoachHeader", comment: "")
            } else {
                label.isHidden = true
            }
            break
            
        case 1:
            if(sportName == "football"){
                label.text = NSLocalizedString("GoalKeepers", comment: "")
            } else {
                label.isHidden = true
            }
            break
            
        case 2:
            if(sportName == "football"){
                label.text = NSLocalizedString("Defenders", comment: "")
            } else {
                label.isHidden = true
            }
            break
            
        case 3:
            if(sportName == "football"){
                label.text = NSLocalizedString("Midfielders", comment: "")
            } else {
                label.isHidden = true
            }
            break
            
        case 4:
            if(sportName == "football"){
                label.text = NSLocalizedString("Forwards", comment: "")
            } else {
                label.isHidden = true
            }
            break
            
        default:
            if(sportName == "football"){
                label.text = NSLocalizedString("Players", comment: "")
            } else {
                label.isHidden = true
            }
            break
        }
        header.addSubview(label)
        return header
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            teamDetailsTableView.reloadData()
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

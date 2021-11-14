//
//  ViewController.swift
//  Best Beer
//
//  Created by Pyramid on 13/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var outerView: UIView!
    
    @IBOutlet weak var sortyByBtn: UIButton!
    @IBOutlet weak var headerTitleLbl: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var beerListContainerView: UIView!
    @IBOutlet weak var beerListTblView: UITableView!
    
    var beerListModelViewObj = BeerListModelView()
    
    var beerListArr: [BeerListModel] = []
    
    private var selectedRow:Int?
    
    private let refreshControl = UIRefreshControl()
    var activityView: UIActivityIndicatorView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setDesignStyle()
        setUpMethod()
    }
    
    func setDesignStyle()
    {
        DispatchQueue.main.async {
            CSS.customCardView(self.outerView)
            self.beerListContainerView.roundCorners(corners: [.topLeft, .topRight], radius: 25.0)
        }
    }
    
    func setUpMethod()
    {
        fetchData("")
        beerListTblView.register(UINib(nibName: "BeerListTableViewCell", bundle: nil), forCellReuseIdentifier: "BeerListCell")
        searchBar.delegate = self
        sortyByBtn.tag = 0
        self.sortByBtnAction(self)
    }
    
    func fetchData(_ foodName:String)
    {
        
        beerListModelViewObj.getBeerSuggestionList(foodName) { [weak self] result in
            self?.hideActivityIndicator()
            self?.beerListArr = []
            self?.beerListArr = result
            DispatchQueue.main.async {
                self?.beerListTblView.reloadData()
            }
        }
    }
    
    //MARK: - Fetching data activity indicator show/hide
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        DispatchQueue.main.async {
            self.activityView?.startAnimating()
        }
    }
    
    func hideActivityIndicator(){
        if (activityView != nil){
            DispatchQueue.main.async {
                self.activityView?.stopAnimating()
            }
        }
    }
    
    @IBAction func sortByBtnAction(_ sender: Any)
    {
        if sortyByBtn.tag == 0
        {
            sortyByBtn.tag = 1
            beerListArr = beerListArr.sorted(by: {$0.abv! > $1.abv!})
        }
        else if sortyByBtn.tag == 1
        {
            sortyByBtn.tag = 0
            beerListArr = beerListArr.sorted(by: {$0.abv! < $1.abv!})
            
        }
        DispatchQueue.main.async {
            self.beerListTblView.reloadData()
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate
{
    //MARK: - TableView DataSources Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return beerListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: BeerListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell", for: indexPath) as! BeerListTableViewCell
        cell.beerNameLbl.text = beerListArr[indexPath.row].name
        cell.tagValLbl.text = beerListArr[indexPath.row].tagline
        cell.abvLbl.text = beerListArr[indexPath.row].abv?.description
        cell.selectionStyle = .none
        if let safedata = self.beerListArr[indexPath.row].imgData
        {
            cell.beerImgView.image = UIImage(data: safedata)
        }
        else
        {
            cell.beerImgView.image = UIImage(named: "notfoundImg")
        }
        
        
        return cell
        
    }
    
    //MARK: - TableView Delegate Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
}
extension ViewController: UISearchBarDelegate
{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        showActivityIndicator()
        
        searchBar.resignFirstResponder()
        
        fetchData(searchBar.text ?? "")
    }
}

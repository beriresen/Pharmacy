//
//  ViewController.swift
//  DutyPharmacy
//
//  Created by Berire Şen Ayvaz on 17.01.2023.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate  {
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = DutyViewModel()
    var selectedDatum = Datum()

    var locationManager = CLLocationManager()
    var telno = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        setupTableView()
        setupLocationManager()
    }
    
    //MARK: LocationManager Kurulum işlemleri
    func setupLocationManager(){
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
    }
    
    //MARK: Table View Ayarlama İşlemleri
    func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: - ViewModel ve Data Binding işlemleri
    fileprivate func setupViewModelObserver() {
        
        viewModel.dutyPharmacy.bind { [weak self] (dutyPharmacy) in
            DispatchQueue.main.async {
                self!.tableView.reloadData()
            }
        }
        
        viewModel.isLoading.bind { [weak self] (isLoading) in
            guard let isLoading = isLoading else { return }
            DispatchQueue.main.async { [self] in
                isLoading ? self?.indicatorView.startAnimating() : self?.indicatorView.stopAnimating()
                self?.indicatorView.isHidden = !isLoading
            }
        }
        
        viewModel.alertItem.bind{ [weak self] (alert) in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: self?.viewModel.alertItem.value?.title ?? "Uyarı",
                                              message: self?.viewModel.alertItem.value?.message ?? "Bir Hata Oluştu",
                                              preferredStyle: .alert)
                let okButton = UIAlertAction(title: self?.viewModel.alertItem.value?.dismissButton ?? "Tamam", style: .default)
                alert.addAction(okButton)
                self?.present(alert, animated: true)
            }
        }
    }
}

//MARK: Tableview Delegate ve Datasource İşlemleri
extension ViewController {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item:Datum = (viewModel.dutyPharmacy.value?.data?[indexPath.row])!
        let cell = tableView.dequeueReusableCell(withIdentifier:"PharmacyTableViewCell", for: indexPath) as! PharmacyTableViewCell
        cell.eczaneAdiLabel.text = item.eczaneAdi ?? ""
        cell.ilceLabel.text = item.ilce ?? ""
        cell.adresLabel.text = item.adresi ?? ""
        cell.telButton.clipsToBounds = true
        if item.telefon != ""{
            cell.telButton.isHidden = false
            telno = item.telefon!
            let customButtonTitle = NSMutableAttributedString(string:"  " + (item.telefon!), attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
                NSAttributedString.Key.backgroundColor: UIColor.white,
            ])

            cell.telButton.setAttributedTitle(customButtonTitle, for: .normal)
        }else {
            cell.telButton.isHidden = true
        }
        cell.telButton.addTarget(self, action: #selector(openCall), for: .touchUpInside)
       
       // cell.haritaButton.addTarget(self, action: #selector(openMap), for: .touchUpInside)
        return cell
        
    }
    
    @objc func openCall(){
        if let url = URL(string: "tel:\(telno)"),UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    @objc func openMap(){
        performSegue(withIdentifier: "toMapVC", sender: nil)

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dutyPharmacy.value?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item:Datum = (viewModel.dutyPharmacy.value?.data?[indexPath.row])!
        selectedDatum = item
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapVC" {
            let destinationVC = segue.destination as! MapVC
            destinationVC.datum = selectedDatum
        }
    }
}


//
//  EmployeeViewModel.swift
//  EmployeeRoster
//
//  Created by Sofia on 2022-05-28.
//

import Foundation
import UIKit
import Kingfisher

struct EmployeeViewModel {
    private let employee: Employee
    
    var uuid: String { employee.uuid }
    var fullName: String { employee.full_name }
    var phoneNumber: String { self.formatPhoneNumber(mask: "XXX-XXX-XXXX", phoneNumber: employee.phone_number) }
    var emailAddress: String { employee.email_address }
    var biography: String { employee.biography }
    var smallPhoto: UIImage? { return self.getImage()}
    var team: String { employee.team }
    var employeeType: String { employee.employee_type.replacingOccurrences(of: "_", with: "-").capitalized }
    
    init(employee: Employee) {
        self.employee = employee
    }
    
    private func getImage() -> UIImage? {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        imageView.contentMode = .scaleAspectFill
        imageView.kf.indicatorType = .activity
        guard let url = URL(string: employee.photo_url_small) else { return nil }
        let resource = ImageResource(downloadURL:  url)
        let processor = RoundCornerImageProcessor(cornerRadius: 25)
        imageView.kf.setImage(with: resource, placeholder: UIImage(named: "profile-placeholder"), options: [.processor(processor)]){(result) in self.handlePhotoResult(result)
        }
        return imageView.image
    }
    
    private func handlePhotoResult(_ result: Result<RetrieveImageResult, KingfisherError>) {
        switch result {
        case .success(let resultImage):
            let image = resultImage.image
            let cacheType = resultImage.cacheType
            print("The image is \(image) and cached in type: \(cacheType)")
        case .failure(let err):
            print(err.localizedDescription)
        }
    }
    
    func formatPhoneNumber(mask: String, phoneNumber: String) -> String {
        let phoneDigits = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var index = phoneDigits.startIndex
        var formattedNumber = ""
        for char in mask where index < phoneDigits.endIndex {
            if char == "X" {
                formattedNumber.append(phoneDigits[index])
                index = phoneDigits.index(after: index)
            } else {
                formattedNumber.append(char)
            }
        }
        return formattedNumber
    }
}
    

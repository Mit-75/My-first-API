//
//  ViewController.swift
//  My first API
//
//  Created by Dmitry Parhomenko on 05.02.2024.
//

import UIKit

enum Link {
    case courseURL
    
    var url: URL {
        switch self {
        case .courseURL:
            URL(string: "https://swiftbook.ru//wp-content/uploads/api/api_course")!
        
        }
    }
}

final class ViewController: UIViewController {
    
    @IBOutlet var imageCourse: UIImageView!
    @IBOutlet var courseName: UILabel!
    @IBOutlet var lessonNumber: UILabel!
    @IBOutlet var testNumber: UILabel!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchCourse()
    }
}

// MARK: - Networking

extension ViewController {
    private func fetchCourse() {
        URLSession.shared.dataTask(with: Link.courseURL.url) { [weak self]
            data, _, error in
            guard let self else { return }
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            DispatchQueue.main.async {
                do {
                    let course = try JSONDecoder().decode(Course.self, from: data)
//                    self.imageCourse.image = UIImage(data: course.imageUrl)
//                    self.activityIndicator.stopAnimating()
                    print(course)
                } catch {
                    print(error.localizedDescription)
                }
            }
            }.resume()
    }
}

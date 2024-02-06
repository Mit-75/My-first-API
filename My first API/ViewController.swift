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
  
    // MARK: - Outlets
    
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
            guard let self = self else { return }
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let course = try JSONDecoder().decode(Course.self, from: data)
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    courseName.text = course.name
                    lessonNumber.text = "Namber of lesson - \(course.number_of_lessons)"
                    testNumber.text = "Namber of test -\(course.number_of_tests)"
                }
                guard let url = URL(string: course.imageUrl) else { return }
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    print(Thread.current)
                    guard let data else { return }
                    self.imageCourse.image = UIImage(data: data)
                    self.activityIndicator.stopAnimating()
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}


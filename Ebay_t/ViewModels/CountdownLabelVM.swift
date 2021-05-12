//
//  CountdownLabelVM.swift
//  Ebay_t
//
//  Created by Pavle Mijatovic on 13.5.21..
//

import UIKit

class CountdownLabelVM {
    
    // MARK: - API
    func startCountdown(completion: @escaping (String) -> Void) {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            let diff = self.getDiff(startTime: Date(), endTimeString: self.date)
            completion(diff)
        }
    }
    
    func stopCountdown() {
        timer?.invalidate()
    }
    
    let date: String
    let textColor = UIColor.white
    let textFont = UIFont.boldSystemFont(ofSize: 30)
    let backgroundColor = UIColor.black
    let alpha = CGFloat(0.6)
    
    var remainingTimeToLaunch: String {
        getDiff(startTime: Date(), endTimeString: self.date)
    }
    
    // MARK: - Properties
    private var timer: Timer?
    
    // MARK: - Inits
    init(date: String) {
        self.date = date
    }

    // MARK: - Helper
    func getDiff(startTime: Date, endTimeString: String) -> String {
        let dateFormatter = DateFormatter()
        let userCalendar = Calendar.current
        let requestedComponent: Set<Calendar.Component> = [.month, .day, .hour, .minute, .second]
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    
        let endTime = dateFormatter.date(from: endTimeString)
        let timeDifference = userCalendar.dateComponents(requestedComponent, from: startTime, to: endTime!)
                
        let diff = "T-: \(timeDifference.day!) d \(timeDifference.hour!) h \(timeDifference.minute!) m \(timeDifference.second!) s"
        return diff
    }
}

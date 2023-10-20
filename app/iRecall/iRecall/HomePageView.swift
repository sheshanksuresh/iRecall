//
//  HomePageView.swift
//  iRecall
//
//  Created by Sheshank Personal on 2023-10-15.
//

import Foundation
import SwiftUI

struct HomePageView: View {
    @Binding var isMenuOpen: Bool
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        VStack {
            // Menu
            BannerView(isMenuOpen: $isMenuOpen)
            
            Spacer()
            
            // Calendar and Topics
            VStack {
                CalendarView(selectedDate: $selectedDate)
                Divider()
                Text ("Today's Topics Placeholder")
            }
        }
    }
}

struct BannerView: View {
    @Binding var isMenuOpen: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation {
                    isMenuOpen.toggle()
                }
            }) {
                Image(systemName: "list.bullet")
            }
            Spacer()
            Text("User's Name") // TODO: Implement logic to replace this with logged in user's first name
            Image(systemName: "person.circle") // TODO: Implement logic to replace this with logged in user's profile picture
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
    }
}

struct CalendarView: View {
    @Binding var selectedDate: Date
    let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let calendar = Calendar.current
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {

            Text(currentMonthAndYear)
                .font(.headline)
            
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                }
            }
            
            ForEach(0..<numberOfWeeksInCurrentMonth, id: \.self) { week in
                HStack {
                    ForEach(0..<7, id: \.self) { day in
                        if let currentDay = dateForCell(week: week, day: day) {
                            Button(action: {
                                selectedDate = currentDay
                            }) {
                                Text(String(calendar.component(.day, from: currentDay)))
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                    .padding()
                                    .background(
                                        Calendar.current.isDate(selectedDate, equalTo: currentDay, toGranularity: .day) ?
                                        Color.blue : Color.clear
                                    )
                                    .foregroundColor(
                                        Calendar.current.isDate(selectedDate, equalTo: currentDay, toGranularity: .day) ?
                                        Color.white : Color.black
                                    )
                                    .cornerRadius(20)
                            }
                        } else {
                            Text("")
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                        }
                    }
                }
            }
        }
    }
    
    var currentMonthAndYear: String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
    var numberOfWeeksInCurrentMonth: Int {
        let calendar = Calendar.current
        let range = calendar.range(of: .weekOfMonth, in: .month, for: Date())!
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: Date()))!
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        let daysInMonth = calendar.range(of: .day, in: .month, for: Date())!.count
        return firstWeekday + daysInMonth <= 36 ? 5 : 6
    }
    
    var daysInCurrentMonth: Int {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: Date())!
        return range.count
    }
    
    func dateForCell(week: Int, day: Int) -> Date? {
        let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: Date()))!
        let firstWeekday = calendar.component(.weekday, from: firstOfMonth)
        var dayOffset = (week * 7) + day - (firstWeekday - 1)
        if dayOffset < 0 || dayOffset >= daysInCurrentMonth {
            return nil
        }
        return calendar.date(byAdding: .day, value: dayOffset, to: firstOfMonth)
    }
}

#Preview {
    HomePageView(isMenuOpen: .constant(false))
}

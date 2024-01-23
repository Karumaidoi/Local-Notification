import SwiftUI
import UserNotifications
import CoreLocation

class Notificationanager {
    
    // Create an instance of the Notifcation Manager
    static let instance = Notificationanager(); // Singleton -> We are instatiating the class
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge];
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("error \(error)")
            } else {
                print(success);
            }
        }
    }
    
    //function to schedule notification
    func scheduleNotification() {
        let content = UNMutableNotificationContent();
        
        content.title = "This is a notification";
        content.subtitle = "Woo Hoo, we sent a notification";
        content.sound = .default;
        content.badge = 1;
        
        // Triggers include
        // Time
        // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false);
        
        // Calendar
         //var dateTrigger = DateComponents();
        //dateTrigger.hour = 23;
        //dateTrigger.minute = 21;
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateTrigger, repeats: false);
        
        // Location
        let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 40.00, longitude: 50.00), radius: 100, identifier: UUID().uuidString);
        region.notifyOnEntry = true;
        region.notifyOnExit = false;
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true);
       
        
        let request = UNNotificationRequest(identifier: UUID().description, content: content, trigger: trigger);
        
        UNUserNotificationCenter.current().add(request);
        
    }
    
    // Cancel Notifications
    func cancelNotifications() {
        // Remove all pending local notifications that are yet to be delivered
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests();
        
        // Removes all Notifications that are already delivered [On the Screen]
        UNUserNotificationCenter.current().removeAllDeliveredNotifications();
    }
    
}

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                Notificationanager.instance.requestAuthorization();
            } label: {
                Text("Request Permission")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
            }//: Button
            .buttonStyle(.borderedProminent)
            .foregroundColor(.accentColor)
            .padding()
            
            Button {
                Notificationanager.instance.scheduleNotification();
            } label: {
                Text("Schedule Notification")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
            }//: Button
            .buttonStyle(.borderedProminent)
            .foregroundColor(.accentColor)
            .padding()
            
            Button {
                Notificationanager.instance.cancelNotifications();
            } label: {
                Text("Cancel Notification")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
            }//: Button
            .buttonStyle(.borderedProminent)
            .foregroundColor(.accentColor)
            .padding()

        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0;
        }
    }
}

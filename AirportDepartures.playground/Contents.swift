import UIKit


//: ## 1. Create custom types to represent an Airport Departures display
//: ![Airport Departures](matthew-smith-5934-unsplash.jpg)
//: Look at data from [Departures at JFK Airport in NYC](https://www.airport-jfk.com/departures.php) for reference.
//:
//: a. Use an `enum` type for the FlightStatus (En Route, Scheduled, Canceled, Delayed, etc.)
//:
//: b. Use a struct to represent an `Airport` (Destination or Arrival)
//:
//: c. Use a struct to represent a `Flight`.
//:
//: d. Use a `Date?` for the departure time since it may be canceled.
//:
//: e. Use a `String?` for the Terminal, since it may not be set yet (i.e.: waiting to arrive on time)
//:
//: f. Use a class to represent a `DepartureBoard` with a list of departure flights, and the current airport
enum FlightStatus: String {
    case En_Route = "En Route"
    case Scheduled = "Scheduled"
    case Canceled = "Canceled"
    case Delayed = "Delayed"
    case On_Time = "On Time"
    case Boarding = "Boarding"
}

struct Airport {
    let name: String
    let departure: Bool
    let arrival: Bool
}

struct Flight{
    var flightNumber: String
    var airline: String
    var departureTime: Date?
    var terminal: String?
    var flightStatus: FlightStatus
    var destination: String
    
    init(departureTime: Date?, destination: String, terminal:String? = nil, flightStatus: FlightStatus = .Scheduled, flightNumber: String, airline:String){
        self.departureTime = departureTime
        self.destination = destination
        self.terminal = terminal
        self.flightStatus = flightStatus
        self.flightNumber = flightNumber
        self.airline = airline
    }
}

class DepartureBoard {
    var departureFlight: [Flight]
    var currentAirport: Airport
    
    init(currentAirpoint: Airport, departureFlight: [Flight] = []){
        self.currentAirport = currentAirpoint
        self.departureFlight = departureFlight
    }
    
    func alertPass (){
        for flight in self.departureFlight{
            switch(flight.flightStatus){
                case FlightStatus.Canceled:
                    print("We're sorry your flight tp \(flight.destination) was canceled, here is a $500 voucher")
                case FlightStatus.Scheduled:
                    var formatTime = ""
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm"
                    if let departTime = flight.departureTime{
                         formatTime = formatter.string(from: departTime)
                    }
                print("Your flight to \(flight.destination) is scheduled to depart at \(formatTime) from terminal: \(flight.terminal!)")
                case FlightStatus.Boarding:
                print("Your flight is boarding, please head to the terminal: \( flight.terminal) immediately.")
                case FlightStatus.On_Time:
                    print("Your flight \(flight.airline) \(flight.flightNumber) is on time")
                case FlightStatus.Delayed:
                    print("Your flight to \(flight.destination) is delayed. Sorry for the inconvenience.")
                case FlightStatus.En_Route:
                    print("Your flight \(flight.airline) \(flight.flightNumber) is en route to \(flight.destination)")
            }
        }
    }
}
//: ## 2. Create 3 flights and add them to a departure board
//: a. For the departure time, use `Date()` for the current time
//:
//: b. Use the Array `append()` method to add `Flight`'s
//:
//: c. Make one of the flights `.canceled` with a `nil` departure time
//:
//: d. Make one of the flights have a `nil` terminal because it has not been decided yet.
//:
//: e. Stretch: Look at the API for [`DateComponents`](https://developer.apple.com/documentation/foundation/datecomponents?language=objc) for creating a specific time
var flight1 = Flight(departureTime: Date(), destination: "Detroit", terminal: "A14", flightStatus: FlightStatus.On_Time, flightNumber: "AA 114", airline: "American Airlines")
var flight2 = Flight(departureTime: Date(), destination: "Maui", terminal: "B13", flightStatus: FlightStatus.Scheduled, flightNumber: "1123", airline: "Delta")
var flight3 = Flight(departureTime: nil, destination: "London", terminal: "C20", flightStatus: FlightStatus.Canceled, flightNumber: "2345", airline: "British Airways")

var RDU = Airport(name: "Raleigh International Airport", departure: true, arrival: false)
var RDU_DepartureBoard = DepartureBoard(currentAirpoint: RDU)

RDU_DepartureBoard.departureFlight.append(flight1)
RDU_DepartureBoard.departureFlight.append(flight2)
RDU_DepartureBoard.departureFlight.append(flight3)
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function

func printDepartures(departureBoard: DepartureBoard){
    for flight in departureBoard.departureFlight{
        var flightInfo = "Destination: \(flight.destination) "
        flightInfo += "Airline: \(flight.airline) "
        flightInfo += " Flight: \(flight.flightNumber) "
        flightInfo += "Departurue Time: "
        if let time = flight.departureTime {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm "
            flightInfo += "\(formatter.string(from: time)) "
        }
        flightInfo += "Terminal: "
        if let term = flight.terminal{
            flightInfo += term
        }
        
        flightInfo += " Status: \(flight.flightStatus.rawValue) "
        print(flightInfo)
    }
}

printDepartures(departureBoard: RDU_DepartureBoard)

//: ## 4. Make a second function to print print an empty string if the `departureTime` is nil
//: a. Createa new `printDepartures2(departureBoard:)` or modify the previous function
//:
//: b. Use optional binding to unwrap any optional values, use string interpolation to turn a non-optional date into a String
//:
//: c. Call the new or udpated function. It should not print `Optional(2019-05-30 17:09:20 +0000)` for departureTime or for the Terminal.
//:
//: d. Stretch: Format the time string so it displays only the time using a [`DateFormatter`](https://developer.apple.com/documentation/foundation/dateformatter) look at the `dateStyle` (none), `timeStyle` (short) and the `string(from:)` method
//:
//: e. Your output should look like:
//:
//:     Destination: Los Angeles Airline: Delta Air Lines Flight: KL 6966 Departure Time:  Terminal: 4 Status: Canceled
//:     Destination: Rochester Airline: Jet Blue Airways Flight: B6 586 Departure Time: 1:26 PM Terminal:  Status: Scheduled
//:     Destination: Boston Airline: KLM Flight: KL 6966 Departure Time: 1:26 PM Terminal: 4 Status: Scheduled



//: ## 5. Add an instance method to your `DepatureBoard` class (above) that can send an alert message to all passengers about their upcoming flight. Loop through the flights and use a `switch` on the flight status variable.
//: a. If the flight is canceled print out: "We're sorry your flight to \(city) was canceled, here is a $500 voucher"
//:
//: b. If the flight is scheduled print out: "Your flight to \(city) is scheduled to depart at \(time) from terminal: \(terminal)"
//:
//: c. If their flight is boarding print out: "Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon."
//:
//: d. If the `departureTime` or `terminal` are optional, use "TBD" instead of a blank String
//:
//: e. If you have any other cases to handle please print out appropriate messages
//:
//: d. Call the `alertPassengers()` function on your `DepartureBoard` object below
//:
//: f. Stretch: Display a custom message if the `terminal` is `nil`, tell the traveler to see the nearest information desk for more details.

RDU_DepartureBoard.alertPass()


//: ## 6. Create a free-standing function to calculate your total airfair for checked bags and destination
//: Use the method signature, and return the airfare as a `Double`
//:
//:     func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
//:     }
//:
//: a. Each bag costs $25
//:
//: b. Each mile costs $0.10
//:
//: c. Multiply the ticket cost by the number of travelers
//:
//: d. Call the function with a variety of inputs (2 bags, 2000 miles, 3 travelers = $750)
//:
//: e. Make sure to cast the numbers to the appropriate types so you calculate the correct airfare
//:
//: f. Stretch: Use a [`NumberFormatter`](https://developer.apple.com/documentation/foundation/numberformatter) with the `currencyStyle` to format the amount in US dollars.
func calculateAirfare (checkedBags: Int, distance: Int, travelers: Int) -> Double {
    return ((Double(checkedBags) * 25) + (Double(distance) * 0.10)) * Double(travelers)
}
let distance = 2000
let travelers = 3
let bags = 2
let amount = calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)
let formatter = NumberFormatter()
formatter.numberStyle = .currency
formatter.maximumFractionDigits = 2
let cost = formatter.string(from: NSNumber(value: amount))
print("A ticket with distance \(distance) mi, \(bags) bags and \(travelers) travelers cost \(cost!)")


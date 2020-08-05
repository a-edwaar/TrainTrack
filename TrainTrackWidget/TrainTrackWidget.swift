//
//  TrainTrackWidget.swift
//  TrainTrackWidget
//
//  Created by Archie Edwards on 07/07/2020.
//

import WidgetKit
import SwiftUI

struct Provider: IntentTimelineProvider {
    public typealias Entry = SimpleEntry
    
    func snapshot(for configuration: GetLatestServicesIntent, with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        
        let stationRequest = StationRequest(station: Station(id: "BHM", name: "Birmingham New Street"), filterStation: Station(id: "BTG", name: "Barnt Green"), type: .departure)
        let services = [Service(id: "id", platform: "1b", station: "Birmingham New Street", status: .onTime, scheduledTime: "14:44", expMins: 10), Service(id: "id", platform: "12b", station: "Manchester", status: .late, scheduledTime: "15:00", expMins: 20), Service(id: "id", platform: "10a", station: "Southamption", status: .late, scheduledTime: "16:22", expMins: 60)]
        let entry = SimpleEntry(date: Date(), stationRequest: stationRequest, services: services)
        completion(entry)
    }
    
    func timeline(for configuration: GetLatestServicesIntent, with context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        
        /// form station request from intent
        var station : Station
        var filterStation : Station?
        if configuration.type == .departure{
            station = Station(id: configuration.DepartingStation!.identifier!, name: configuration.DepartingStation!.description)
            if configuration.CallingStation != nil{
                filterStation = Station(id: configuration.CallingStation!.identifier!, name: configuration.CallingStation!.displayString)
            }
        }else{
            station = Station(id: configuration.ArrivingStation!.identifier!, name: configuration.ArrivingStation!.description)
            if configuration.FromStation != nil{
                filterStation = Station(id: configuration.FromStation!.identifier!, name: configuration.FromStation!.displayString)
            }
        }
        let stationRequest = StationRequest(station: station, filterStation: filterStation, type: configuration.type == .arrival ? .arrival : .departure)
    
        /// get latest updates
        RequestService().getStationUpdate(StationRequest(station: stationRequest.station, filterStation: stationRequest.filterStation, type: stationRequest.type)){ result in
            
            var services = [Service]()
            switch result {
            case .success(let latestServices):
                services = Array(latestServices.prefix(3))
            case .failure(_):
                services = []
            }
            
            /// set expiry to a minute to keep live updates - widget only refreshes in ui after 5 mins atm
            let expiryDate = Calendar
                .current.date(byAdding: .second, value: 1,
                                      to: Date()) ?? Date()
            
            /// create entry
            let entry = SimpleEntry(date: expiryDate, stationRequest: stationRequest, services: services)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
    
    func placeholder(with: Context) -> SimpleEntry {
        let stationRequest = StationRequest(station: Station(id: "BHM", name: "Birmingham New Street"), filterStation: Station(id: "BTG", name: "Barnt Green"), type: .departure)
        let services = [Service(id: "id", platform: "1b", station: "Birmingham New Street", status: .onTime, scheduledTime: "14:44", expMins: 10), Service(id: "id", platform: "12b", station: "Manchester", status: .late, scheduledTime: "15:00", expMins: 20), Service(id: "id", platform: "10a", station: "Southamption", status: .late, scheduledTime: "16:22", expMins: 60)]
        return SimpleEntry(date: Date(), stationRequest: stationRequest, services: services)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let stationRequest: StationRequest
    public let services: [Service]
}

struct TrainTrackWidgetEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry

    var body: some View {
        ForEach(0..<entry.services.count){ serviceIndex in
            ServiceView(service: entry.services[serviceIndex])
            if serviceIndex != entry.services.count - 1{
                Divider()
            }
        }.padding([.horizontal])
    }
}

@main
struct TrainTrackWidget: Widget {
    private let kind: String = "TrainTrackWidget"

    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: GetLatestServicesIntent.self, provider: Provider()){ entry in
            TrainTrackWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("StationBoard Widget")
        .description("This widget shows all services arriving/departing from a station and an optional filter station.")
        .supportedFamilies([.systemLarge])
    }
}

struct TrainTrackWidget_Previews: PreviewProvider {
    static var previews: some View {
        
        let stationRequest = StationRequest(station: Station(id: "BHM", name: "Birmingham New Street"), filterStation: Station(id: "BTG", name: "Barnt Green"), type: .departure)
        
        let services = [Service(id: "id", platform: "1b", station: "Birmingham New Street", status: .onTime, scheduledTime: "14:44", expMins: 10), Service(id: "id", platform: "12b", station: "Manchester", status: .late, scheduledTime: "15:00", expMins: 20), Service(id: "id", platform: "10a", station: "Southamption", status: .late, scheduledTime: "16:22", expMins: 60)]
        
        return TrainTrackWidgetEntryView(entry: SimpleEntry(date: Date(),stationRequest: stationRequest, services: services))
        .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}

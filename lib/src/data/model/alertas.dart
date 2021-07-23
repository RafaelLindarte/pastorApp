
class Alerts {
    Alerts({
        this.items,
        this.count,
        this.scannedCount,
        this.lastEvaluatedKey,
    });

    List<Item>? items;
    int?count ;
    int? scannedCount;
    LastEvaluatedKey? lastEvaluatedKey;

    factory Alerts.fromJson(Map<String, dynamic> json) => Alerts(
        items: List<Item>.from(json["Items"].map((x) => Item.fromJson(x))),
        count: json["Count"],
        scannedCount: json["ScannedCount"],
        lastEvaluatedKey: LastEvaluatedKey.fromJson(json["LastEvaluatedKey"]),
    );

    Map<String, dynamic> toJson() => {
        "Items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "Count": count,
        "ScannedCount": scannedCount,
        "LastEvaluatedKey": lastEvaluatedKey!.toJson(),
    };
}

class Item {
    Item({
        this.eventMunicipalities,
        this.station,
        this.eventDate,
        this.eventDepth,
        this.eventLocation,
        this.eventType,
        this.eventTime,
    });

    dynamic? eventMunicipalities;
    String? station;
    DateTime? eventDate;
    dynamic? eventDepth;
    dynamic? eventLocation;
    String? eventType;
    String? eventTime;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        eventMunicipalities: json["eventMunicipalities"],
        station: json["Station"],
        eventDate: DateTime.parse(json["eventDate"]),
        eventDepth: json["eventDepth"],
        eventLocation: json["eventLocation"],
        eventType: json["eventType"],
        eventTime: json["eventTime"],
    );

    Map<String, dynamic> toJson() => {
        "eventMunicipalities": eventMunicipalities,
        "Station": station,
        "eventDate": "${eventDate!.year.toString().padLeft(4, '0')}-${eventDate!.month.toString().padLeft(2, '0')}-${eventDate!.day.toString().padLeft(2, '0')}",
        "eventDepth": eventDepth,
        "eventLocation": eventLocation,
        "eventType": eventType,
        "eventTime": eventTime,
    };
}

class LastEvaluatedKey {
    LastEvaluatedKey({
        this.id,
        this.createdAt,
        this.eventDate,
    });

    String? id;
    int? createdAt;
    DateTime? eventDate;

    factory LastEvaluatedKey.fromJson(Map<String, dynamic> json) => LastEvaluatedKey(
        id: json["id"],
        createdAt: json["createdAt"],
        eventDate: DateTime.parse(json["eventDate"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt,
        "eventDate": "${eventDate!.year.toString().padLeft(4, '0')}-${eventDate!.month.toString().padLeft(2, '0')}!-${eventDate!.day.toString().padLeft(2, '0')}",
    };
}


/*
.......##.......##..######..##.....##....###....##....##.########...#######..........##....##..#######........##.....##....###....##....##...........###....##.......########.########..########....###.....######........##.......##......########...#######..########........########.####.########.##.....##.########...#######.........######..########.......##.....##.####.########..#######...........###.....######..####...
......##.......##..##....##.##.....##...##.##...###...##.##.....##.##.....##.........###...##.##.....##.......##.....##...##.##....##..##...........##.##...##.......##.......##.....##....##......##.##...##....##......##.......##.......##.....##.##.....##.##.....##..........##.....##..##.......###...###.##.....##.##.....##.......##....##.##.............##.....##..##.......##..##.....##.........##.##...##....##..##....
.....##.......##...##.......##.....##..##...##..####..##.##.....##.##.....##.........####..##.##.....##.......##.....##..##...##....####...........##...##..##.......##.......##.....##....##.....##...##..##...........##.......##........##.....##.##.....##.##.....##..........##.....##..##.......####.####.##.....##.##.....##.......##.......##.............##.....##..##......##...##.....##........##...##..##........##....
....##.......##....##.......##.....##.##.....##.##.##.##.##.....##.##.....##.........##.##.##.##.....##.......#########.##.....##....##...........##.....##.##.......######...########.....##....##.....##..######.....##.......##.........########..##.....##.########...........##.....##..######...##.###.##.########..##.....##........######..######.........#########..##.....##....##.....##.......##.....##..######...##....
...##.......##.....##.......##.....##.#########.##..####.##.....##.##.....##.........##..####.##.....##.......##.....##.#########....##...........#########.##.......##.......##...##......##....#########.......##...##.......##..........##........##.....##.##...##............##.....##..##.......##.....##.##........##.....##.............##.##.............##.....##..##....##.....##.....##.......#########.......##..##....
..##.......##......##....##.##.....##.##.....##.##...###.##.....##.##.....##.........##...###.##.....##.......##.....##.##.....##....##...........##.....##.##.......##.......##....##.....##....##.....##.##....##..##.......##...........##........##.....##.##....##...........##.....##..##.......##.....##.##........##.....##.......##....##.##.............##.....##..##...##......##.....##.......##.....##.##....##..##....
.##.......##........######...#######..##.....##.##....##.########...#######..........##....##..#######........##.....##.##.....##....##...........##.....##.########.########.##.....##....##....##.....##..######..##.......##............##.........#######..##.....##..........##....####.########.##.....##.##.........#######.........######..########.......##.....##.####.########..#######........##.....##..######..####...
*/


class NotMoreAlerts {
    NotMoreAlerts({
        this.items,
        this.count,
        this.scannedCount,
    });

    List<Item>? items;
    int? count;
    int? scannedCount;

    factory NotMoreAlerts.fromJson(Map<String, dynamic> json) => NotMoreAlerts(
        items: List<Item>.from(json["Items"].map((x) => Item.fromJson(x))),
        count: json["Count"],
        scannedCount: json["ScannedCount"],
    );

    Map<String, dynamic> toJson() => {
        "Items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "Count": count,
        "ScannedCount": scannedCount,
    };
}




class UserModel {
    UserModel({
        this.ok,
        this.user,
    });

    bool? ok;
    User? user;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        ok: json["ok"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "user": user!.toJson(),
    };
}

class User {
    User({
        this.lastName,
        this.subscriptions,
        this.stations,
        this.endpointArn,
        this.email,
        this.firstName,
        this.deviceToken,
    });

    String? lastName;
    Subscriptions? subscriptions;
    Stations? stations;
    String? endpointArn;
    String? email;
    String? firstName;
    String? deviceToken;

    factory User.fromJson(Map<String, dynamic> json) => User(
        lastName: json["lastName"],
        subscriptions: Subscriptions.fromJson(json["subscriptions"]),
        stations: Stations.fromJson(json["stations"]),
        endpointArn: json["endpointArn"],
        email: json["email"],
        firstName: json["firstName"],
        deviceToken: json["deviceToken"],
    );

    Map<String, dynamic> toJson() => {
        "lastName": lastName,
        "subscriptions": subscriptions?.toJson(),
        "stations": stations?.toJson(),
        "endpointArn": endpointArn,
        "email": email,
        "firstName": firstName,
        "deviceToken": deviceToken,
    };
}

class Stations {
    Stations();

    factory Stations.fromJson(Map<String, dynamic> json) => Stations(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Subscriptions {
    Subscriptions({
        this.alert,
        this.alerta,
    });

    Alert? alerta;
    Alert? alert;

    factory Subscriptions.fromJson(Map<String, dynamic> json) => Subscriptions(
        alert: Alert.fromJson(json["alert"]),
        alerta: Alert.fromJson(json["alerta"]),
    );

    Map<String, dynamic> toJson() => {
        "alert": alert!.toJson(),
        "alerta": alerta!.toJson(),
    };
}

class Alert {
    Alert({
        this.type,
        this.subscriptionArn,
        this.status,
    });

    String? type;
    String? subscriptionArn;
    String? status;

    factory Alert.fromJson(Map<String, dynamic> json) => Alert(
        type: json["type"],
        subscriptionArn: json["subscriptionArn"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "subscriptionArn": subscriptionArn,
        "status": status,
    };
}

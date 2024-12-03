class NotificationModel {
  Message? message;

  NotificationModel({this.message});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) {
      data['message'] = message!.toJson();
    }
    return data;
  }
}

class Message {
  String? token;
  NotificationItem ? notification;

  Message({this.token, this.notification});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (notification != null) {
      data['notification'] = notification!.toJson();
    }
    return data;
  }
}

class NotificationItem  {
  String? body;
  String? title;

  NotificationItem ({this.body, this.title});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['body'] = body;
    data['title'] = title;
    return data;
  }
}

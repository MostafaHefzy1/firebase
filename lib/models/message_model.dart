class MessageModel {
  String? senderId;
  String? reciverId;
  String? message;
  String? date;

  MessageModel(this.senderId, this.reciverId, this.message, this.date);

  MessageModel.formJson(Map<String, dynamic> json) {
    senderId = json["senderId"];
    reciverId = json["reciverId"];
    message = json["message"];
    date = json["date"];
  }

  Map<String, dynamic> toJson() {
    return {
      "senderId": senderId,
      "reciverId": reciverId,
      "message": message,
      "date": date,
    };
  }
}

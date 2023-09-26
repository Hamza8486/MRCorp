class GetSupportModel {
  List<Faq>? faq;

  GetSupportModel({this.faq});

  GetSupportModel.fromJson(Map<String, dynamic> json) {
    if (json['faq'] != null) {
      faq = <Faq>[];
      json['faq'].forEach((v) {
        faq!.add(new Faq.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.faq != null) {
      data['faq'] = this.faq!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Faq {
  int? id;
  String? question;
  String? answer;
  String? support;
  String? createdAt;
  String? updatedAt;

  Faq(
      {this.id,
        this.question,
        this.answer,
        this.support,
        this.createdAt,
        this.updatedAt});

  Faq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    support = json['support'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['support'] = this.support;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

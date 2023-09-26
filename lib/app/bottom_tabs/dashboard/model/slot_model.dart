class AddSlotModel {
  String? id;
  String? betId;
  String? name;
  String? slot;
  String? total;

  AddSlotModel({
    this.id,
    this.betId,
    this.name,
    this.slot,
    this.total,
  });

  AddSlotModel.fromJson(Map<String, dynamic> json) {
    id = json['province_id'];
    betId = json['bet_id'];
    name = json['name'];
    slot = json['slot'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province_id'] = this.id;
    data['bet_id'] = this.betId;
    data['name'] = this.name;
    data['slot'] = this.slot;
    data['total'] = this.total;
    return data;
  }

  void updateTotal() {
    int currentSlot = int.tryParse(slot ?? '0') ?? 0;
    int previousTotal = int.tryParse(total ?? '0') ?? 0;
    total = (previousTotal + currentSlot).toString();
  }
}
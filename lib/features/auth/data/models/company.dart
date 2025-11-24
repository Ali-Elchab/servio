import 'dart:convert';

class Company {
  final int id;
  final String uuid;
  final String name;
  final String logo;
  final String ownerName;
  final String ownerEmail;
  final String plan;
  final String subscriptionStatus;
  final String currentCycleEnd;

  Company({
    required this.id,
    required this.uuid,
    required this.name,
    required this.logo,
    required this.ownerName,
    required this.ownerEmail,
    required this.plan,
    required this.subscriptionStatus,
    required this.currentCycleEnd,
  });

  Company copyWith({
    int? id,
    String? uuid,
    String? name,
    String? logo,
    String? ownerName,
    String? ownerEmail,
    String? plan,
    String? subscriptionStatus,
    String? currentCycleEnd,
  }) {
    return Company(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      ownerName: ownerName ?? this.ownerName,
      ownerEmail: ownerEmail ?? this.ownerEmail,
      plan: plan ?? this.plan,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      currentCycleEnd: currentCycleEnd ?? this.currentCycleEnd,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uuid': uuid,
      'name': name,
      'logo': logo,
      'owner_name': ownerName,
      'owner_email': ownerEmail,
      'plan': plan,
      'subscription_status': subscriptionStatus,
      'current_cycle_end': currentCycleEnd,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: (map['id'] as num).toInt(),
      uuid: map['uuid'] as String,
      name: map['name'] as String,
      logo: map['logo'] as String,
      ownerName: map['owner_name'] as String,
      ownerEmail: map['owner_email'] as String,
      plan: map['plan'] as String,
      subscriptionStatus: map['subscription_status'] as String,
      currentCycleEnd: map['current_cycle_end'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) => Company.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Company(id: $id, uuid: $uuid, name: $name, logo: $logo, ownerName: $ownerName, ownerEmail: $ownerEmail, plan: $plan, subscriptionStatus: $subscriptionStatus, currentCycleEnd: $currentCycleEnd)';
  }

  @override
  bool operator ==(covariant Company other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.uuid == uuid &&
        other.name == name &&
        other.logo == logo &&
        other.ownerName == ownerName &&
        other.ownerEmail == ownerEmail &&
        other.plan == plan &&
        other.subscriptionStatus == subscriptionStatus &&
        other.currentCycleEnd == currentCycleEnd;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        name.hashCode ^
        logo.hashCode ^
        ownerName.hashCode ^
        ownerEmail.hashCode ^
        plan.hashCode ^
        subscriptionStatus.hashCode ^
        currentCycleEnd.hashCode;
  }
}

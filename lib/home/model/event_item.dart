class EventItem {
  final String img;
  final String desc;

  const EventItem({
    required this.img,
    required this.desc,
  });

  factory EventItem.fromJson(Map<String, dynamic> json) {
    return EventItem(
      img: json['img'] ?? '',
      desc: json['desc'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'img': img,
      'desc': desc,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EventItem && other.img == img && other.desc == desc;
  }

  @override
  int get hashCode => img.hashCode ^ desc.hashCode;

  @override
  String toString() => 'EventItem(img: $img, desc: $desc)';
}

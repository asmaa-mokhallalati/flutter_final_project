class Food {
  late String id;
  late String name;
  late String content;

  late String image;

  Food(
      {required this.id,
      required this.content,
      required this.name,
      required this.image});

  Food.fromMap(Map map) {
    id = map['id'];
    content = map['content'];
    name = map['name'];
    image = map['image'];
  }

  toMap() {
    return {'id': id, 'content': content, 'name': name, 'image': image};
  }
}

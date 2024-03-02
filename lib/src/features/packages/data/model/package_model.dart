class PackageModel {
  List<Package> data;
  Links links;
  Meta meta;

  PackageModel({
    required this.data,
    required this.links,
    required this.meta,
  });
}

class Package {
  int id;
  String name;
  String description;
  int washesCount;
  int days;
  int price;
  bool hasDiscount;
  int discountPrice;
  Authorize authorize;
  DateTime createdAt;
  String createdAtFormatted;

  Package({
    required this.id,
    required this.name,
    required this.description,
    required this.washesCount,
    required this.days,
    required this.price,
    required this.hasDiscount,
    required this.discountPrice,
    required this.authorize,
    required this.createdAt,
    required this.createdAtFormatted,
  });
}

class Authorize {
  bool review;

  Authorize({
    required this.review,
  });
}

class Links {
  String first;
  String last;
  dynamic prev;
  dynamic next;

  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int to;
  int total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });
}

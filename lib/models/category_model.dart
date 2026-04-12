import 'package:evently_c18/common/gen/assets.gen.dart';

class CategoryModel {
  String title;
  String iconPAth;
  String image;
  int id;
  CategoryModel({
    required this.title,
    required this.iconPAth,
    required this.image,
    required this.id,
  });

  static List<CategoryModel> generateCategories() {
    return [
      CategoryModel(
        title: "Book club",
        iconPAth: Assets.icons.book.path,
        image: Assets.images.bookClub.path,
        id: 1,
      ),
      CategoryModel(
        title: "Sports",
        iconPAth: Assets.icons.sportsIconUnselected.path,
        image: Assets.images.sportsDesigne.path,
        id: 2,
      ),
      CategoryModel(
        title: "Birthday",
        iconPAth: Assets.icons.birthdayIcon.path,
        image: Assets.images.birthdayDesigne.path,
        id: 3,
      ),
    ];
  }

  static String getCatImage(int id) {
    List<CategoryModel> categories = generateCategories();
    if (id == 1) return categories[0].image;
    if (id == 2) return categories[1].image;
    if (id == 3) return categories[2].image;
    if (id == 4) return categories[3].image;
    return categories[0].image;
  }
}

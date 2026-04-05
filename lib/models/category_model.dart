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
}

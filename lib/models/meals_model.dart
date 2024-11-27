class MealsModel {
  final String strMeal;
  final String strMealThumb;

  MealsModel({required this.strMeal, required this.strMealThumb});

  factory MealsModel.fromJson(Map<String, dynamic> json) {
    return MealsModel(
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
    );
  }
}

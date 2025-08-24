import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadDataToFirestore() async{
  final CollectionReference ref = FirebaseFirestore.instance.collection('myAppCollection');
  for (final ReceipeModel item in recipes){
    final String id = DateTime.now().toIso8601String() + Random().nextInt(1000).toString();
   // ref.doc("das");
   final ReceipeModel itemWithId = ReceipeModel(
    id: id,
    name: item.name,
    image: item.image,
    ingredients: item.ingredients,
    steps: item.steps,
    category: item.category,
   );

    await ref.doc(id).set(itemWithId.toMap());
  }
}

//final docRef = FirebaseFirestore.instance.collection('recipes').doc();

class ReceipeModel {
   String id;
   String name;
   String image;
   List<String> ingredients;
   List<String> steps;
   String category;

  ReceipeModel({
    required this.id,
    required this.name,
    required this.image,
    required this.ingredients,
    required this.steps,
    required this.category,
  });


Map<String, dynamic> toMap() {
  return {
    'id': id,
    'name': name,
    'image': image,
    'ingredients': ingredients,
    'steps': steps,
    'category': category,
  };
}
}

final List<ReceipeModel> recipes = [
  ReceipeModel(
    id: '',
    name: "Butter Chicken",
    image: "https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=500",
    category: "Non-Veg",
    ingredients: [
      "500g chicken breast, cubed",
      "1 cup yogurt",
      "2 tbsp ginger-garlic paste",
      "1 tsp red chili powder",
      "1 tsp garam masala",
      "1 cup tomato puree",
      "1/2 cup heavy cream",
      "2 tbsp butter",
      "1 tsp kasoori methi",
      "Salt to taste",
      "Fresh coriander for garnish"
    ],
    steps: [
      "Marinate chicken in yogurt, ginger-garlic paste, and spices for 30 minutes",
      "Grill or pan-fry chicken until cooked through",
      "In a pan, heat butter and add tomato puree",
      "Add cream and simmer for 10 minutes",
      "Add cooked chicken and kasoori methi",
      "Garnish with fresh coriander and serve with naan"
    ],
  ),
  ReceipeModel(
     id: '',
    name: "Paneer Tikka",
    image: "https://2.bp.blogspot.com/-neI6rKuvsKI/VyN8GMrfhzI/AAAAAAAAHls/hugFFTKYgs8lrtUSXx0iEyG-KZwL4bPbwCLcB/s1600/tandoori-paneer-tikka4.jpg",
    category: "Vegetarian",
    ingredients: [
      "400g paneer, cubed",
      "1 cup yogurt",
      "2 tbsp ginger-garlic paste",
      "1 tsp red chili powder",
      "1 tsp garam masala",
      "1 tsp turmeric powder",
      "1 tsp cumin powder",
      "2 tbsp mustard oil",
      "Salt to taste",
      "Lemon juice",
      "Fresh mint chutney"
    ],
    steps: [
      "Mix yogurt with all spices and ginger-garlic paste",
      "Marinate paneer cubes in the mixture for 20 minutes",
      "Thread paneer on skewers",
      "Grill or bake at 200°C for 15-20 minutes",
      "Brush with mustard oil while cooking",
      "Serve hot with mint chutney and onion rings"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Gulab Jamun",
    image: "https://recipes.net/wp-content/uploads/2023/05/gulab-jamun-recipe_9fb159dc2674f395436a64666227c988-768x768.jpeg",
    category: "Dessert",
    ingredients: [
      "1 cup khoya (mawa)",
      "1/4 cup all-purpose flour",
      "1/4 tsp baking soda",
      "2 tbsp milk",
      "1 cup sugar",
      "1 cup water",
      "4 cardamom pods",
      "1 tsp rose water",
      "Oil for deep frying"
    ],
    steps: [
      "Mix khoya, flour, and baking soda to form a dough",
      "Make small balls and keep aside",
      "Prepare sugar syrup with water, sugar, and cardamom",
      "Add rose water to the syrup",
      "Deep fry the balls until golden brown",
      "Soak in warm sugar syrup for 30 minutes"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Chicken Biryani",
    image: "https://tse1.mm.bing.net/th/id/OIP.K2oMu6V-1j3ZGIPcX2pbhQHaFj?pid=Api&P=0&h=220",
    category: "Non-Veg",
    ingredients: [
      "2 cups basmati rice",
      "500g chicken, cubed",
      "2 onions, sliced",
      "2 tomatoes, chopped",
      "2 tbsp ginger-garlic paste",
      "1 cup yogurt",
      "Whole spices (cardamom, cinnamon, cloves)",
      "1 tsp biryani masala",
      "Saffron soaked in milk",
      "Fresh mint and coriander",
      "Ghee for cooking"
    ],
    steps: [
      "Marinate chicken in yogurt and spices for 2 hours",
      "Cook rice with whole spices until 70% done",
      "Layer half the rice in a heavy-bottomed pan",
      "Add marinated chicken and fried onions",
      "Add remaining rice and saffron milk",
      "Dum cook on low heat for 30 minutes",
      "Garnish with mint and serve hot"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Rasgulla",
    image: "https://findcrazyfacts.com/wp-content/uploads/2023/07/Interesting-Facts-on-Rasgulla.jpg",
    category: "Dessert",
    ingredients: [
      "1 liter full-fat milk",
      "2 tbsp lemon juice",
      "1 cup sugar",
      "2 cups water",
      "4 cardamom pods",
      "1 tsp rose water",
      "Ice cubes"
    ],
    steps: [
      "Boil milk and add lemon juice to curdle",
      "Strain through muslin cloth and wash with cold water",
      "Knead the chenna until smooth",
      "Make small balls and keep aside",
      "Prepare sugar syrup with water and cardamom",
      "Boil the balls in syrup for 15 minutes",
      "Cool and serve chilled"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Aloo Paratha",
    image: "https://www.spicemountain.co.uk/wp-content/uploads/2020/05/Palak_and_Paneer_Stuffed_Paratha_Recipe-1022.jpg",
    category: "Vegetarian",
    ingredients: [
      "2 cups whole wheat flour",
      "4 boiled potatoes, mashed",
      "1 onion, finely chopped",
      "2 green chilies, chopped",
      "1 tsp cumin seeds",
      "1 tsp red chili powder",
      "1 tsp garam masala",
      "Salt to taste",
      "Ghee for cooking",
      "Yogurt and pickle for serving"
    ],
    steps: [
      "Mix flour with water to make soft dough",
      "Mix mashed potatoes with spices and onion",
      "Divide dough into balls and stuff with potato mixture",
      "Roll out into flat circles",
      "Cook on hot tawa with ghee",
      "Serve hot with yogurt and pickle"
    ],
  ),
  ReceipeModel( 
    id: '',
    name: "Tandoori Chicken",
    image: "https://wallpaperaccess.com/full/4323673.jpg",
    category: "Non-Veg",
    ingredients: [
      "1 kg chicken, cut into pieces",
      "1 cup yogurt",
      "2 tbsp ginger-garlic paste",
      "1 tsp red chili powder",
      "1 tsp garam masala",
      "1 tsp turmeric powder",
      "1 tsp cumin powder",
      "2 tbsp mustard oil",
      "Lemon juice",
      "Salt to taste",
      "Fresh mint chutney"
    ],
    steps: [
      "Make deep cuts in chicken pieces",
      "Mix yogurt with all spices and ginger-garlic paste",
      "Marinate chicken for 4-6 hours",
      "Preheat oven to 200°C",
      "Place chicken on baking tray",
      "Bake for 30-35 minutes until charred",
      "Serve with mint chutney and onion rings"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Kheer",
    image: "https://aartimadan.com/wp-content/uploads/2019/07/rice-kheer-recipe-images-6.jpg",
    category: "Dessert",
    ingredients: [
      "1 liter full-fat milk",
      "1/2 cup basmati rice",
      "1/2 cup sugar",
      "1/4 cup mixed nuts (almonds, pistachios)",
      "1/4 tsp cardamom powder",
      "1 tsp rose water",
      "Saffron strands",
      "Ghee for garnishing"
    ],
    steps: [
      "Wash and soak rice for 30 minutes",
      "Boil milk in a heavy-bottomed pan",
      "Add soaked rice and cook on low heat",
      "Stir continuously until rice is soft",
      "Add sugar and cardamom powder",
      "Cook until thick and creamy",
      "Garnish with nuts and serve hot or cold"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Dhokla",
    image: "https://i0.wp.com/www.ramasrey.com/wp-content/uploads/2018/07/Dhokla.jpg?fit=2075%2C800&ssl=1",
    category: "Vegetarian",
    ingredients: [
      "1 cup gram flour (besan)",
      "1/2 cup yogurt",
      "1/4 cup water",
      "1 tsp ginger paste",
      "1 tsp green chili paste",
      "1/2 tsp turmeric powder",
      "1 tsp fruit salt (eno)",
      "1 tbsp oil",
      "1 tsp mustard seeds",
      "1 tsp sesame seeds",
      "Curry leaves",
      "Salt to taste"
    ],
    steps: [
      "Mix gram flour, yogurt, water, ginger, chili, and turmeric",
      "Let the batter rest for 15 minutes",
      "Add fruit salt and mix gently",
      "Pour into greased steamer plate",
      "Steam for 15-20 minutes until cooked",
      "Temper with mustard seeds, sesame, and curry leaves",
      "Cut into squares and serve with chutney"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Samosa",
    image: "https://images.unsplash.com/photo-1601050690597-df0568f70950?w=500",
    category: "Vegetarian",
    ingredients: [
      "2 cups all-purpose flour",
      "1/4 cup oil",
      "1/2 cup water",
      "3 boiled potatoes, mashed",
      "1/2 cup green peas",
      "1 tsp cumin seeds",
      "1 tsp garam masala",
      "1 tsp red chili powder",
      "1 tsp coriander powder",
      "2 tbsp oil for filling",
      "Oil for deep frying",
      "Salt to taste"
    ],
    steps: [
      "Mix flour, oil, and water to make dough",
      "Rest dough for 30 minutes",
      "Sauté cumin seeds in oil",
      "Add mashed potatoes, peas, and spices",
      "Make triangular pockets with dough",
      "Fill with potato mixture and seal",
      "Deep fry until golden brown",
      "Serve hot with chutney"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Dosa",
    image: "https://www.awesomecuisine.com/wp-content/uploads/2009/06/Plain-Dosa.jpg",
    category: "Vegetarian",
    ingredients: [
      "1 cup rice",
      "1/4 cup urad dal",
      "1/4 cup poha (flattened rice)",
      "1/4 tsp fenugreek seeds",
      "Salt to taste",
      "Oil for cooking",
      "Potato filling (optional)",
      "Coconut chutney for serving"
    ],
    steps: [
      "Soak rice, dal, and fenugreek for 6 hours",
      "Grind to make smooth batter",
      "Ferment overnight or 8-10 hours",
      "Add salt and mix well",
      "Heat tawa and spread batter in circular motion",
      "Drizzle oil and cook until crisp",
      "Serve with potato filling and chutney"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Chilli Potato",
    image: "https://www.mydelicious-recipes.com/home/images/217_1200_1200/mydelicious-recipes-honey-chilli-potato",
    category: "Vegetarian",
    ingredients: [
      "4 medium potatoes, cut into strips",
      "2 tbsp cornflour",
      "2 tbsp all-purpose flour",
      "1 tsp red chili powder",
      "1 tsp garam masala",
      "2 tbsp soy sauce",
      "2 tbsp tomato ketchup",
      "1 tbsp vinegar",
      "2 green chilies, chopped",
      "1 onion, sliced",
      "1 capsicum, sliced",
      "Oil for deep frying",
      "Salt to taste"
    ],
    steps: [
      "Cut potatoes into strips and soak in water",
      "Mix cornflour, flour, and spices",
      "Coat potato strips with flour mixture",
      "Deep fry until golden and crisp",
      "Sauté onions, capsicum, and green chilies",
      "Add soy sauce, ketchup, and vinegar",
      "Add fried potatoes and toss well",
      "Serve hot as appetizer"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Bhindi Sabzi",
    image: "https://i.ytimg.com/vi/Gk4OGEgDAKE/maxresdefault.jpg",
    category: "Vegetarian",
    ingredients: [
      "500g okra (bhindi), cut into pieces",
      "2 onions, finely chopped",
      "2 tomatoes, chopped",
      "1 tsp cumin seeds",
      "1 tsp turmeric powder",
      "1 tsp red chili powder",
      "1 tsp coriander powder",
      "1 tsp garam masala",
      "2 tbsp oil",
      "Fresh coriander for garnish",
      "Salt to taste"
    ],
    steps: [
      "Wash and dry okra thoroughly",
      "Heat oil and add cumin seeds",
      "Add chopped onions and sauté until golden",
      "Add okra and cook on medium heat",
      "Add spices and tomatoes",
      "Cook until okra is crispy and well-cooked",
      "Garnish with fresh coriander",
      "Serve hot with roti or rice"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Matar Paneer",
    image: "https://cdn.grofers.com/assets/search/usecase/banner/matar_paneer_01.png",
    category: "Vegetarian",
    ingredients: [
      "200g paneer, cubed",
      "1 cup green peas",
      "2 onions, chopped",
      "2 tomatoes, pureed",
      "2 tbsp ginger-garlic paste",
      "1 tsp cumin seeds",
      "1 tsp turmeric powder",
      "1 tsp red chili powder",
      "1 tsp garam masala",
      "1/2 cup cream",
      "2 tbsp oil",
      "Fresh coriander for garnish",
      "Salt to taste"
    ],
    steps: [
      "Heat oil and add cumin seeds",
      "Sauté onions until golden brown",
      "Add ginger-garlic paste and spices",
      "Add tomato puree and cook until oil separates",
      "Add green peas and cook for 5 minutes",
      "Add paneer cubes and cream",
      "Simmer for 5 minutes",
      "Garnish with coriander and serve hot"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Veg Biryani",
    image: "https://i.pinimg.com/originals/5f/b1/01/5fb10121bbda41c22ab3f206265ab3a2.jpg",
    category: "Vegetarian",
    ingredients: [
      "2 cups basmati rice",
      "1 cup mixed vegetables (carrots, beans, peas, cauliflower)",
      "2 onions, sliced",
      "2 tomatoes, chopped",
      "2 tbsp ginger-garlic paste",
      "1 cup yogurt",
      "Whole spices (cardamom, cinnamon, cloves, bay leaves)",
      "1 tsp biryani masala",
      "Saffron soaked in milk",
      "Fresh mint and coriander",
      "Ghee for cooking",
      "Salt to taste"
    ],
    steps: [
      "Marinate vegetables in yogurt and spices for 1 hour",
      "Cook rice with whole spices until 70% done",
      "Layer half the rice in a heavy-bottomed pan",
      "Add marinated vegetables and fried onions",
      "Add remaining rice and saffron milk",
      "Dum cook on low heat for 30 minutes",
      "Garnish with mint and serve hot"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Masala Chai",
    image: "https://carameltintedlife.com/wp-content/uploads/2021/01/Masala-Chai-.jpg",
    category: "Beverage",
    ingredients: [
      "2 cups water",
      "1 cup milk",
      "2 tbsp black tea leaves",
      "2 tbsp sugar",
      "4 cardamom pods",
      "1 inch ginger, crushed",
      "4 black peppercorns",
      "2 cloves",
      "1 cinnamon stick",
      "2 bay leaves"
    ],
    steps: [
      "Boil water with all spices for 5 minutes",
      "Add tea leaves and simmer for 2 minutes",
      "Add milk and sugar",
      "Bring to boil and simmer for 3 minutes",
      "Strain and serve hot",
      "Perfect with biscuits or snacks"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Filter Coffee",
    image: "https://cdn.zmescience.com/wp-content/uploads/2018/04/Cappuccino_at_Sightglass_Coffee.jpg",
    category: "Beverage",
    ingredients: [
      "2 tbsp coffee powder",
      "1 cup hot water",
      "1/2 cup milk",
      "2 tbsp sugar",
      "Coffee filter",
      "Coffee decoction"
    ],
    steps: [
      "Place coffee powder in filter",
      "Pour hot water slowly to make decoction",
      "Heat milk until frothy",
      "Mix decoction with hot milk",
      "Add sugar to taste",
      "Serve in traditional steel tumbler"
    ],
  ),
 ReceipeModel(
    id: '',
    name: "Margherita Pizza",
    image: "https://images.unsplash.com/photo-1604382355076-af4b0eb60143?w=500",
    category: "Vegetarian",
    ingredients: [
      "2 cups all-purpose flour",
      "1 cup warm water",
      "2 1/4 tsp active dry yeast",
      "1 tsp salt",
      "1 tbsp olive oil",
      "1 cup tomato sauce",
      "2 cups mozzarella cheese",
      "Fresh basil leaves",
      "Salt and pepper to taste"
    ],
    steps: [
      "Mix flour, yeast, and salt in a large bowl",
      "Add warm water and olive oil, knead for 10 minutes",
      "Let dough rise for 1 hour in a warm place",
      "Roll out dough and add tomato sauce",
      "Top with mozzarella cheese and basil",
      "Bake at 450°F for 15-20 minutes"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Vanilla Ice Cream",
    image: "https://quickhomemaderecipes.com/wp-content/uploads/2024/03/Vanilla-ice-cream.jpg",
    category: "Dessert",
    ingredients: [
      "2 cups heavy cream",
      "1 cup whole milk",
      "3/4 cup sugar",
      "6 egg yolks",
      "2 tsp vanilla extract",
      "Pinch of salt",
      "Ice cream maker"
    ],
    steps: [
      "Heat milk and cream in a saucepan",
      "Whisk egg yolks and sugar until pale",
      "Slowly add hot milk to egg mixture",
      "Return to pan and cook until thickened",
      "Add vanilla extract and cool completely",
      "Churn in ice cream maker for 20 minutes",
      "Freeze for 4 hours before serving"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Chole Bhature",
    image: "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiSLB7zfxFCFag7Pt9CHnH3wk61PILgDo5CCTxT01YjSmEKOVY6uskLp8qEnLi8sIsAAMBOWo4AGXHUavOeuWowkrR4u4QtSlryJKCwcR837ajLT906ZOcBhwQuomU453tC8azJe5SikPUleEkJhz-FmTQKa8frlxB7tir-_0V97PqF89QHvQfh5iNH/s16000/IMG_20220904_210330.jpg",
    category: "Vegetarian",
    ingredients: [
      "2 cups chickpeas (chole), soaked overnight",
      "2 onions, chopped",
      "2 tomatoes, chopped",
      "2 tbsp ginger-garlic paste",
      "1 tsp cumin seeds",
      "1 tsp turmeric powder",
      "1 tsp red chili powder",
      "1 tsp garam masala",
      "1 tsp chole masala",
      "2 tbsp oil",
      "For Bhature: 2 cups all-purpose flour, 1/2 cup yogurt, 1/4 cup oil, salt",
      "Fresh coriander for garnish"
    ],
    steps: [
      "Pressure cook chickpeas until soft",
      "Heat oil and add cumin seeds",
      "Sauté onions and ginger-garlic paste",
      "Add tomatoes and spices",
      "Add cooked chickpeas and simmer",
      "For bhature: Mix flour, yogurt, oil, and salt",
      "Make dough and rest for 2 hours",
      "Roll and deep fry until puffed",
      "Serve hot with chole"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Aloo Sabzi",
    image: "https://simplysimplecooking.net/wp-content/uploads/2023/12/potato-sabji-2.webp",
    category: "Vegetarian",
    ingredients: [
      "4 medium potatoes, boiled and cubed",
      "2 onions, finely chopped",
      "2 tomatoes, chopped",
      "1 tsp cumin seeds",
      "1 tsp mustard seeds",
      "1 tsp turmeric powder",
      "1 tsp red chili powder",
      "1 tsp coriander powder",
      "1 tsp garam masala",
      "2 tbsp oil",
      "Fresh coriander for garnish",
      "Salt to taste"
    ],
    steps: [
      "Heat oil and add cumin and mustard seeds",
      "Add chopped onions and sauté until golden",
      "Add tomatoes and all spices",
      "Cook until oil separates",
      "Add boiled potato cubes",
      "Mix gently and cook for 5 minutes",
      "Garnish with fresh coriander",
      "Serve hot with roti or rice"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Peri Peri Fries",
    image: "http://media2.s-nbcnews.com/i/newscms/2017_28/1228087/french-fries-and-ketchup-today-tease-170712_55b45596b3cb8ab19f3e4475dbb5cd9e.jpg",
    category: "Vegetarian",
    ingredients: [
      "4 large potatoes, cut into fries",
      "2 tbsp olive oil",
      "2 tbsp peri peri sauce",
      "1 tsp paprika",
      "1 tsp garlic powder",
      "1 tsp onion powder",
      "1/2 tsp salt",
      "1/2 tsp black pepper",
      "Fresh parsley for garnish"
    ],
    steps: [
      "Cut potatoes into thin fries",
      "Soak in cold water for 30 minutes",
      "Drain and pat dry completely",
      "Toss with olive oil and spices",
      "Arrange on baking sheet",
      "Bake at 425°F for 25-30 minutes",
      "Toss with peri peri sauce",
      "Garnish with parsley and serve hot"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Aloo Tikki Chaat",
    image: "https://onlyinyourstate.in/wp-content/uploads/2018/11/Aloo-Tikki-Chat-Street-Food-in-Delhi-768x493.jpg",
    category: "Vegetarian",
    ingredients: [
      "4 boiled potatoes, mashed",
      "1/2 cup breadcrumbs",
      "1 tsp red chili powder",
      "1 tsp garam masala",
      "1 tsp chaat masala",
      "2 tbsp oil for frying",
      "For Chaat: Yogurt, tamarind chutney, mint chutney",
      "Sev, chopped onions, coriander",
      "Salt to taste"
    ],
    steps: [
      "Mix mashed potatoes with spices and breadcrumbs",
      "Shape into flat round tikkis",
      "Heat oil and shallow fry until golden",
      "Place tikki on serving plate",
      "Top with yogurt and chutneys",
      "Sprinkle sev, onions, and coriander",
      "Add chaat masala and serve immediately"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Idli",
    image: "https://assets.telegraphindia.com/abp/2023/Mar/1680193226_idli.jpg",
    category: "Vegetarian",
    ingredients: [
      "2 cups idli rice",
      "1 cup urad dal",
      "1/4 cup poha (flattened rice)",
      "1/4 tsp fenugreek seeds",
      "Salt to taste",
      "Idli steamer",
      "Coconut chutney and sambar for serving"
    ],
    steps: [
      "Soak rice, dal, and fenugreek separately for 6 hours",
      "Grind urad dal to smooth paste",
      "Grind rice and poha to coarse paste",
      "Mix both batters and ferment overnight",
      "Add salt and mix gently",
      "Pour into greased idli molds",
      "Steam for 10-12 minutes",
      "Serve hot with chutney and sambar"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Fried Idli Chilli",
    image: "https://www.shreetirupatikhiru.com/wp-content/uploads/2020/06/1.jpg",
    category: "Vegetarian",
    ingredients: [
      "8 leftover idlis, cut into cubes",
      "2 tbsp cornflour",
      "1 tbsp all-purpose flour",
      "1 tsp red chili powder",
      "1 tsp garam masala",
      "2 tbsp soy sauce",
      "2 tbsp tomato ketchup",
      "1 tbsp vinegar",
      "2 green chilies, chopped",
      "1 onion, sliced",
      "1 capsicum, sliced",
      "Oil for deep frying",
      "Salt to taste"
    ],
    steps: [
      "Cut idlis into cubes",
      "Mix cornflour, flour, and spices",
      "Coat idli cubes with flour mixture",
      "Deep fry until golden and crisp",
      "Sauté onions, capsicum, and green chilies",
      "Add soy sauce, ketchup, and vinegar",
      "Add fried idli cubes and toss well",
      "Serve hot as appetizer"
    ],
  ),
  ReceipeModel(
    id: '',
    name: "Moong Dal Halwa",
    image: "https://indianbreakfastrecipes.com/wp-content/uploads/2024/10/moong-dal-halwa1-1920x1080-1.png",
    category: "Dessert",
    ingredients: [
      "1 cup moong dal, soaked for 4 hours",
      "1/2 cup ghee",
      "1 cup sugar",
      "1/2 cup milk",
      "1/4 cup mixed nuts (almonds, pistachios)",
      "1/4 tsp cardamom powder", 
      "1/4 tsp saffron strands",
      "Silver leaf for garnish"
    ],
    steps: [
      "Grind soaked moong dal to fine paste",
      "Heat ghee in a heavy-bottomed pan",
      "Add moong dal paste and cook on low heat",
      "Stir continuously until golden brown",
      "Add milk and cook until absorbed",
      "Add sugar and cardamom powder",
      "Cook until mixture thickens",
      "Garnish with nuts and silver leaf",
      "Serve hot or warm"
    ],
  ),
];

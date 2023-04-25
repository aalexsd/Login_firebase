class Product {
  final String productName;
  final String productImageUrl;
  final String currentPrice;
  final String oldPrice;
  final bool isLiked;
  final bool isPromotion;

  const Product({
    required this.productName,
    required this.productImageUrl,
    required this.currentPrice,
    required this.oldPrice,
    required this.isLiked,
    required this.isPromotion,
  });
}

class Category {
  final String categoryName;
  final String productCount;
  final String thumbnailImage;

  const Category({
    required this.categoryName,
    required this.productCount,
    required this.thumbnailImage,
  });
}

// list of products
final products = [
  const Product(
    productName: "Apple - iPhone 14 Pro",
    productImageUrl:
        "https://www.iplace.com.br/ccstore/v1/images/?source=/file/v256378258670298553/products/222253.01-apple-iphone-14-pro-128gb-roxo-profundo-mq0g3be-a.jpg&height=350&width=350&quality=1.0",
    currentPrice: "6999",
    oldPrice: "8000",
    isLiked: true,
    isPromotion: false,
  ),
  const Product(
    productName: "Apple - iPhone 13 Pro",
    productImageUrl:
        "https://www.iplace.com.br/ccstore/v1/images/?source=/file/v3072666941191469708/products/216250.00-apple-iphone-13-pro-512gb-azul-sierra-mlvu3bz-a.jpg&height=424&width=424&quality=0.9",
    currentPrice: "6000",
    oldPrice: "7000",
    isLiked: false,
    isPromotion: false,
  ),
  const Product(
    productName: "Apple - iPhone 12",
    productImageUrl:
        "https://carrefourbr.vtexassets.com/arquivos/ids/41870000-540-auto?v=637835759429070000&width=540&height=auto&aspect=true",
    currentPrice: "5000",
    oldPrice: "6000",
    isLiked: false,
    isPromotion: true,
  ),
  const Product(
    productName: "Apple - iPhone 11",
    productImageUrl:
        "https://carrefourbr.vtexassets.com/arquivos/ids/94712018/e94efcb349384be586a8a19422588e66.jpg?v=638088949482800000",
    currentPrice: "3500",
    oldPrice: "4000",
    isLiked: true,
    isPromotion: true,
  ),
  const Product(
    productName: "Console Xbox Series S",
    productImageUrl:
        "https://static.nagem.com.br/util/artefatos/produtos/m/n/920341670352537/525316_1.jpg",
    currentPrice: "2000",
    oldPrice: "3000",
    isLiked: false,
    isPromotion: true,
  ),
  const Product(
    productName: "Console Playstation 5",
    productImageUrl:
        "https://t.ctcdn.com.br/ZmNiqbLg1jVlxkL_-Wn3r8Ouq9Y=/fit-in/400x400/filters:format(webp):fill(transparent):watermark(wm/prd.png,-32p,center,1,none,15)/i413671.png",
    currentPrice: "4000",
    oldPrice: "5000",
    isLiked: true,
    isPromotion: true,
  ),
  const Product(
    productName: "Samsung - Galaxy S23 Ultra",
    productImageUrl:
        "https://www.girafa.com.br/visao/default/img/produtos/smartphone/celulares/smartphone-samsung-galaxy-s23-ultra-5g-256gb-6-8-bege-e-snapdragon-909816-1674749953-7-preview.jpg",
    currentPrice: "5000",
    oldPrice: "6000",
    isLiked: false,
    isPromotion: true,
  ),
  const Product(
    productName: "Samsung - Galaxy ZFold 4",
    productImageUrl:
        "https://www.oficinadanet.com.br/imagens/obj_item/1356/fold4.jpg",
    currentPrice: "6000",
    oldPrice: "8000",
    isLiked: false,
    isPromotion: true,
  ),
  const Product(
    productName: "Apple - MacBook Pro M1",
    productImageUrl: "https://i.zst.com.br/thumbs/12/23/39/1272724388.jpg",
    currentPrice: "9000",
    oldPrice: "10000",
    isLiked: false,
    isPromotion: false,
  ),
  const Product(
    productName: "Dell - Alieanware",
    productImageUrl:
        "https://m.media-amazon.com/images/I/51BQ2IKGxdL._AC_SY450_.jpg",
    currentPrice: "11000",
    oldPrice: "12000",
    isLiked: true,
    isPromotion: false,
  ),
];

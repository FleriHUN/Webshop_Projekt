-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Gép: localhost:3306
-- Létrehozás ideje: 2026. Jan 14. 11:25
-- Kiszolgáló verziója: 5.7.24
-- PHP verzió: 8.3.1


SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `furniture_store`
--

DELIMITER $$
--
-- Eljárások
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getFirstThreeProduct` ()   BEGIN
	SELECT * FROM product WHERE 
    product.is_deleted = 0 
    LIMIT 3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getProductById` (IN `idIN` INT)   BEGIN 
	SELECT * FROM product 
    WHERE 
    product.id = idIN
    AND 
    product.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserByEmail` (IN `emailIN` VARCHAR(100))   BEGIN
	SELECT * FROM user WHERE user.email = emailIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login` (IN `emailIN` VARCHAR(255), IN `passwordIN` VARCHAR(255))   BEGIN 
	SELECT * FROM user WHERE user.email = emailIN AND user.password = passwordIN;
    
    UPDATE user
SET user.last_login=CURRENT_TIMESTAMP
WHERE user.email= emailIN AND user.password = passwordIN;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `address_type`
--

CREATE TABLE `address_type` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `address_type`
--

INSERT INTO `address_type` (`id`, `name`) VALUES
(1, 'a');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `billing_detail`
--

CREATE TABLE `billing_detail` (
  `id` int(11) NOT NULL,
  `post_code` int(4) NOT NULL,
  `town` varchar(100) NOT NULL,
  `address` longtext NOT NULL,
  `address_type_id` int(11) NOT NULL,
  `house_number` int(3) NOT NULL,
  `company_name` varchar(100) DEFAULT NULL,
  `company_tax_number` varchar(10) DEFAULT NULL,
  `other` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `billing_detail`
--

INSERT INTO `billing_detail` (`id`, `post_code`, `town`, `address`, `address_type_id`, `house_number`, `company_name`, `company_tax_number`, `other`) VALUES
(1, 1, 'a', 'a', 1, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `brand`
--

CREATE TABLE `brand` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `brand`
--

INSERT INTO `brand` (`id`, `name`, `is_deleted`, `deleted_at`) VALUES
(1, 'a', 0, NULL),
(2, 'IKEA\r\n', 0, NULL),
(3, 'Herman Miller', 0, NULL),
(4, 'West Elm', 0, NULL),
(5, 'Ashley Furniture', 0, NULL),
(6, 'Pottery Barn', 0, NULL),
(7, 'Restoration Hardware', 0, NULL),
(8, 'Muuto', 0, NULL),
(9, 'BoConcept', 0, NULL),
(10, 'Vitra', 0, NULL),
(11, 'Crate & Barrel', 0, NULL),
(12, 'CB2', 0, NULL),
(13, 'Roche Bobois', 0, NULL),
(14, 'Design Within Reach', 0, NULL),
(15, 'Kartell', 0, NULL),
(16, 'Hay', 0, NULL),
(17, 'Natuzzi', 0, NULL),
(18, 'Bolia', 0, NULL),
(19, 'Timberland Furniture', 0, NULL),
(20, 'Calligaris', 0, NULL),
(21, 'Habitat', 0, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `last_modified` datetime NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `cart`
--

INSERT INTO `cart` (`id`, `user_id`, `last_modified`, `created_at`) VALUES
(1, 1, '2025-12-02 08:13:33', '2025-12-02 08:13:33'),
(2, 2, '2025-12-02 08:13:33', '2025-12-02 08:13:33');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `cart_product`
--

CREATE TABLE `cart_product` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `cart_product`
--

INSERT INTO `cart_product` (`id`, `product_id`, `cart_id`, `amount`, `created_at`, `last_modified_at`) VALUES
(1, 3, 1, 1000, '2025-12-02 09:32:55', NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `category`
--

INSERT INTO `category` (`id`, `name`, `is_deleted`, `deleted_at`) VALUES
(1, 'szék', 0, NULL),
(2, 'Ülőbútorok', 0, NULL),
(3, 'Asztalok', 0, NULL),
(4, 'Tárplóbútorok', 0, NULL),
(5, 'Szekrények', 0, NULL),
(6, 'Ágyak', 0, NULL),
(7, 'Matracok', 0, NULL),
(8, 'Kanapék', 0, NULL),
(9, 'Fotelek', 0, NULL),
(10, 'Székek', 0, NULL),
(11, 'Íróasztalok', 0, NULL),
(12, 'Komódok', 0, NULL),
(13, 'Polcok és könyvespolcok', 0, NULL),
(14, 'Gardróbszekrények', 0, NULL),
(15, 'TV-állványok', 0, NULL),
(16, 'Előszobabútorok', 0, NULL),
(17, 'Konyhabútorok', 0, NULL),
(18, 'Fürdőszobabútorok', 0, NULL),
(19, 'Gyerekbútorok', 0, NULL),
(20, 'Irodabútorok', 0, NULL),
(21, 'Kerti bútorok', 0, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `order_history`
--

CREATE TABLE `order_history` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL,
  `billing_detail_id` int(11) NOT NULL,
  `transport_detail_id` int(11) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `ordered_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `canceled_at` datetime DEFAULT NULL,
  `is_canceled` tinyint(1) NOT NULL DEFAULT '0',
  `canceler_user_id` int(11) DEFAULT NULL,
  `order_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `order_history`
--

INSERT INTO `order_history` (`id`, `first_name`, `last_name`, `phone`, `email`, `user_id`, `billing_detail_id`, `transport_detail_id`, `payment_method_id`, `status_id`, `ordered_at`, `canceled_at`, `is_canceled`, `canceler_user_id`, `order_id`) VALUES
(1, 'test1', 'test1', '0670100000', 'test1@gmail.com', 1, 1, 1, 1, 1, '2025-12-02 08:29:33', NULL, 0, NULL, 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `order_product`
--

CREATE TABLE `order_product` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_at` datetime DEFAULT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `order_product`
--

INSERT INTO `order_product` (`id`, `order_id`, `product_id`, `created_at`, `modified_at`, `amount`) VALUES
(1, 1, 1, '2025-12-02 09:30:09', NULL, 1000);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `payment_method`
--

CREATE TABLE `payment_method` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `payment_method`
--

INSERT INTO `payment_method` (`id`, `name`) VALUES
(1, 'a');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `prodcut_category`
--

CREATE TABLE `prodcut_category` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `prodcut_category`
--

INSERT INTO `prodcut_category` (`id`, `category_id`, `product_id`) VALUES
(1, 1, 1),
(3, 1, 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `height_in_cm` double NOT NULL,
  `width_in_cm` double NOT NULL,
  `depth_in_cm` double NOT NULL,
  `weight_in_kg` double NOT NULL,
  `photo_list_id` int(11) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `price` int(6) NOT NULL,
  `category_id` int(11) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `product`
--

INSERT INTO `product` (`id`, `name`, `description`, `height_in_cm`, `width_in_cm`, `depth_in_cm`, `weight_in_kg`, `photo_list_id`, `brand_id`, `price`, `category_id`, `is_deleted`, `deleted_at`) VALUES
(1, 'Sarokkanapé', 'L-alakú ülőbútor, több személy számára, gyakran ágyneműtartóval.\r\n', 85, 260, 200, 120, 1, 1, 10, 1, 0, NULL),
(2, 'Kerti asztal\r\n', 'Kültéri használatra tervezett asztal.\r\n', 1, 1, 1, 1, 33, 1, 1, 1, 0, NULL),
(3, 'Háromszemélyes kanapé\r\n', 'Kényelmes ülőbútor nappaliba, klasszikus elrendezéshez.\r\n', 10, 10, 10, 10, 34, 1, 100, 1, 0, NULL),
(4, 'Fotelszék', 'Egy személy számára kialakított, kényelmes ülőalkalmatosság.\r\n', 1, 1, 1, 1, 35, 1, 1, 1, 0, NULL),
(5, 'Étkezőszék', 'Étkezőasztalhoz tervezett szék, háttámlával.\r\n', 1, 1, 1, 1, 36, 1, 1, 1, 0, NULL),
(6, 'Étkezőasztal', 'Több személyes étkezésekhez alkalmas asztal.\r\n', 1, 1, 1, 1, 37, 1, 1, 1, 0, NULL),
(7, 'Dohányzóasztal\r\n', 'Alacsony asztal nappaliba, kanapé elé.\r\n', 1, 1, 1, 1, 38, 1, 1, 1, 0, NULL),
(8, 'TV-állvány\r\n', 'Televízió és multimédiás eszközök elhelyezésére.\r\n', 1, 1, 1, 1, 39, 1, 1, 1, 0, NULL),
(9, 'Könyvespolc\r\n', 'Könyvek és dekorációk tárolására szolgáló polcrendszer.\r\n', 1, 1, 1, 1, 40, 1, 1, 1, 0, NULL),
(10, 'Komód', 'Fiókos tárolóbútor ruhák vagy kiegészítők számára.\r\n', 1, 1, 1, 1, 41, 1, 1, 1, 0, NULL),
(11, 'Ruhásszekrény', 'Ruhák tárolására alkalmas szekrény akasztóval és polcokkal.\r\n', 1, 1, 1, 1, 42, 1, 1, 1, 0, NULL),
(12, 'Gardróbszekrény', 'Nagy méretű ruhatároló, több rekesszel.\r\n', 1, 1, 1, 1, 43, 1, 1, 1, 0, NULL),
(13, 'Franciaágy\r\n', 'Kétszemélyes ágy, matraccal vagy matrac nélkül.\r\n', 1, 1, 1, 1, 44, 1, 1, 1, 0, NULL),
(14, 'Egyszemélyes ágy\r\n', 'Egy személy részére kialakított fekvőbútor.\r\n', 1, 1, 1, 1, 45, 1, 1, 1, 0, NULL),
(15, 'Éjjeliszekrény\r\n', 'Ágy melletti kis tárolóbútor.\r\n', 1, 1, 1, 1, 46, 1, 1, 1, 0, NULL),
(16, 'Íróasztal\r\n', 'Tanuláshoz vagy munkához használt asztal.\r\n', 1, 1, 1, 1, 47, 1, 1, 1, 0, NULL),
(17, 'Irodai forgószék\r\n', 'Állítható magasságú, kerekes munkaszék.\r\n', 1, 1, 1, 1, 48, 1, 1, 1, 0, NULL),
(18, 'Cipősszekrény\r\n', 'Cipők rendszerezett tárolására.\r\n', 1, 1, 1, 1, 49, 1, 1, 1, 0, NULL),
(19, 'Előszobafal\r\n', 'Akasztókkal, polcokkal és tükörrel ellátott előszobabútor.\r\n', 1, 1, 1, 1, 50, 1, 1, 1, 0, NULL),
(20, 'Konyhaszekrény', 'Konyhai tárolóbútor edények és élelmiszerek számára.\r\n', 1, 1, 1, 1, 51, 1, 1, 1, 0, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `product_image`
--

CREATE TABLE `product_image` (
  `id` int(11) NOT NULL,
  `photo_1` longtext NOT NULL,
  `photo_2` longtext NOT NULL,
  `photo_3` longtext NOT NULL,
  `photo_4` longtext NOT NULL,
  `photo_5` longtext NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `product_image`
--

INSERT INTO `product_image` (`id`, `photo_1`, `photo_2`, `photo_3`, `photo_4`, `photo_5`, `is_deleted`, `deleted_at`) VALUES
(1, 'aa', 'a', 'a', 'a', 'a', 0, NULL),
(33, 'a', 'a', 'a', 'a', 'a', 0, NULL),
(34, 'a', 'a', 'a', 'a', 'a', 0, NULL),
(35, 'a', 'a', 'a', 'a', 'a', 0, NULL),
(36, 'a', 'a', 'a', 'a', 'a', 0, NULL),
(37, 'a', 'a', 'a', 'a', 'a', 0, NULL),
(38, 'a', 'a', 'a', 'a', 'a', 0, NULL),
(39, 'a', 'a', 'a', 'a', 'a', 0, NULL),
(40, 'a', 'a', 'a', 'a', 'a', 0, NULL),
(41, 'a', 'a', 'a', 'a', 'a', 0, NULL),
(42, 'a', 'a', 'a', 'a', 'a', 0, NULL),
(43, 'a', 'a', 'a', 'a', 'a', 0, NULL),
(44, 'a', 'a', 'a', 'a', 'a', 0, NULL),
(45, 'a', 'a', 'a', 'a', 'a', 0, NULL),
(46, 'a', 'a', 'a', 'a', 'a', 0, NULL),
(47, 'a', 'a', 'a', 'a', 'a', 0, NULL),
(48, 'a', 'a', 'a', 'a', 'a', 0, NULL),
(49, 'a', 'a', 'a', 'a', 'a', 0, NULL),
(50, 'a', 'a', 'a', 'a', 'a', 0, NULL),
(51, 'a', 'a', 'a', 'a', 'a', 0, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `review`
--

CREATE TABLE `review` (
  `id` int(11) NOT NULL,
  `review_text` longtext NOT NULL,
  `rating` float NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `is_anonymus` tinyint(1) NOT NULL DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `review`
--

INSERT INTO `review` (`id`, `review_text`, `rating`, `user_id`, `product_id`, `is_anonymus`, `is_deleted`, `deleted_at`, `created_at`) VALUES
(1, 'a', 1, 1, 1, 0, 0, NULL, '2025-12-02 08:39:15');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `role`
--

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(1, 'ROLE_user');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `status`
--

CREATE TABLE `status` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `status`
--

INSERT INTO `status` (`id`, `name`) VALUES
(1, 'status1');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `transport_detail`
--

CREATE TABLE `transport_detail` (
  `id` int(11) NOT NULL,
  `post_code` int(11) NOT NULL,
  `town` varchar(11) NOT NULL,
  `address` varchar(11) NOT NULL,
  `address_type_id` int(11) NOT NULL,
  `house_number` int(11) NOT NULL,
  `other` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `transport_detail`
--

INSERT INTO `transport_detail` (`id`, `post_code`, `town`, `address`, `address_type_id`, `house_number`, `other`) VALUES
(1, 1, 'a', 'a', 1, 1, '1');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `register_at` timestamp NULL DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `pfp_path` longtext NOT NULL,
  `role_id` int(1) NOT NULL DEFAULT '1',
  `register_finished_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`, `phone`, `last_login`, `register_at`, `is_deleted`, `deleted_at`, `pfp_path`, `role_id`, `register_finished_at`) VALUES
(1, 'test1', 'test1@gmail.com', 'test5.Asd', '06710000000', '2025-12-02 11:23:25', '2025-12-01 15:11:01', 0, NULL, 'a', 1, '2025-12-02 07:20:58'),
(2, 'test2', 'test2@gmail.com', 'test2', '06701000000', '2025-12-02 07:11:01', '2025-12-02 07:11:01', 0, NULL, 'b', 1, '2025-12-02 07:20:58'),
(3, 'postTest1', 'test@gmail.com', 'test5.As', 'asd', NULL, NULL, 0, NULL, '', 1, '2025-12-02 10:26:38');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `address_type`
--
ALTER TABLE `address_type`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `billing_detail`
--
ALTER TABLE `billing_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `billing_address_type` (`address_type_id`);

--
-- A tábla indexei `brand`
--
ALTER TABLE `brand`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- A tábla indexei `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `basket_user` (`user_id`);

--
-- A tábla indexei `cart_product`
--
ALTER TABLE `cart_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `basket_product` (`product_id`),
  ADD KEY `basket_product_basket` (`cart_id`);

--
-- A tábla indexei `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `order_history`
--
ALTER TABLE `order_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_history_user` (`user_id`),
  ADD KEY `order_history_payment_method` (`payment_method_id`),
  ADD KEY `order_history_canceler_user_id` (`canceler_user_id`),
  ADD KEY `order_history_billing_id` (`billing_detail_id`),
  ADD KEY `order_history_transport_id` (`transport_detail_id`),
  ADD KEY `order_status` (`status_id`);

--
-- A tábla indexei `order_product`
--
ALTER TABLE `order_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_history_product` (`product_id`),
  ADD KEY `order_history` (`order_id`);

--
-- A tábla indexei `payment_method`
--
ALTER TABLE `payment_method`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `prodcut_category`
--
ALTER TABLE `prodcut_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_category_product` (`product_id`),
  ADD KEY `product_category` (`category_id`);

--
-- A tábla indexei `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `product_brand` (`brand_id`),
  ADD KEY `product_photo` (`photo_list_id`),
  ADD KEY `cat` (`category_id`);

--
-- A tábla indexei `product_image`
--
ALTER TABLE `product_image`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`id`),
  ADD KEY `review_product` (`product_id`),
  ADD KEY `review_user` (`user_id`);

--
-- A tábla indexei `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `transport_detail`
--
ALTER TABLE `transport_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transport_detail_address_type` (`address_type_id`);

--
-- A tábla indexei `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `password` (`password`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `r` (`role_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `address_type`
--
ALTER TABLE `address_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `billing_detail`
--
ALTER TABLE `billing_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `brand`
--
ALTER TABLE `brand`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT a táblához `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `cart_product`
--
ALTER TABLE `cart_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT a táblához `order_history`
--
ALTER TABLE `order_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `order_product`
--
ALTER TABLE `order_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `payment_method`
--
ALTER TABLE `payment_method`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `prodcut_category`
--
ALTER TABLE `prodcut_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT a táblához `product_image`
--
ALTER TABLE `product_image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT a táblához `review`
--
ALTER TABLE `review`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `status`
--
ALTER TABLE `status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `transport_detail`
--
ALTER TABLE `transport_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `billing_detail`
--
ALTER TABLE `billing_detail`
  ADD CONSTRAINT `billing_address_type` FOREIGN KEY (`address_type_id`) REFERENCES `address_type` (`id`);

--
-- Megkötések a táblához `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `basket_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Megkötések a táblához `cart_product`
--
ALTER TABLE `cart_product`
  ADD CONSTRAINT `basket_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `basket_product_basket` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`);

--
-- Megkötések a táblához `order_history`
--
ALTER TABLE `order_history`
  ADD CONSTRAINT `order_history_billing_id` FOREIGN KEY (`billing_detail_id`) REFERENCES `billing_detail` (`id`),
  ADD CONSTRAINT `order_history_canceler_user_id` FOREIGN KEY (`canceler_user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `order_history_payment_method` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`),
  ADD CONSTRAINT `order_history_transport_id` FOREIGN KEY (`transport_detail_id`) REFERENCES `transport_detail` (`id`),
  ADD CONSTRAINT `order_history_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `order_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`);

--
-- Megkötések a táblához `order_product`
--
ALTER TABLE `order_product`
  ADD CONSTRAINT `order_history` FOREIGN KEY (`order_id`) REFERENCES `order_history` (`id`),
  ADD CONSTRAINT `order_history_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Megkötések a táblához `prodcut_category`
--
ALTER TABLE `prodcut_category`
  ADD CONSTRAINT `product_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `product_category_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Megkötések a táblához `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `cat` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `product_brand` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`),
  ADD CONSTRAINT `product_photo` FOREIGN KEY (`photo_list_id`) REFERENCES `product_image` (`id`);

--
-- Megkötések a táblához `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `review_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Megkötések a táblához `transport_detail`
--
ALTER TABLE `transport_detail`
  ADD CONSTRAINT `transport_detail_address_type` FOREIGN KEY (`address_type_id`) REFERENCES `address_type` (`id`);

--
-- Megkötések a táblához `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `r` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

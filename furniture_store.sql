-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Gép: localhost:3306
-- Létrehozás ideje: 2026. Ápr 22. 07:24
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `clearCart` (IN `idIN` INT)   BEGIN 
	DELETE FROM `cart_product` WHERE cart_product.cart_id = idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteUserById` (IN `idIN` INT)   BEGIN
	UPDATE `user` 
    SET 
    `is_deleted`=1,
    `deleted_at`=CURRENT_TIMESTAMP 
    WHERE 
    user.id = idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllProduct` ()   BEGIN
	SELECT * FROM product
    WHERE 
    product.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCartByUserId` (IN `idIN` INT)   BEGIN 
	SELECT * FROM cart
    WHERE 
    cart.user_id = idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getFirstThreeProduct` ()   BEGIN
	SELECT * FROM product WHERE 
    product.is_deleted = 0 
    LIMIT 3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getParentCategories` ()   BEGIN
	SELECT * FROM category WHERE 
    category.parent_category_id IS NULL
    AND 
    category.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getProductById` (IN `idIN` INT)   BEGIN 
	SELECT * FROM product 
    WHERE 
    product.id = idIN
    AND 
    product.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getSubCategoriesOfParentCategory` (IN `idIN` INT)   BEGIN
	SELECT * FROM category
    WHERE 
    category.parent_category_id = idIN
    AND 
    category.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserByEmail` (IN `emailIN` VARCHAR(100))   BEGIN
	SELECT * FROM user WHERE user.email = emailIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserById` (IN `idIN` INT)   BEGIN
	SELECT * FROM user
    WHERE
    user.id = idIN
    AND 
    user.is_deleted = 0;
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
(1, 'a'),
(2, 'akna'),
(3, 'alja'),
(4, 'almáskert'),
(5, 'alsó'),
(6, 'alsósor'),
(7, 'aluljáró'),
(8, 'autópálya'),
(9, 'autóversenypálya'),
(10, 'állomás'),
(11, 'árok'),
(12, 'átjáró'),
(13, 'barakképület'),
(14, 'bánya'),
(15, 'bányatelep'),
(16, 'bekötőút'),
(17, 'benzinkút'),
(18, 'bérc'),
(19, 'bisztró'),
(20, 'bokor'),
(21, 'burgundia'),
(22, 'büfé'),
(23, 'camping'),
(24, 'campingsor'),
(25, 'centrum'),
(26, 'célgazdaság'),
(27, 'csapás'),
(28, 'csarnok'),
(29, 'csárda'),
(30, 'cser'),
(31, 'domb'),
(32, 'dunapart'),
(33, 'dunasor'),
(34, 'dűlő'),
(35, 'dűlője'),
(36, 'dűlők'),
(37, 'dűlőút'),
(38, 'egyesület'),
(39, 'egyéb'),
(40, 'elágazás'),
(41, 'erdészház'),
(42, 'erdészlak'),
(43, 'erdő'),
(44, 'erdősarok'),
(45, 'erdősor'),
(46, 'épület'),
(47, 'épületek'),
(48, 'észak'),
(49, 'étterem'),
(50, 'falu'),
(51, 'farm'),
(52, 'fasor'),
(53, 'fasora'),
(54, 'feketeerdő'),
(55, 'feketeföldek'),
(56, 'felső'),
(57, 'felsősor'),
(58, 'fennsík'),
(59, 'fogadó'),
(60, 'fok'),
(61, 'forduló'),
(62, 'forrás'),
(63, 'föld'),
(64, 'földek'),
(65, 'földje'),
(66, 'főtér'),
(67, 'főút'),
(68, 'fürdő'),
(69, 'fürdőhely'),
(70, 'fürésztelepe'),
(71, 'gazdaság'),
(72, 'gát'),
(73, 'gátőrház'),
(74, 'gátsor'),
(75, 'gimnázium'),
(76, 'gödör'),
(77, 'gulyakút'),
(78, 'gyár'),
(79, 'gyártelep'),
(80, 'halom'),
(81, 'határ'),
(82, 'határátkelőhely'),
(83, 'határrész'),
(84, 'határsor'),
(85, 'határút'),
(86, 'hatházak'),
(87, 'hát'),
(88, 'ház'),
(89, 'háza'),
(90, 'házak'),
(91, 'hegy'),
(92, 'hegyhát'),
(93, 'hegyhát dűlő'),
(94, 'hely'),
(95, 'hivatal'),
(96, 'híd'),
(97, 'hídfő'),
(98, 'horgásztanya'),
(99, 'hotel'),
(100, 'I'),
(101, 'I.'),
(102, 'II.'),
(103, 'III'),
(104, 'III.'),
(105, 'intézet'),
(106, 'ipari park'),
(107, 'ipartelep'),
(108, 'iparterület'),
(109, 'irodaház'),
(110, 'iskola'),
(111, 'IV'),
(112, 'IV.'),
(113, 'IX'),
(114, 'jánoshegy'),
(115, 'járás'),
(116, 'juhászház'),
(117, 'kapcsolóház'),
(118, 'kapu'),
(119, 'kastély'),
(120, 'kálvária'),
(121, 'kemping'),
(122, 'kert'),
(123, 'kertek'),
(124, 'kertek-köze'),
(125, 'kertsor'),
(126, 'kertváros'),
(127, 'kerület'),
(128, 'kikötő'),
(129, 'kilátó'),
(130, 'kishajtás'),
(131, 'kitérő'),
(132, 'kocsiszín'),
(133, 'kolónia'),
(134, 'korzó'),
(135, 'kórház'),
(136, 'körönd'),
(137, 'körtér'),
(138, 'körút'),
(139, 'körútja'),
(140, 'körvasútsor'),
(141, 'körzet'),
(142, 'köz'),
(143, 'köze'),
(144, 'középsor'),
(145, 'központ'),
(146, 'kút'),
(147, 'kútház'),
(148, 'Külkerület'),
(149, 'kültelek'),
(150, 'külterület'),
(151, 'külterülete'),
(152, 'lakás'),
(153, 'lakások'),
(154, 'lakóház'),
(155, 'lakókert'),
(156, 'lakónegyed'),
(157, 'lakópark'),
(158, 'lakótelep'),
(159, 'laktanya'),
(160, 'legelő'),
(161, 'lejáró'),
(162, 'lejtő'),
(163, 'lépcső'),
(164, 'liget'),
(165, 'lovasiskola'),
(166, 'magánút'),
(167, 'major'),
(168, 'malom'),
(169, 'malomsor'),
(170, 'megálló'),
(171, 'mellékköz'),
(172, 'mező'),
(173, 'mélyút'),
(174, 'munkásszálló'),
(175, 'műút'),
(176, 'nagymajor'),
(177, 'nagyút'),
(178, 'nádgazdaság'),
(179, 'negyed'),
(180, 'nyaraló'),
(181, 'oldal'),
(182, 'országút'),
(183, 'otthon'),
(184, 'otthona'),
(185, 'öböl'),
(186, 'öregszőlők'),
(187, 'ösvény'),
(188, 'ötház'),
(189, 'övezet'),
(190, 'őrház'),
(191, 'őrházak'),
(192, 'pagony'),
(193, 'pallag'),
(194, 'palota'),
(195, 'park'),
(196, 'parkfalu'),
(197, 'parkja'),
(198, 'parkoló'),
(199, 'part'),
(200, 'pavilonsor'),
(201, 'pálya'),
(202, 'pályafenntartás'),
(203, 'pályaudvar'),
(204, 'piac'),
(205, 'pihenő'),
(206, 'pihenőhely'),
(207, 'pihenőpark'),
(208, 'pince'),
(209, 'pinceköz'),
(210, 'pincesor'),
(211, 'présházak'),
(212, 'puszta'),
(213, 'rakodó'),
(214, 'rakpart'),
(215, 'repülőtér'),
(216, 'rész'),
(217, 'rét'),
(218, 'rétek'),
(219, 'rév'),
(220, 'ring'),
(221, 'sarok'),
(222, 'sertéstelep'),
(223, 'sétatér'),
(224, 'sétány'),
(225, 'sikátor'),
(226, 'sor'),
(227, 'sora'),
(228, 'sportpálya'),
(229, 'sporttelep'),
(230, 'stadion'),
(231, 'strand'),
(232, 'strandfürdő'),
(233, 'sugárút'),
(234, 'szakiskola'),
(235, 'szállás'),
(236, 'szálló'),
(237, 'szárító'),
(238, 'szárnyasliget'),
(239, 'szektor'),
(240, 'szer'),
(241, 'szél'),
(242, 'széle'),
(243, 'sziget'),
(244, 'szigete'),
(245, 'szivattyútelep'),
(246, 'szög'),
(247, 'szőlő'),
(248, 'szőlőhegy'),
(249, 'szőlők'),
(250, 'szőlőkert'),
(251, 'szőlős'),
(252, 'szőlősor'),
(253, 'tag'),
(254, 'tanya'),
(255, 'tanyaközpont'),
(256, 'tanyák'),
(257, 'tavak'),
(258, 'tábor'),
(259, 'tároló'),
(260, 'társasház'),
(261, 'teherpályaudvar'),
(262, 'telek'),
(263, 'telep'),
(264, 'telepek'),
(265, 'település'),
(266, 'temető'),
(267, 'tere'),
(268, 'terményraktár'),
(269, 'terület'),
(270, 'teteje'),
(271, 'tető'),
(272, 'téglagyár'),
(273, 'tér'),
(274, 'tormás'),
(275, 'torony'),
(276, 'tó'),
(277, 'tópart'),
(278, 'tömb'),
(279, 'TSZ'),
(280, 'turistaház'),
(281, 'udvar'),
(282, 'udvara'),
(283, 'utca'),
(284, 'utcája'),
(285, 'újfalu'),
(286, 'újsor'),
(287, 'újtelep'),
(288, 'út'),
(289, 'útfél'),
(290, 'útgyűrű'),
(291, 'útja'),
(292, 'üdülő'),
(293, 'üdülő központ'),
(294, 'üdülő park'),
(295, 'üdülők'),
(296, 'üdülőközpont'),
(297, 'üdülőpart'),
(298, 'üdülő-part'),
(299, 'üdülősor'),
(300, 'üdülő-sor'),
(301, 'üdülőtelep'),
(302, 'üdülő-telep'),
(303, 'üdülőterület'),
(304, 'üzem'),
(305, 'üzletház'),
(306, 'üzletsor'),
(307, 'V'),
(308, 'V.'),
(309, 'vadászház'),
(310, 'varroda'),
(311, 'vasútállomás'),
(312, 'vasúti megálló'),
(313, 'vasúti őrház'),
(314, 'vasútsor'),
(315, 'vám'),
(316, 'vár'),
(317, 'város'),
(318, 'vásártér'),
(319, 'vendéglő'),
(320, 'vég'),
(321, 'VI'),
(322, 'VI.'),
(323, 'VII'),
(324, 'VII.'),
(325, 'VIII'),
(326, 'VIII.'),
(327, 'villa'),
(328, 'villasor'),
(329, 'vízmű'),
(330, 'vízmű telep'),
(331, 'víztároló'),
(332, 'völgy'),
(333, 'X'),
(334, 'X.'),
(335, 'zsilip'),
(336, 'zug');

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
(1, 1, 'a', 'a', 1, 1, NULL, NULL, NULL),
(4, 7200, 'asfsfa', 'asfasf', 1, 23, NULL, NULL, NULL),
(6, 7200, 'asd', 'asdsad', 2, 32, NULL, NULL, NULL);

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
  `last_modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `cart`
--

INSERT INTO `cart` (`id`, `user_id`, `last_modified`) VALUES
(1, 1, '2025-12-02 08:13:33'),
(2, 2, '2025-12-02 08:13:33'),
(3, 8, NULL),
(4, 7, NULL),
(5, 9, NULL);

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
(1, 3, 1, 1000, '2025-12-02 09:32:55', NULL),
(2, 1, 3, 2, '2026-03-01 18:58:17', NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `parent_category_id` int(11) DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `category`
--

INSERT INTO `category` (`id`, `name`, `parent_category_id`, `is_deleted`, `deleted_at`) VALUES
(1, 'szék', NULL, 1, NULL),
(2, 'Ülőbútorok', 17, 0, NULL),
(3, 'Asztalok', 17, 0, NULL),
(4, 'Tárplóbútorok', 16, 0, NULL),
(5, 'Szekrények', 16, 0, NULL),
(6, 'Ágyak', 22, 0, NULL),
(7, 'Matracok', 22, 0, NULL),
(8, 'Kanapék', 23, 0, NULL),
(9, 'Fotelek', 23, 0, NULL),
(10, 'Székek', 20, 0, NULL),
(11, 'Íróasztalok', 20, 0, NULL),
(12, 'Komódok', 16, 0, NULL),
(13, 'Polcok és könyvespolcok', 23, 0, NULL),
(14, 'Gardróbszekrények', 16, 0, NULL),
(15, 'TV-állványok', 15, 0, NULL),
(16, 'Előszobabútorok', NULL, 0, NULL),
(17, 'Konyhabútorok', NULL, 0, NULL),
(18, 'Fürdőszobabútorok', NULL, 0, NULL),
(19, 'Gyerekbútorok', NULL, 0, NULL),
(20, 'Irodabútorok', NULL, 0, NULL),
(21, 'Kerti bútorok', NULL, 0, NULL),
(22, 'Hálószoba', NULL, 0, NULL),
(23, 'Nappali', NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `order_history`
--

CREATE TABLE `order_history` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `phone` varchar(13) NOT NULL,
  `email` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL,
  `billing_detail_id` int(11) NOT NULL,
  `transport_detail_id` int(11) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `ordered_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `canceled_at` datetime DEFAULT NULL,
  `is_canceled` tinyint(1) NOT NULL DEFAULT '0',
  `canceler_user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `order_history`
--

INSERT INTO `order_history` (`id`, `first_name`, `last_name`, `phone`, `email`, `user_id`, `billing_detail_id`, `transport_detail_id`, `payment_method_id`, `status_id`, `ordered_at`, `canceled_at`, `is_canceled`, `canceler_user_id`) VALUES
(1, 'test1', 'test1', '0670100000', 'test1@gmail.com', 9, 1, 1, 1, 1, '2026-04-15 18:38:10', NULL, 0, NULL),
(2, 'asf', 'fasfa', '06706285232', 'asd@gmail.com', 9, 4, 4, 2, 1, '2026-04-15 18:38:07', NULL, 0, NULL),
(4, 'asd', 'asd', '06706285232', 'dasd@gmail.com', 9, 6, 6, 1, 1, '2026-04-15 08:46:04', NULL, 0, NULL);

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
(1, 'Kártya'),
(2, 'Készpénz');

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
  `amount` int(11) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `price` int(6) NOT NULL,
  `category_id` int(11) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `img_path` varchar(2000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `product`
--

INSERT INTO `product` (`id`, `name`, `description`, `height_in_cm`, `width_in_cm`, `depth_in_cm`, `weight_in_kg`, `amount`, `brand_id`, `price`, `category_id`, `is_deleted`, `deleted_at`, `img_path`) VALUES
(1, 'Sarokkanapé', 'L-alakú ülőbútor, több személy számára, gyakran ágyneműtartóval.\n', 85, 260, 200, 120, 10, 1, 10, 2, 0, NULL, 'http://localhost:8080/productImg/kanape1.avif'),
(2, 'Kerti asztal\r\n', 'Kültéri használatra tervezett asztal.\r\n', 1, 1, 1, 1, 15, 1, 1, 2, 0, NULL, 'http://localhost:8080/productImg/KERTIASZTAL1.avif'),
(3, 'Háromszemélyes kanapé\r\n', 'Kényelmes ülőbútor nappaliba, klasszikus elrendezéshez.\r\n', 10, 10, 10, 10, 15, 1, 100, 2, 0, NULL, 'http://localhost:8080/productImg/kanape2.avif'),
(4, 'Fotelszék', 'Egy személy számára kialakított, kényelmes ülőalkalmatosság.\r\n', 1, 1, 1, 1, 15, 1, 1, 2, 0, NULL, 'http://localhost:8080/productImg/karosszek1.avif'),
(5, 'Étkezőszék', 'Étkezőasztalhoz tervezett szék, háttámlával.\r\n', 1, 1, 1, 1, 15, 1, 1, 2, 0, NULL, 'http://localhost:8080/productImg/szek1.avif'),
(6, 'Étkezőasztal', 'Több személyes étkezésekhez alkalmas asztal.\r\n', 1, 1, 1, 1, 15, 1, 1, 2, 0, NULL, 'http://localhost:8080/productImg/ea6.avif'),
(7, 'Dohányzóasztal\r\n', 'Alacsony asztal nappaliba, kanapé elé.\r\n', 1, 1, 1, 1, 15, 1, 1, 2, 0, NULL, 'http://localhost:8080/productImg/dohanyzo1.avif'),
(8, 'TV-állvány\r\n', 'Televízió és multimédiás eszközök elhelyezésére.\r\n', 1, 1, 1, 1, 15, 1, 1, 2, 0, NULL, 'http://localhost:8080/productImg/TV-állványok 1.1.avif'),
(9, 'Könyvespolc\r\n', 'Könyvek és dekorációk tárolására szolgáló polcrendszer.\r\n', 1, 1, 1, 1, 15, 1, 1, 2, 0, NULL, 'http://localhost:8080/productImg/polc5.avif'),
(10, 'Komód', 'Fiókos tárolóbútor ruhák vagy kiegészítők számára.\r\n', 1, 1, 1, 1, 15, 1, 1, 2, 0, NULL, 'http://localhost:8080/productImg/komód1.avif'),
(11, 'Ruhásszekrény', 'Ruhák tárolására alkalmas szekrény akasztóval és polcokkal.\r\n', 1, 1, 1, 1, 15, 1, 1, 2, 0, NULL, 'http://localhost:8080/productImg/szekrénysor 2.2.avif'),
(12, 'Gardróbszekrény', 'Nagy méretű ruhatároló, több rekesszel.\r\n', 1, 1, 1, 1, 15, 1, 1, 2, 0, NULL, 'http://localhost:8080/productImg/szekrénysor 1.avif'),
(13, 'Franciaágy\r\n', 'Kétszemélyes ágy, matraccal vagy matrac nélkül.\r\n', 1, 1, 1, 1, 15, 1, 1, 2, 0, NULL, 'http://localhost:8080/productImg/ágy3.avif'),
(14, 'Egyszemélyes ágy\r\n', 'Egy személy részére kialakított fekvőbútor.\r\n', 1, 1, 1, 1, 15, 1, 1, 2, 0, NULL, 'http://localhost:8080/productImg/TÁROLÓS ÁGY 1.1.avif'),
(15, 'Éjjeliszekrény\r\n', 'Ágy melletti kis tárolóbútor.\r\n', 1, 1, 1, 1, 15, 1, 1, 2, 0, NULL, 'http://localhost:8080/productImg/komód1.avif'),
(16, 'Íróasztal\r\n', 'Tanuláshoz vagy munkához használt asztal.\r\n', 1, 1, 1, 1, 15, 1, 1, 2, 0, NULL, 'http://localhost:8080/productImg/asztal6.avif'),
(17, 'Irodai forgószék\r\n', 'Állítható magasságú, kerekes munkaszék.\r\n', 1, 1, 1, 1, 15, 1, 1, 2, 0, NULL, 'http://localhost:8080/productImg/IFJÚSÁGI FORGÓSZÉK 1.1.avif'),
(18, 'Cipősszekrény\r\n', 'Cipők rendszerezett tárolására.\r\n', 1, 1, 1, 1, 15, 1, 1, 2, 0, NULL, 'http://localhost:8080/productImg/Cipősszekrény 1.avif'),
(19, 'Előszobafal\r\n', 'Akasztókkal, polcokkal és tükörrel ellátott előszobabútor.\r\n', 1, 1, 1, 1, 15, 1, 1, 2, 0, NULL, 'http://localhost:8080/productImg/eloszobafal.avif'),
(20, 'Konyhaszekrény', 'Konyhai tárolóbútor edények és élelmiszerek számára.\r\n', 1, 1, 1, 1, 15, 1, 1, 2, 0, NULL, 'http://localhost:8080/productImg/SAROK FALISZEKRÉNY 1.avif'),
(21, 'asd', 'asd', 23, 32, 32, 32, 23, 14, 321, 17, 0, NULL, 'asd'),
(22, 'fsafasfas', 'fasfasfasf', 2431, 421, 421, 421, 42, 15, 231, 18, 0, NULL, 'asd'),
(23, 'afsafsfas', 'fasfasfasf', 23, 213, 321, 42, 321, 13, 24, 18, 0, NULL, 'asd');

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
(1, 'ROLE_user'),
(2, 'ROLE_admin');

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
(1, 1, 'a', 'a', 1, 1, '1'),
(4, 7200, 'adsdas', 'asffas', 18, 23, NULL),
(6, 45, 'asd', 'asd', 15, 25, NULL);

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
(2, 'test2', 'test2@gmail.com', 'test2', '06701000000', '2025-12-02 07:11:01', '2025-12-02 07:11:01', 1, '2026-02-26 20:00:31', 'b', 1, '2025-12-02 07:20:58'),
(3, 'postTest1', 'test@gmail.com', 'test5.As', 'asd', NULL, NULL, 0, NULL, '', 1, '2025-12-02 10:26:38'),
(7, 'Tóth János', 'tothjanos3222@gmail.com', 'tothjanos33', '06302301122', NULL, NULL, 0, NULL, 'a', 1, '2026-03-03 11:51:19'),
(8, 'admin1', 'admin1@gmail.com', 'admin1', '06701111111', NULL, NULL, 0, NULL, 'b', 2, '2026-03-03 11:52:51'),
(9, 'asda', 'asd@gmail.com', '$2a$10$3Gc9g3p7Z/eEDSbC3MgTNeu9OceR.rSnQYnFraUHgwmTMGixxAAuy', '06706285232', NULL, NULL, 0, NULL, '', 2, '2026-04-14 21:40:30');

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `p_category` (`parent_category_id`);

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
  ADD KEY `cat` (`category_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=337;

--
-- AUTO_INCREMENT a táblához `billing_detail`
--
ALTER TABLE `billing_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `brand`
--
ALTER TABLE `brand`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT a táblához `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `cart_product`
--
ALTER TABLE `cart_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT a táblához `order_history`
--
ALTER TABLE `order_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `order_product`
--
ALTER TABLE `order_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `payment_method`
--
ALTER TABLE `payment_method`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `prodcut_category`
--
ALTER TABLE `prodcut_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT a táblához `review`
--
ALTER TABLE `review`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `status`
--
ALTER TABLE `status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `transport_detail`
--
ALTER TABLE `transport_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

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
-- Megkötések a táblához `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `p_category` FOREIGN KEY (`parent_category_id`) REFERENCES `category` (`id`);

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
  ADD CONSTRAINT `product_brand` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`);

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

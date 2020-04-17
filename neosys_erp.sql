-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  ven. 17 avr. 2020 à 21:30
-- Version du serveur :  10.1.35-MariaDB
-- Version de PHP :  7.2.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `neosys_erp`
--

-- --------------------------------------------------------

--
-- Structure de la table `credit_notes`
--

CREATE TABLE `credit_notes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `credit_note_number` varchar(55) NOT NULL,
  `type` int(11) NOT NULL,
  `amount` double DEFAULT NULL,
  `percent_discount` float DEFAULT NULL,
  `amount_discount` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `phonenumber` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `activity` varchar(255) NOT NULL,
  `country` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `address` text NOT NULL,
  `website` varchar(255) DEFAULT NULL,
  `bp` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `manager_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `customers`
--

INSERT INTO `customers` (`id`, `company_name`, `phonenumber`, `email`, `activity`, `country`, `city`, `address`, `website`, `bp`, `created_at`, `updated_at`, `manager_id`) VALUES
(1, 'Neosys Technologie SARL', '+24177454754', 'yvon.ndong@neosystechnologie.ga', 'Informatique / Télécoms', 'Gabon', 'Oyem', 'Ancienne SOBRAGE', NULL, '0000', '2019-12-23 23:00:00', '2020-01-14 10:41:26', 1),
(2, 'Workin Art', '066856011', 'infos@workinart.ga', 'Art & Culture', 'Gabon', 'Nkan', 'Ancienne SOBRAGA', NULL, NULL, NULL, '2020-01-14 10:43:54', NULL),
(7, 'ITech', '+241058987', 'itech-infos@gmail.com', 'Informatique / Télécoms', 'Gabon', 'Libreville', 'Montee de Louis', NULL, NULL, '2020-03-12 09:40:56', '2020-03-12 09:40:56', NULL),
(8, 'OK Service', '+24106898745', 'ok-service@yahoo.fr', 'Transports / Logistique', 'Gabon', 'Libreville', 'SODUCO', NULL, NULL, '2020-03-12 09:43:39', '2020-03-12 09:43:39', NULL),
(9, 'Agence du Developpement Agricole du Gabon', '+24111456442', 'adag.agence@gmail.com', 'Agroalimentaire', 'Gabon', 'Libreville', 'Avorbam, Route du Cap (Ancien CATH)', NULL, '551', '2020-03-30 12:45:14', '2020-03-30 12:45:14', 1),
(10, 'Institut Superieur des Sciences de la Sante (I3S)', '+24100000000', 'none@none.none', 'Education / Enseignement / Recherche', 'Gabon', 'Libreville', 'Ecole Normale', NULL, NULL, '2020-04-01 16:12:07', '2020-04-01 16:12:07', 1),
(11, 'Agence Nationale des Bourses du Gabon (ANBG)', '+24100000000', 'none1@none.none', 'État / Administration', 'Gabon', 'Libreville', 'Oloumi', NULL, NULL, '2020-04-01 16:23:36', '2020-04-01 16:23:36', 1),
(12, 'Unité de contrôle budgétaire du Ministère des Affaires Etrangères', '+24174365859', 'ysalet10@gmail.com', 'État / Administration', 'Gabon', 'Libreville', 'Batterie IV', NULL, NULL, '2020-04-01 16:35:23', '2020-04-01 16:35:23', 1),
(13, 'Autre', '+24100000000', 'other@other.other', 'Autre', 'Gabon', 'Libreville', 'Everywhere', NULL, NULL, '2020-04-02 08:44:02', '2020-04-02 08:44:02', 1),
(14, 'ok jazz', '+24145896547', 'okjazz@gmail.com', 'Art & Culture', 'Gabon', 'Libreville', 'Owendo', NULL, NULL, '2020-04-09 19:36:10', '2020-04-09 19:36:10', 1),
(15, 'customer1', '+241587896', 'customer1@test.test', 'Agroalimentaire', 'Gabon', 'Libreville', 'Customer1', NULL, NULL, '2020-04-09 19:49:43', '2020-04-09 19:49:43', 1),
(16, 'Turkish Airlines', '+24111457874', 'turkish-airlines@turkish.tu', 'Transports / Logistique', 'Gabon', 'Libreville', 'Centre Ville / Batavea', NULL, NULL, '2020-04-10 22:01:25', '2020-04-10 22:01:25', 1),
(17, 'DGCC', '+24100025898', 'dgcc@gouv.ga', 'État / Administration', 'Gabon', 'Libreville', 'Palais du bord de mer', NULL, NULL, '2020-04-11 07:35:40', '2020-04-11 07:35:40', 1),
(18, 'Infracom', '+24104787458', 'infracom@infracom.com', 'Informatique / Télécoms', 'Gabon', 'Libreville', '9 etages', NULL, NULL, '2020-04-16 13:58:05', '2020-04-16 13:58:05', 1);

-- --------------------------------------------------------

--
-- Structure de la table `delivery_orders`
--

CREATE TABLE `delivery_orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `documents`
--

CREATE TABLE `documents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `filename` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `document_payment`
--

CREATE TABLE `document_payment` (
  `payment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `document_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `information`
--

CREATE TABLE `information` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `social_reason` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `address` text,
  `phone1` varchar(255) DEFAULT NULL,
  `phone2` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `bp` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `check_payable_to` varchar(255) DEFAULT NULL,
  `transfer_to_account` varchar(255) DEFAULT NULL,
  `code_bank` varchar(50) DEFAULT NULL,
  `counter_code` varchar(50) DEFAULT NULL,
  `account_number` varchar(50) DEFAULT NULL,
  `rib_key` varchar(50) DEFAULT NULL,
  `footer` text,
  `header` text,
  `quote_delay` int(11) DEFAULT NULL,
  `invoice_delay` int(11) DEFAULT NULL,
  `purchase_order_delay` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `information`
--

INSERT INTO `information` (`id`, `social_reason`, `logo`, `address`, `phone1`, `phone2`, `email`, `country`, `city`, `bp`, `website`, `check_payable_to`, `transfer_to_account`, `code_bank`, `counter_code`, `account_number`, `rib_key`, `footer`, `header`, `quote_delay`, `invoice_delay`, `purchase_order_delay`, `created_at`, `updated_at`) VALUES
(1, 'Neosys Technologie S.A.R.L', 'logo.png', 'Ancienne SOBRAGA, en face de Multipresse/L\'UNION', '+241077454754', '+24166215333', 'infos@neosystechnologie.ga', 'Gabon', 'Libreville', NULL, 'https://neosystechnologie.ga', 'NEOSYS TECHNOLOGIE', 'BGFI  LOXIA N° 00165258211', '4003', '04100', '71008865012', '88', '<p><strong>NeoSys Technologies SARL</strong></p><p>Intégrateur des solutions informatiques</p><p>Audits - Conseils -Formations - Infogérance - Sécurité - Système et Réseaux</p><p>RCCM : 2014B18489 - NIF : 037719G – STAT. : 086847A</p><p>Tel : (+241) 07454754 - Email : infos@neosystechologie.ga</p>', NULL, 10, 30, 30, '2020-03-16 08:45:00', '2020-04-15 00:24:40');

-- --------------------------------------------------------

--
-- Structure de la table `invoices`
--

CREATE TABLE `invoices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `invoice_number` varchar(50) DEFAULT NULL,
  `title` text,
  `amount_et` double DEFAULT NULL,
  `discount` float NOT NULL,
  `amount_discount` double NOT NULL,
  `amount_taxes` double DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expire_at` date DEFAULT NULL,
  `status` varchar(255) DEFAULT 'draft',
  `type` varchar(255) DEFAULT 'standard' COMMENT 'standard, account, credit_note',
  `payment_method_id` bigint(20) UNSIGNED DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `invoices`
--

INSERT INTO `invoices` (`id`, `customer_id`, `user_id`, `invoice_number`, `title`, `amount_et`, `discount`, `amount_discount`, `amount_taxes`, `amount`, `created_at`, `updated_at`, `expire_at`, `status`, `type`, `payment_method_id`, `parent_id`) VALUES
(44, 11, 1, 'F2020040001', 'Projet1', 45000, 0, 45000, 4725, 49725, '2020-01-01 00:29:25', '2020-01-01 15:43:47', '2020-02-01', 'validated', 'standard', 1, NULL),
(45, 9, 1, 'F2020040002', 'Projet 1', 125000, 0, 125000, 13125, 138125, '2020-04-15 08:18:14', '2020-04-15 14:27:36', '2020-05-15', 'validated', 'standard', 1, NULL),
(46, 1, 1, 'F2020040003', 'Projet 2', 201600, 0, 201600, 21168, 222768, '2020-04-15 08:19:07', '2020-04-15 12:43:09', '2020-05-15', 'validated', 'standard', 2, NULL),
(48, 9, 1, 'F2020040005', 'Projet', 28000, 0, 28000, 2940, 30940, '2020-04-15 15:34:08', '2020-04-15 15:34:08', '2020-05-15', 'draft', 'standard', 1, NULL),
(49, 15, 1, 'F2020040006', 'decima', 396000, 10, 356400, 37422, 393822, '2020-04-15 15:35:10', '2020-04-15 15:35:10', '2020-05-15', 'draft', 'standard', 4, NULL),
(50, 8, 1, 'F2020040007', 'Projet', 46000, 0, 46000, 13110, 59110, '2020-04-15 15:36:01', '2020-04-15 15:36:01', '2020-05-15', 'draft', 'standard', 5, NULL),
(51, 17, 1, 'F2020040008', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-15 15:38:17', '2020-04-15 19:39:09', '2020-05-15', 'validated', 'standard', 3, NULL),
(54, 17, 1, 'F2020040011', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-15 21:08:03', '2020-04-15 21:08:03', '2020-05-15', 'draft', 'credit_note', 4, NULL),
(55, 17, 1, 'F2020040012', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-15 21:08:33', '2020-04-15 21:08:33', '2020-05-15', 'draft', 'credit_note', 2, NULL),
(56, 17, 1, 'F2020040013', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-15 21:09:29', '2020-04-15 21:09:29', '2020-05-15', 'draft', 'credit_note', 1, NULL),
(57, 17, 1, 'F2020040014', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-15 21:10:59', '2020-04-16 07:57:07', '2020-05-16', 'validated', 'credit_note', 1, NULL),
(58, 17, 1, 'F2020040015', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-15 21:17:01', '2020-04-15 21:17:01', '2020-05-15', 'draft', 'credit_note', 1, NULL),
(59, 17, 1, 'F2020040016', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-15 21:19:30', '2020-04-16 07:35:26', '2020-05-16', 'validated', 'credit_note', 3, NULL),
(60, 1, 1, 'F2020040017', 'Projet 1', 245000, 0, 245000, 25725, 270725, '2020-04-16 13:49:54', '2020-04-16 13:49:54', '2020-05-16', 'draft', 'credit_note', 1, NULL),
(61, 18, 1, 'F2020040018', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-16 13:58:51', '2020-04-16 15:08:18', '2020-05-16', 'validated', 'standard', 2, NULL),
(62, 17, 1, 'F2020040019', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-16 14:52:07', '2020-04-16 15:07:47', '2020-05-16', 'validated', 'credit_note', 3, 59),
(64, 18, 1, 'F2020040020', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-01-31 23:00:00', '2020-04-16 18:21:13', '2020-05-16', '1', 'standard', 2, NULL),
(65, 18, 1, 'F2020040021', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:50:30', '2020-04-17 09:50:30', '2020-05-17', 'draft', 'standard', NULL, NULL),
(66, 18, 1, 'F2020040022', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:50:40', '2020-04-17 09:50:40', '2020-05-17', 'draft', 'standard', NULL, NULL),
(67, 18, 1, 'F2020040023', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:50:49', '2020-04-17 09:50:49', '2020-05-17', 'draft', 'standard', NULL, NULL),
(68, 18, 1, 'F2020040024', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:50:59', '2020-04-17 09:50:59', '2020-05-17', 'draft', 'standard', NULL, NULL),
(69, 18, 1, 'F2020040025', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:51:08', '2020-04-17 09:51:08', '2020-05-17', 'draft', 'standard', NULL, NULL),
(70, 18, 1, 'F2020040026', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:51:17', '2020-04-17 09:51:17', '2020-05-17', 'draft', 'standard', NULL, NULL),
(71, 18, 1, 'F2020040027', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:51:25', '2020-04-17 09:51:25', '2020-05-17', 'draft', 'standard', NULL, NULL),
(72, 18, 1, 'F2020040028', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:51:33', '2020-04-17 09:51:33', '2020-05-17', 'draft', 'standard', NULL, NULL),
(73, 18, 1, 'F2020040029', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:51:42', '2020-04-17 09:51:42', '2020-05-17', 'draft', 'standard', NULL, NULL),
(74, 18, 1, 'F2020040030', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:51:52', '2020-04-17 09:51:52', '2020-05-17', 'draft', 'standard', NULL, NULL),
(75, 18, 1, 'F2020040031', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:52:01', '2020-04-17 09:52:01', '2020-05-17', 'draft', 'standard', NULL, NULL),
(76, 18, 1, 'F2020040032', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:52:09', '2020-04-17 09:52:09', '2020-05-17', 'draft', 'standard', NULL, NULL),
(77, 18, 1, 'F2020040033', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:52:17', '2020-04-17 09:52:17', '2020-05-17', 'draft', 'standard', NULL, NULL),
(78, 18, 1, 'F2020040034', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:52:27', '2020-04-17 09:52:27', '2020-05-17', 'draft', 'standard', NULL, NULL),
(79, 18, 1, 'F2020040035', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:52:41', '2020-04-17 09:52:41', '2020-05-17', 'draft', 'standard', NULL, NULL),
(80, 18, 1, 'F2020040036', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:52:49', '2020-04-17 09:52:49', '2020-05-17', 'draft', 'standard', NULL, NULL),
(81, 18, 1, 'F2020040037', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:52:58', '2020-04-17 09:52:58', '2020-05-17', 'draft', 'standard', NULL, NULL),
(82, 18, 1, 'F2020040038', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:53:10', '2020-04-17 09:53:10', '2020-05-17', 'draft', 'standard', NULL, NULL),
(83, 18, 1, 'F2020040039', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:53:41', '2020-04-17 09:53:41', '2020-05-17', 'draft', 'standard', NULL, NULL),
(84, 18, 1, 'F2020040040', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:54:07', '2020-04-17 09:54:07', '2020-05-17', 'draft', 'standard', NULL, NULL),
(85, 18, 1, 'F2020040041', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:54:15', '2020-04-17 09:54:15', '2020-05-17', 'draft', 'standard', NULL, NULL),
(86, 18, 1, 'F2020040042', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:54:24', '2020-04-17 09:54:24', '2020-05-17', 'draft', 'standard', NULL, NULL),
(87, 18, 1, 'F2020040043', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:54:32', '2020-04-17 09:54:32', '2020-05-17', 'draft', 'standard', NULL, NULL),
(88, 18, 1, 'F2020040044', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:54:40', '2020-04-17 09:54:40', '2020-05-17', 'draft', 'standard', NULL, NULL),
(89, 18, 1, 'F2020040045', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:54:49', '2020-04-17 09:54:49', '2020-05-17', 'draft', 'standard', NULL, NULL),
(90, 18, 1, 'F2020040046', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:55:01', '2020-04-17 09:55:01', '2020-05-17', 'draft', 'standard', NULL, NULL),
(91, 18, 1, 'F2020040047', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:55:11', '2020-04-17 09:55:46', '2020-05-17', 'validated', 'standard', NULL, NULL),
(92, 18, 1, 'F2020040048', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:55:56', '2020-04-17 09:55:56', '2020-05-17', 'draft', 'standard', NULL, NULL),
(93, 18, 1, 'F2020040049', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:56:06', '2020-04-17 09:56:06', '2020-05-17', 'draft', 'standard', NULL, NULL),
(94, 18, 1, 'F2020040050', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:56:14', '2020-04-17 09:56:14', '2020-05-17', 'draft', 'standard', NULL, NULL),
(95, 18, 1, 'F2020040051', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:56:22', '2020-04-17 09:56:22', '2020-05-17', 'draft', 'standard', NULL, NULL),
(96, 18, 1, 'F2020040052', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:56:30', '2020-04-17 09:56:30', '2020-05-17', 'draft', 'standard', NULL, NULL),
(97, 18, 1, 'F2020040053', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:56:39', '2020-04-17 09:56:39', '2020-05-17', 'draft', 'standard', NULL, NULL),
(98, 18, 1, 'F2020040054', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:57:18', '2020-04-17 09:57:18', '2020-05-17', 'draft', 'standard', NULL, NULL),
(99, 18, 1, 'F2020040055', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:58:09', '2020-04-17 09:58:09', '2020-05-17', 'draft', 'standard', NULL, NULL),
(100, 18, 1, 'F2020040056', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 09:59:51', '2020-04-17 09:59:51', '2020-05-17', 'draft', 'standard', NULL, NULL),
(101, 18, 1, 'F2020040057', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:00:02', '2020-04-17 10:00:02', '2020-05-17', 'draft', 'standard', NULL, NULL),
(102, 18, 1, 'F2020040058', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:00:11', '2020-04-17 10:00:11', '2020-05-17', 'draft', 'standard', NULL, NULL),
(103, 18, 1, 'F2020040059', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:00:20', '2020-04-17 10:00:20', '2020-05-17', 'draft', 'standard', NULL, NULL),
(104, 18, 1, 'F2020040060', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:00:38', '2020-04-17 10:00:38', '2020-05-17', 'draft', 'standard', NULL, NULL),
(105, 18, 1, 'F2020040061', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:00:47', '2020-04-17 10:00:47', '2020-05-17', 'draft', 'standard', NULL, NULL),
(106, 18, 1, 'F2020040062', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:00:56', '2020-04-17 10:00:56', '2020-05-17', 'draft', 'standard', NULL, NULL),
(107, 18, 1, 'F2020040063', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:01:05', '2020-04-17 10:01:05', '2020-05-17', 'draft', 'standard', NULL, NULL),
(108, 18, 1, 'F2020040064', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:01:12', '2020-04-17 10:01:12', '2020-05-17', 'draft', 'standard', NULL, NULL),
(109, 18, 1, 'F2020040065', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:01:20', '2020-04-17 10:01:20', '2020-05-17', 'draft', 'standard', NULL, NULL),
(110, 18, 1, 'F2020040066', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:01:30', '2020-04-17 10:01:30', '2020-05-17', 'draft', 'standard', NULL, NULL),
(111, 18, 1, 'F2020040067', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:01:38', '2020-04-17 10:01:38', '2020-05-17', 'draft', 'standard', NULL, NULL),
(112, 18, 1, 'F2020040068', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:02:16', '2020-04-17 10:02:16', '2020-05-17', 'draft', 'standard', NULL, NULL),
(113, 18, 1, 'F2020040069', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:02:51', '2020-04-17 10:02:51', '2020-05-17', 'draft', 'standard', NULL, NULL),
(114, 18, 1, 'F2020040070', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:03:00', '2020-04-17 10:03:00', '2020-05-17', 'draft', 'standard', NULL, NULL),
(115, 18, 1, 'F2020040071', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:13:12', '2020-04-17 10:13:12', '2020-05-17', 'draft', 'standard', NULL, NULL),
(116, 18, 1, 'F2020040072', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:13:23', '2020-04-17 10:13:23', '2020-05-17', 'draft', 'standard', NULL, NULL),
(117, 18, 1, 'F2020040073', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:13:36', '2020-04-17 10:13:36', '2020-05-17', 'draft', 'standard', NULL, NULL),
(118, 18, 1, 'F2020040074', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:13:47', '2020-04-17 10:13:47', '2020-05-17', 'draft', 'standard', NULL, NULL),
(119, 18, 1, 'F2020040075', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:14:06', '2020-04-17 10:14:06', '2020-05-17', 'draft', 'standard', NULL, NULL),
(120, 18, 1, 'F2020040076', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:14:15', '2020-04-17 10:14:15', '2020-05-17', 'draft', 'standard', NULL, NULL),
(121, 18, 1, 'F2020040077', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:14:25', '2020-04-17 10:14:25', '2020-05-17', 'draft', 'standard', NULL, NULL),
(122, 18, 1, 'F2020040078', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:15:00', '2020-04-17 10:15:00', '2020-05-17', 'draft', 'standard', NULL, NULL),
(123, 18, 1, 'F2020040079', 'Projet Telecom', 46000, 0, 46000, 4830, 50830, '2020-04-17 10:15:08', '2020-04-17 10:15:08', '2020-05-17', 'draft', 'standard', NULL, NULL),
(124, 17, 1, 'F2020040080', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:17:35', '2020-04-17 10:17:35', '2020-05-17', 'draft', 'standard', NULL, NULL),
(125, 17, 1, 'F2020040081', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:17:55', '2020-04-17 10:17:55', '2020-05-17', 'draft', 'standard', NULL, NULL),
(126, 17, 1, 'F2020040082', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:18:03', '2020-04-17 10:18:03', '2020-05-17', 'draft', 'standard', NULL, NULL),
(127, 17, 1, 'F2020040083', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:18:13', '2020-04-17 10:18:13', '2020-05-17', 'draft', 'standard', NULL, NULL),
(128, 17, 1, 'F2020040084', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:18:22', '2020-04-17 10:18:22', '2020-05-17', 'draft', 'standard', NULL, NULL),
(129, 17, 1, 'F2020040085', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:18:32', '2020-04-17 10:18:32', '2020-05-17', 'draft', 'standard', NULL, NULL),
(130, 17, 1, 'F2020040086', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:18:40', '2020-04-17 10:18:40', '2020-05-17', 'draft', 'standard', NULL, NULL),
(131, 17, 1, 'F2020040087', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:18:48', '2020-04-17 10:18:48', '2020-05-17', 'draft', 'standard', NULL, NULL),
(132, 17, 1, 'F2020040088', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:18:59', '2020-04-17 10:18:59', '2020-05-17', 'draft', 'standard', NULL, NULL),
(133, 17, 1, 'F2020040089', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:19:26', '2020-04-17 10:19:26', '2020-05-17', 'draft', 'standard', NULL, NULL),
(134, 17, 1, 'F2020040090', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:19:38', '2020-04-17 10:19:38', '2020-05-17', 'draft', 'standard', NULL, NULL),
(135, 17, 1, 'F2020040091', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:19:48', '2020-04-17 10:19:48', '2020-05-17', 'draft', 'standard', NULL, NULL),
(136, 17, 1, 'F2020040092', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:19:59', '2020-04-17 10:19:59', '2020-05-17', 'draft', 'standard', NULL, NULL),
(137, 17, 1, 'F2020040093', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:20:10', '2020-04-17 10:20:10', '2020-05-17', 'draft', 'standard', NULL, NULL),
(138, 17, 1, 'F2020040094', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:20:42', '2020-04-17 10:20:42', '2020-05-17', 'draft', 'standard', NULL, NULL),
(139, 17, 1, 'F2020040095', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:20:51', '2020-04-17 10:20:51', '2020-05-17', 'draft', 'standard', NULL, NULL),
(140, 17, 1, 'F2020040096', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:21:00', '2020-04-17 10:21:00', '2020-05-17', 'draft', 'standard', NULL, NULL),
(141, 17, 1, 'F2020040097', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:21:06', '2020-04-17 10:21:06', '2020-05-17', 'draft', 'standard', NULL, NULL),
(142, 17, 1, 'F2020040098', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:21:20', '2020-04-17 10:21:20', '2020-05-17', 'draft', 'standard', NULL, NULL),
(143, 17, 1, 'F2020040099', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:21:29', '2020-04-17 10:21:29', '2020-05-17', 'draft', 'standard', NULL, NULL),
(144, 17, 1, 'F2020040100', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:21:36', '2020-04-17 10:21:36', '2020-05-17', 'draft', 'standard', NULL, NULL),
(145, 17, 1, 'F2020040101', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:21:46', '2020-04-17 10:21:46', '2020-05-17', 'draft', 'standard', NULL, NULL),
(146, 17, 1, 'F2020040102', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:21:53', '2020-04-17 10:21:53', '2020-05-17', 'draft', 'standard', NULL, NULL),
(147, 17, 1, 'F2020040103', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:22:08', '2020-04-17 10:22:08', '2020-05-17', 'draft', 'standard', NULL, NULL),
(148, 17, 1, 'F2020040104', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:22:16', '2020-04-17 10:22:16', '2020-05-17', 'draft', 'standard', NULL, NULL),
(149, 17, 1, 'F2020040105', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:22:25', '2020-04-17 10:22:25', '2020-05-17', 'draft', 'standard', NULL, NULL),
(150, 17, 1, 'F2020040106', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:22:33', '2020-04-17 10:22:33', '2020-05-17', 'draft', 'standard', NULL, NULL),
(151, 17, 1, 'F2020040107', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:22:41', '2020-04-17 10:22:41', '2020-05-17', 'draft', 'standard', NULL, NULL),
(152, 17, 1, 'F2020040108', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:23:03', '2020-04-17 10:23:03', '2020-05-17', 'draft', 'standard', NULL, NULL),
(153, 17, 1, 'F2020040109', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:23:10', '2020-04-17 10:23:10', '2020-05-17', 'draft', 'standard', NULL, NULL),
(154, 17, 1, 'F2020040110', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:23:21', '2020-04-17 10:23:21', '2020-05-17', 'draft', 'standard', NULL, NULL),
(155, 17, 1, 'F2020040111', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:23:32', '2020-04-17 10:23:32', '2020-05-17', 'draft', 'standard', NULL, NULL),
(156, 17, 1, 'F2020040112', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:23:42', '2020-04-17 10:23:42', '2020-05-17', 'draft', 'standard', NULL, NULL),
(157, 17, 1, 'F2020040113', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:24:10', '2020-04-17 10:24:10', '2020-05-17', 'draft', 'standard', NULL, NULL),
(158, 17, 1, 'F2020040114', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:24:31', '2020-04-17 10:24:31', '2020-05-17', 'draft', 'standard', NULL, NULL),
(159, 17, 1, 'F2020040115', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:24:53', '2020-04-17 10:24:53', '2020-05-17', 'draft', 'standard', NULL, NULL),
(160, 17, 1, 'F2020040116', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:25:01', '2020-04-17 10:25:01', '2020-05-17', 'draft', 'standard', NULL, NULL),
(161, 17, 1, 'F2020040117', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:25:10', '2020-04-17 10:25:10', '2020-05-17', 'draft', 'standard', NULL, NULL),
(162, 17, 1, 'F2020040118', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:25:20', '2020-04-17 10:25:20', '2020-05-17', 'draft', 'standard', NULL, NULL),
(163, 17, 1, 'F2020040119', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:25:28', '2020-04-17 10:25:28', '2020-05-17', 'draft', 'standard', NULL, NULL),
(164, 17, 1, 'F2020040120', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:25:38', '2020-04-17 10:25:38', '2020-05-17', 'draft', 'standard', NULL, NULL),
(165, 17, 1, 'F2020040121', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:25:49', '2020-04-17 10:25:49', '2020-05-17', 'draft', 'standard', NULL, NULL),
(166, 17, 1, 'F2020040122', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:25:58', '2020-04-17 10:25:58', '2020-05-17', 'draft', 'standard', NULL, NULL),
(167, 17, 1, 'F2020040123', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:26:07', '2020-04-17 10:26:07', '2020-05-17', 'draft', 'standard', NULL, NULL),
(168, 17, 1, 'F2020040124', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:26:16', '2020-04-17 10:26:16', '2020-05-17', 'draft', 'standard', NULL, NULL),
(169, 17, 1, 'F2020040125', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:26:25', '2020-04-17 10:26:25', '2020-05-17', 'draft', 'standard', NULL, NULL),
(170, 17, 1, 'F2020040126', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:26:34', '2020-04-17 10:26:34', '2020-05-17', 'draft', 'standard', NULL, NULL),
(171, 17, 1, 'F2020040127', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:26:43', '2020-04-17 10:26:43', '2020-05-17', 'draft', 'standard', NULL, NULL),
(172, 17, 1, 'F2020040128', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:26:51', '2020-04-17 10:26:51', '2020-05-17', 'draft', 'standard', NULL, NULL),
(173, 17, 1, 'F2020040129', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:27:00', '2020-04-17 10:27:00', '2020-05-17', 'draft', 'standard', NULL, NULL),
(174, 17, 1, 'F2020040130', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:27:07', '2020-04-17 10:27:07', '2020-05-17', 'draft', 'standard', NULL, NULL),
(175, 17, 1, 'F2020040131', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:27:15', '2020-04-17 10:27:15', '2020-05-17', 'draft', 'standard', NULL, NULL),
(176, 17, 1, 'F2020040132', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:27:32', '2020-04-17 10:27:32', '2020-05-17', 'draft', 'standard', NULL, NULL),
(177, 17, 1, 'F2020040133', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:27:41', '2020-04-17 10:27:41', '2020-05-17', 'draft', 'standard', NULL, NULL),
(178, 17, 1, 'F2020040134', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:27:52', '2020-04-17 10:27:52', '2020-05-17', 'draft', 'standard', NULL, NULL),
(179, 17, 1, 'F2020040135', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:27:59', '2020-04-17 10:27:59', '2020-05-17', 'draft', 'standard', NULL, NULL),
(180, 17, 1, 'F2020040136', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:28:06', '2020-04-17 10:28:06', '2020-05-17', 'draft', 'standard', NULL, NULL),
(181, 17, 1, 'F2020040137', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:28:14', '2020-04-17 10:28:14', '2020-05-17', 'draft', 'standard', NULL, NULL),
(182, 17, 1, 'F2020040138', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:28:23', '2020-04-17 10:28:23', '2020-05-17', 'draft', 'standard', NULL, NULL),
(183, 17, 1, 'F2020040139', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:28:32', '2020-04-17 10:28:32', '2020-05-17', 'draft', 'standard', NULL, NULL),
(184, 17, 1, 'F2020040140', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:28:42', '2020-04-17 10:28:42', '2020-05-17', 'draft', 'standard', NULL, NULL),
(185, 17, 1, 'F2020040141', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:28:49', '2020-04-17 10:28:49', '2020-05-17', 'draft', 'standard', NULL, NULL),
(186, 17, 1, 'F2020040142', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:28:58', '2020-04-17 10:28:58', '2020-05-17', 'draft', 'standard', NULL, NULL),
(187, 17, 1, 'F2020040143', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:29:07', '2020-04-17 10:29:07', '2020-05-17', 'draft', 'standard', NULL, NULL),
(188, 17, 1, 'F2020040144', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:29:16', '2020-04-17 10:29:16', '2020-05-17', 'draft', 'standard', NULL, NULL),
(189, 17, 1, 'F2020040145', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:29:25', '2020-04-17 10:29:25', '2020-05-17', 'draft', 'standard', NULL, NULL),
(190, 17, 1, 'F2020040146', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:29:33', '2020-04-17 10:29:33', '2020-05-17', 'draft', 'standard', NULL, NULL),
(191, 17, 1, 'F2020040147', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:29:45', '2020-04-17 10:29:45', '2020-05-17', 'draft', 'standard', NULL, NULL),
(192, 17, 1, 'F2020040148', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:29:54', '2020-04-17 10:29:54', '2020-05-17', 'draft', 'standard', NULL, NULL),
(193, 17, 1, 'F2020040149', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:30:02', '2020-04-17 10:30:02', '2020-05-17', 'draft', 'standard', NULL, NULL),
(194, 17, 1, 'F2020040150', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 10:30:12', '2020-04-17 10:30:12', '2020-05-17', 'draft', 'standard', NULL, NULL),
(195, 17, 1, 'F2020040151', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 12:45:23', '2020-04-17 12:45:23', '2020-05-17', 'draft', 'standard', NULL, NULL),
(196, 17, 1, 'F2020040152', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 12:45:31', '2020-04-17 12:45:31', '2020-05-17', 'draft', 'standard', NULL, NULL),
(197, 17, 1, 'F2020040153', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 12:45:37', '2020-04-17 12:45:37', '2020-05-17', 'draft', 'standard', NULL, NULL),
(198, 17, 1, 'F2020040154', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 12:45:43', '2020-04-17 12:45:43', '2020-05-17', 'draft', 'standard', NULL, NULL),
(199, 17, 1, 'F2020040155', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 12:45:57', '2020-04-17 12:45:57', '2020-05-17', 'draft', 'standard', NULL, NULL),
(200, 17, 1, 'F2020040156', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 12:46:08', '2020-04-17 12:46:08', '2020-05-17', 'draft', 'standard', NULL, NULL),
(201, 17, 1, 'F2020040157', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 12:46:18', '2020-04-17 12:46:18', '2020-05-17', 'draft', 'standard', NULL, NULL),
(202, 17, 1, 'F2020040158', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 12:46:28', '2020-04-17 12:46:28', '2020-05-17', 'draft', 'standard', NULL, NULL),
(203, 17, 1, 'F2020040159', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 12:46:39', '2020-04-17 12:46:39', '2020-05-17', 'draft', 'standard', NULL, NULL),
(204, 17, 1, 'F2020040160', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 12:46:49', '2020-04-17 12:46:49', '2020-05-17', 'draft', 'standard', NULL, NULL),
(205, 17, 1, 'F2020040161', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 12:46:58', '2020-04-17 12:46:58', '2020-05-17', 'draft', 'standard', NULL, NULL),
(206, 17, 1, 'F2020040162', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 12:47:06', '2020-04-17 12:47:06', '2020-05-17', 'draft', 'standard', NULL, NULL),
(207, 17, 1, 'F2020040163', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 12:47:26', '2020-04-17 12:47:26', '2020-05-17', 'draft', 'standard', NULL, NULL),
(208, 17, 1, 'F2020040164', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 12:47:35', '2020-04-17 12:47:35', '2020-05-17', 'draft', 'standard', NULL, NULL),
(209, 17, 1, 'F2020040165', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 12:47:45', '2020-04-17 12:47:45', '2020-05-17', 'draft', 'standard', NULL, NULL),
(210, 17, 1, 'F2020040166', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 12:48:18', '2020-04-17 12:48:18', '2020-05-17', 'draft', 'standard', NULL, NULL),
(211, 17, 1, 'F2020040167', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 12:48:26', '2020-04-17 12:48:26', '2020-05-17', 'draft', 'standard', NULL, NULL),
(212, 17, 1, 'F2020040168', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 12:49:08', '2020-04-17 12:49:08', '2020-05-17', 'draft', 'standard', NULL, NULL),
(213, 17, 1, 'F2020040169', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 12:49:23', '2020-04-17 12:49:23', '2020-05-17', 'draft', 'standard', NULL, NULL),
(214, 17, 1, 'F2020040170', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 14:21:40', '2020-04-17 14:21:40', '2020-05-17', 'draft', 'standard', 2, NULL),
(215, 17, 1, 'F2020040171', 'Projet', 24000, 0, 24000, 2520, 26520, '2020-04-17 14:28:32', '2020-04-17 14:28:32', '2020-05-17', 'draft', 'standard', 2, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `invoice_item`
--

CREATE TABLE `invoice_item` (
  `item_id` bigint(20) UNSIGNED DEFAULT NULL,
  `invoice_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `invoice_recurrences`
--

CREATE TABLE `invoice_recurrences` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `invoice_id` bigint(20) UNSIGNED DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `period` varchar(255) NOT NULL,
  `occurence` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `invoice_recurrence_dates`
--

CREATE TABLE `invoice_recurrence_dates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_recurrence_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `invoice_tax`
--

CREATE TABLE `invoice_tax` (
  `invoice_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tax_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `invoice_tax`
--

INSERT INTO `invoice_tax` (`invoice_id`, `tax_id`) VALUES
(44, 3),
(44, 2),
(45, 3),
(45, 2),
(46, 3),
(46, 2),
(48, 3),
(48, 2),
(49, 3),
(49, 2),
(50, 3),
(50, 2),
(50, 1),
(51, 3),
(51, 2),
(58, 2),
(58, 3),
(59, 2),
(59, 3),
(60, 3),
(60, 2),
(61, 2),
(61, 3),
(62, 2),
(62, 3),
(64, 2),
(64, 3),
(65, 2),
(65, 3),
(66, 2),
(66, 3),
(67, 2),
(67, 3),
(68, 2),
(68, 3),
(69, 2),
(69, 3),
(70, 2),
(70, 3),
(71, 2),
(71, 3),
(72, 2),
(72, 3),
(73, 2),
(73, 3),
(74, 2),
(74, 3),
(75, 2),
(75, 3),
(76, 2),
(76, 3),
(77, 2),
(77, 3),
(78, 2),
(78, 3),
(79, 2),
(79, 3),
(80, 2),
(80, 3),
(81, 2),
(81, 3),
(82, 2),
(82, 3),
(83, 2),
(83, 3),
(84, 2),
(84, 3),
(85, 2),
(85, 3),
(86, 2),
(86, 3),
(87, 2),
(87, 3),
(88, 2),
(88, 3),
(89, 2),
(89, 3),
(90, 2),
(90, 3),
(91, 2),
(91, 3),
(92, 2),
(92, 3),
(93, 2),
(93, 3),
(94, 2),
(94, 3),
(95, 2),
(95, 3),
(96, 2),
(96, 3),
(97, 2),
(97, 3),
(98, 2),
(98, 3),
(99, 2),
(99, 3),
(100, 2),
(100, 3),
(101, 2),
(101, 3),
(102, 2),
(102, 3),
(103, 2),
(103, 3),
(104, 2),
(104, 3),
(105, 2),
(105, 3),
(106, 2),
(106, 3),
(107, 2),
(107, 3),
(108, 2),
(108, 3),
(109, 2),
(109, 3),
(110, 2),
(110, 3),
(111, 2),
(111, 3),
(112, 2),
(112, 3),
(113, 2),
(113, 3),
(114, 2),
(114, 3),
(115, 2),
(115, 3),
(116, 2),
(116, 3),
(117, 2),
(117, 3),
(118, 2),
(118, 3),
(119, 2),
(119, 3),
(120, 2),
(120, 3),
(121, 2),
(121, 3),
(122, 2),
(122, 3),
(123, 2),
(123, 3),
(124, 2),
(124, 3),
(125, 2),
(125, 3),
(126, 2),
(126, 3),
(127, 2),
(127, 3),
(128, 2),
(128, 3),
(129, 2),
(129, 3),
(130, 2),
(130, 3),
(131, 2),
(131, 3),
(132, 2),
(132, 3),
(133, 2),
(133, 3),
(134, 2),
(134, 3),
(135, 2),
(135, 3),
(136, 2),
(136, 3),
(137, 2),
(137, 3),
(138, 2),
(138, 3),
(139, 2),
(139, 3),
(140, 2),
(140, 3),
(141, 2),
(141, 3),
(142, 2),
(142, 3),
(143, 2),
(143, 3),
(144, 2),
(144, 3),
(145, 2),
(145, 3),
(146, 2),
(146, 3),
(147, 2),
(147, 3),
(148, 2),
(148, 3),
(149, 2),
(149, 3),
(150, 2),
(150, 3),
(151, 2),
(151, 3),
(152, 2),
(152, 3),
(153, 2),
(153, 3),
(154, 2),
(154, 3),
(155, 2),
(155, 3),
(156, 2),
(156, 3),
(157, 2),
(157, 3),
(158, 2),
(158, 3),
(159, 2),
(159, 3),
(160, 2),
(160, 3),
(161, 2),
(161, 3),
(162, 2),
(162, 3),
(163, 2),
(163, 3),
(164, 2),
(164, 3),
(165, 2),
(165, 3),
(166, 2),
(166, 3),
(167, 2),
(167, 3),
(168, 2),
(168, 3),
(169, 2),
(169, 3),
(170, 2),
(170, 3),
(171, 2),
(171, 3),
(172, 2),
(172, 3),
(173, 2),
(173, 3),
(174, 2),
(174, 3),
(175, 2),
(175, 3),
(176, 2),
(176, 3),
(177, 2),
(177, 3),
(178, 2),
(178, 3),
(179, 2),
(179, 3),
(180, 2),
(180, 3),
(181, 2),
(181, 3),
(182, 2),
(182, 3),
(183, 2),
(183, 3),
(184, 2),
(184, 3),
(185, 2),
(185, 3),
(186, 2),
(186, 3),
(187, 2),
(187, 3),
(188, 2),
(188, 3),
(189, 2),
(189, 3),
(190, 2),
(190, 3),
(191, 2),
(191, 3),
(192, 2),
(192, 3),
(193, 2),
(193, 3),
(194, 2),
(194, 3),
(195, 2),
(195, 3),
(196, 2),
(196, 3),
(197, 2),
(197, 3),
(198, 2),
(198, 3),
(199, 2),
(199, 3),
(200, 2),
(200, 3),
(201, 2),
(201, 3),
(202, 2),
(202, 3),
(203, 2),
(203, 3),
(204, 2),
(204, 3),
(205, 2),
(205, 3),
(206, 2),
(206, 3),
(207, 2),
(207, 3),
(208, 2),
(208, 3),
(209, 2),
(209, 3),
(210, 2),
(210, 3),
(211, 2),
(211, 3),
(212, 2),
(212, 3),
(213, 2),
(213, 3),
(214, 3),
(214, 2),
(215, 3),
(215, 2);

-- --------------------------------------------------------

--
-- Structure de la table `items`
--

CREATE TABLE `items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `pu` double DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `itemable_id` int(11) DEFAULT NULL,
  `itemable_type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `items`
--

INSERT INTO `items` (`id`, `pu`, `qty`, `label`, `amount`, `created_at`, `updated_at`, `itemable_id`, `itemable_type`) VALUES
(249, 10000, 3, 'item1', 30000, '2020-04-14 02:03:34', '2020-04-14 02:03:34', 1, 'App\\PurchaseOrder'),
(250, 3500, 50, 'item2', 175000, '2020-04-14 02:03:34', '2020-04-14 02:03:34', 1, 'App\\PurchaseOrder'),
(252, 45000, 5, 'item1', 225000, '2020-04-14 02:10:33', '2020-04-14 02:10:33', 3, 'App\\PurchaseOrder'),
(253, 1300000, 1, 'item2', 1300000, '2020-04-14 02:10:33', '2020-04-14 02:10:33', 3, 'App\\PurchaseOrder'),
(265, 2400000, 1, 'item1', 2400000, '2020-04-14 08:17:33', '2020-04-14 08:17:33', 4, 'App\\PurchaseOrder'),
(266, 5000, 3, 'item2', 15000, '2020-04-14 08:17:33', '2020-04-14 08:17:33', 4, 'App\\PurchaseOrder'),
(267, 3000, 10, 'item3', 30000, '2020-04-14 08:17:33', '2020-04-14 08:17:33', 4, 'App\\PurchaseOrder'),
(268, 8500, 10, 'item4', 85000, '2020-04-14 08:17:33', '2020-04-14 08:17:33', 4, 'App\\PurchaseOrder'),
(270, 25000, 10, 'item1', 250000, '2020-04-14 08:19:54', '2020-04-14 08:19:54', 5, 'App\\PurchaseOrder'),
(276, 1000, 3, 'item1', 3000, '2020-04-14 17:13:44', '2020-04-14 17:13:44', 77, 'App\\Quote'),
(282, 1000, 3, 'item1', 3000, '2020-04-14 17:21:01', '2020-04-14 17:21:01', 79, 'App\\Quote'),
(283, 1300, 23, 'item2', 29900, '2020-04-14 17:21:01', '2020-04-14 17:21:01', 79, 'App\\Quote'),
(284, 1350000, 1, 'item1', 1350000, '2020-04-14 17:22:32', '2020-04-14 17:22:32', 8, 'App\\PurchaseOrder'),
(285, 150000, 2, 'item2', 300000, '2020-04-14 17:22:32', '2020-04-14 17:22:32', 8, 'App\\PurchaseOrder'),
(286, 1350000, 1, 'item1', 1350000, '2020-04-14 17:33:19', '2020-04-14 17:33:19', 9, 'App\\PurchaseOrder'),
(287, 150000, 2, 'item2', 300000, '2020-04-14 17:33:19', '2020-04-14 17:33:19', 9, 'App\\PurchaseOrder'),
(288, 1350000, 1, 'item1', 1350000, '2020-04-14 17:35:41', '2020-04-14 17:35:41', 10, 'App\\PurchaseOrder'),
(289, 150000, 2, 'item2', 300000, '2020-04-14 17:35:42', '2020-04-14 17:35:42', 10, 'App\\PurchaseOrder'),
(290, 35000, 10, 'item3', 350000, '2020-04-14 17:35:42', '2020-04-14 17:35:42', 10, 'App\\PurchaseOrder'),
(291, 25000, 10, 'item1', 250000, '2020-04-14 17:37:10', '2020-04-14 17:37:10', 11, 'App\\PurchaseOrder'),
(292, 25000, 10, 'item1', 250000, '2020-04-14 17:37:48', '2020-04-14 17:37:48', 12, 'App\\PurchaseOrder'),
(293, 45000, 5, 'item1', 225000, '2020-04-14 17:38:33', '2020-04-14 17:38:34', 13, 'App\\PurchaseOrder'),
(294, 1300000, 1, 'item2', 1300000, '2020-04-14 17:38:34', '2020-04-14 17:38:34', 13, 'App\\PurchaseOrder'),
(295, 45000, 5, 'item1', 225000, '2020-04-14 17:39:51', '2020-04-14 17:39:51', 14, 'App\\PurchaseOrder'),
(296, 1300000, 1, 'item2', 1300000, '2020-04-14 17:39:51', '2020-04-14 17:39:51', 14, 'App\\PurchaseOrder'),
(299, 1000, 3, 'item1', 3000, '2020-04-14 18:28:15', '2020-04-14 18:28:15', 80, 'App\\Quote'),
(300, 1300, 23, 'item2', 29900, '2020-04-14 18:28:15', '2020-04-14 18:28:16', 80, 'App\\Quote'),
(301, 45000, 5, 'item1', 225000, '2020-04-14 19:03:32', '2020-04-14 19:03:32', 16, 'App\\PurchaseOrder'),
(302, 1300000, 1, 'item2', 1300000, '2020-04-14 19:03:32', '2020-04-14 19:03:32', 16, 'App\\PurchaseOrder'),
(303, 1500000, 1, 'item1', 1500000, '2020-04-14 23:36:04', '2020-04-14 23:36:04', 40, 'App\\Invoice'),
(320, 1350000, 2, 'item1', 2700000, '2020-04-15 00:18:18', '2020-04-15 00:18:19', 41, 'App\\Invoice'),
(321, 5000, 3, 'item2', 15000, '2020-04-15 00:18:19', '2020-04-15 00:18:19', 41, 'App\\Invoice'),
(322, 12000, 3, 'item1', 36000, '2020-04-15 00:22:50', '2020-04-15 00:22:50', 42, 'App\\Invoice'),
(323, 1500, 26, 'item2', 39000, '2020-04-15 00:22:50', '2020-04-15 00:22:50', 42, 'App\\Invoice'),
(324, 25000, 4, 'item1', 100000, '2020-04-15 00:26:51', '2020-04-15 00:26:51', 43, 'App\\Invoice'),
(325, 15000, 3, 'item1', 45000, '2020-04-15 00:29:26', '2020-04-15 00:29:26', 44, 'App\\Invoice'),
(326, 125000, 1, 'item1', 125000, '2020-04-15 08:18:14', '2020-04-15 08:18:14', 45, 'App\\Invoice'),
(327, 11200, 18, 'item1', 201600, '2020-04-15 08:19:07', '2020-04-15 08:19:07', 46, 'App\\Invoice'),
(328, 120000, 1, 'item1', 120000, '2020-04-15 15:33:27', '2020-04-15 15:33:27', 47, 'App\\Invoice'),
(329, 14000, 2, 'item', 28000, '2020-04-15 15:34:08', '2020-04-15 15:34:08', 48, 'App\\Invoice'),
(330, 11000, 36, 'item', 396000, '2020-04-15 15:35:11', '2020-04-15 15:35:11', 49, 'App\\Invoice'),
(331, 23000, 2, 'item', 46000, '2020-04-15 15:36:01', '2020-04-15 15:36:02', 50, 'App\\Invoice'),
(332, 12000, 2, 'item', 24000, '2020-04-15 15:38:17', '2020-04-15 15:38:17', 51, 'App\\Invoice'),
(333, 12000, 2, 'item', 24000, '2020-04-15 20:37:17', '2020-04-15 20:37:17', 52, 'App\\Invoice'),
(334, 12000, 2, 'item', 24000, '2020-04-15 21:06:52', '2020-04-15 21:06:52', 53, 'App\\Invoice'),
(335, 12000, 2, 'item', 24000, '2020-04-15 21:08:03', '2020-04-15 21:08:03', 54, 'App\\Invoice'),
(336, 12000, 2, 'item', 24000, '2020-04-15 21:08:33', '2020-04-15 21:08:34', 55, 'App\\Invoice'),
(337, 12000, 2, 'item', 24000, '2020-04-15 21:09:29', '2020-04-15 21:09:29', 56, 'App\\Invoice'),
(338, 12000, 2, 'item', 24000, '2020-04-15 21:10:59', '2020-04-15 21:10:59', 57, 'App\\Invoice'),
(339, 12000, 2, 'item', 24000, '2020-04-15 21:17:01', '2020-04-15 21:17:01', 58, 'App\\Invoice'),
(340, 12000, 2, 'item', 24000, '2020-04-15 21:19:30', '2020-04-15 21:19:30', 59, 'App\\Invoice'),
(341, 35000, 7, 'item1', 245000, '2020-04-16 13:49:54', '2020-04-16 13:49:55', 60, 'App\\Invoice'),
(343, 23000, 2, 'item1', 46000, '2020-04-16 14:10:52', '2020-04-16 14:10:53', 61, 'App\\Invoice'),
(344, 12000, 2, 'item', 24000, '2020-04-16 14:52:07', '2020-04-16 14:52:07', 62, 'App\\Invoice'),
(348, 23000, 2, 'item1', 46000, '2020-04-16 18:21:14', '2020-04-16 18:21:14', 64, 'App\\Invoice'),
(349, 23000, 2, 'item1', 46000, '2020-04-17 09:50:30', '2020-04-17 09:50:30', 65, 'App\\Invoice'),
(350, 23000, 2, 'item1', 46000, '2020-04-17 09:50:40', '2020-04-17 09:50:40', 66, 'App\\Invoice'),
(351, 23000, 2, 'item1', 46000, '2020-04-17 09:50:49', '2020-04-17 09:50:49', 67, 'App\\Invoice'),
(352, 23000, 2, 'item1', 46000, '2020-04-17 09:51:00', '2020-04-17 09:51:00', 68, 'App\\Invoice'),
(353, 23000, 2, 'item1', 46000, '2020-04-17 09:51:08', '2020-04-17 09:51:08', 69, 'App\\Invoice'),
(354, 23000, 2, 'item1', 46000, '2020-04-17 09:51:17', '2020-04-17 09:51:17', 70, 'App\\Invoice'),
(355, 23000, 2, 'item1', 46000, '2020-04-17 09:51:25', '2020-04-17 09:51:25', 71, 'App\\Invoice'),
(356, 23000, 2, 'item1', 46000, '2020-04-17 09:51:33', '2020-04-17 09:51:33', 72, 'App\\Invoice'),
(357, 23000, 2, 'item1', 46000, '2020-04-17 09:51:42', '2020-04-17 09:51:42', 73, 'App\\Invoice'),
(358, 23000, 2, 'item1', 46000, '2020-04-17 09:51:52', '2020-04-17 09:51:52', 74, 'App\\Invoice'),
(359, 23000, 2, 'item1', 46000, '2020-04-17 09:52:01', '2020-04-17 09:52:01', 75, 'App\\Invoice'),
(360, 23000, 2, 'item1', 46000, '2020-04-17 09:52:09', '2020-04-17 09:52:10', 76, 'App\\Invoice'),
(361, 23000, 2, 'item1', 46000, '2020-04-17 09:52:18', '2020-04-17 09:52:18', 77, 'App\\Invoice'),
(362, 23000, 2, 'item1', 46000, '2020-04-17 09:52:28', '2020-04-17 09:52:28', 78, 'App\\Invoice'),
(363, 23000, 2, 'item1', 46000, '2020-04-17 09:52:41', '2020-04-17 09:52:41', 79, 'App\\Invoice'),
(364, 23000, 2, 'item1', 46000, '2020-04-17 09:52:49', '2020-04-17 09:52:49', 80, 'App\\Invoice'),
(365, 23000, 2, 'item1', 46000, '2020-04-17 09:52:58', '2020-04-17 09:52:58', 81, 'App\\Invoice'),
(366, 23000, 2, 'item1', 46000, '2020-04-17 09:53:10', '2020-04-17 09:53:10', 82, 'App\\Invoice'),
(367, 23000, 2, 'item1', 46000, '2020-04-17 09:53:41', '2020-04-17 09:53:41', 83, 'App\\Invoice'),
(368, 23000, 2, 'item1', 46000, '2020-04-17 09:54:07', '2020-04-17 09:54:07', 84, 'App\\Invoice'),
(369, 23000, 2, 'item1', 46000, '2020-04-17 09:54:15', '2020-04-17 09:54:15', 85, 'App\\Invoice'),
(370, 23000, 2, 'item1', 46000, '2020-04-17 09:54:24', '2020-04-17 09:54:24', 86, 'App\\Invoice'),
(371, 23000, 2, 'item1', 46000, '2020-04-17 09:54:32', '2020-04-17 09:54:32', 87, 'App\\Invoice'),
(372, 23000, 2, 'item1', 46000, '2020-04-17 09:54:40', '2020-04-17 09:54:40', 88, 'App\\Invoice'),
(373, 23000, 2, 'item1', 46000, '2020-04-17 09:54:49', '2020-04-17 09:54:49', 89, 'App\\Invoice'),
(374, 23000, 2, 'item1', 46000, '2020-04-17 09:55:01', '2020-04-17 09:55:01', 90, 'App\\Invoice'),
(375, 23000, 2, 'item1', 46000, '2020-04-17 09:55:11', '2020-04-17 09:55:11', 91, 'App\\Invoice'),
(376, 23000, 2, 'item1', 46000, '2020-04-17 09:55:56', '2020-04-17 09:55:56', 92, 'App\\Invoice'),
(377, 23000, 2, 'item1', 46000, '2020-04-17 09:56:06', '2020-04-17 09:56:06', 93, 'App\\Invoice'),
(378, 23000, 2, 'item1', 46000, '2020-04-17 09:56:14', '2020-04-17 09:56:14', 94, 'App\\Invoice'),
(379, 23000, 2, 'item1', 46000, '2020-04-17 09:56:22', '2020-04-17 09:56:23', 95, 'App\\Invoice'),
(380, 23000, 2, 'item1', 46000, '2020-04-17 09:56:30', '2020-04-17 09:56:30', 96, 'App\\Invoice'),
(381, 23000, 2, 'item1', 46000, '2020-04-17 09:56:39', '2020-04-17 09:56:39', 97, 'App\\Invoice'),
(382, 23000, 2, 'item1', 46000, '2020-04-17 09:57:19', '2020-04-17 09:57:19', 98, 'App\\Invoice'),
(383, 23000, 2, 'item1', 46000, '2020-04-17 09:58:09', '2020-04-17 09:58:09', 99, 'App\\Invoice'),
(384, 23000, 2, 'item1', 46000, '2020-04-17 09:59:51', '2020-04-17 09:59:51', 100, 'App\\Invoice'),
(385, 23000, 2, 'item1', 46000, '2020-04-17 10:00:02', '2020-04-17 10:00:02', 101, 'App\\Invoice'),
(386, 23000, 2, 'item1', 46000, '2020-04-17 10:00:11', '2020-04-17 10:00:11', 102, 'App\\Invoice'),
(387, 23000, 2, 'item1', 46000, '2020-04-17 10:00:20', '2020-04-17 10:00:20', 103, 'App\\Invoice'),
(388, 23000, 2, 'item1', 46000, '2020-04-17 10:00:38', '2020-04-17 10:00:38', 104, 'App\\Invoice'),
(389, 23000, 2, 'item1', 46000, '2020-04-17 10:00:47', '2020-04-17 10:00:47', 105, 'App\\Invoice'),
(390, 23000, 2, 'item1', 46000, '2020-04-17 10:00:56', '2020-04-17 10:00:56', 106, 'App\\Invoice'),
(391, 23000, 2, 'item1', 46000, '2020-04-17 10:01:05', '2020-04-17 10:01:05', 107, 'App\\Invoice'),
(392, 23000, 2, 'item1', 46000, '2020-04-17 10:01:12', '2020-04-17 10:01:13', 108, 'App\\Invoice'),
(393, 23000, 2, 'item1', 46000, '2020-04-17 10:01:20', '2020-04-17 10:01:20', 109, 'App\\Invoice'),
(394, 23000, 2, 'item1', 46000, '2020-04-17 10:01:30', '2020-04-17 10:01:30', 110, 'App\\Invoice'),
(395, 23000, 2, 'item1', 46000, '2020-04-17 10:01:38', '2020-04-17 10:01:38', 111, 'App\\Invoice'),
(396, 23000, 2, 'item1', 46000, '2020-04-17 10:02:16', '2020-04-17 10:02:16', 112, 'App\\Invoice'),
(397, 23000, 2, 'item1', 46000, '2020-04-17 10:02:51', '2020-04-17 10:02:51', 113, 'App\\Invoice'),
(398, 23000, 2, 'item1', 46000, '2020-04-17 10:03:00', '2020-04-17 10:03:00', 114, 'App\\Invoice'),
(399, 23000, 2, 'item1', 46000, '2020-04-17 10:13:13', '2020-04-17 10:13:13', 115, 'App\\Invoice'),
(400, 23000, 2, 'item1', 46000, '2020-04-17 10:13:23', '2020-04-17 10:13:23', 116, 'App\\Invoice'),
(401, 23000, 2, 'item1', 46000, '2020-04-17 10:13:36', '2020-04-17 10:13:36', 117, 'App\\Invoice'),
(402, 23000, 2, 'item1', 46000, '2020-04-17 10:13:47', '2020-04-17 10:13:47', 118, 'App\\Invoice'),
(403, 23000, 2, 'item1', 46000, '2020-04-17 10:14:06', '2020-04-17 10:14:06', 119, 'App\\Invoice'),
(404, 23000, 2, 'item1', 46000, '2020-04-17 10:14:16', '2020-04-17 10:14:16', 120, 'App\\Invoice'),
(405, 23000, 2, 'item1', 46000, '2020-04-17 10:14:25', '2020-04-17 10:14:25', 121, 'App\\Invoice'),
(406, 23000, 2, 'item1', 46000, '2020-04-17 10:15:00', '2020-04-17 10:15:00', 122, 'App\\Invoice'),
(407, 23000, 2, 'item1', 46000, '2020-04-17 10:15:08', '2020-04-17 10:15:08', 123, 'App\\Invoice'),
(408, 12000, 2, 'item', 24000, '2020-04-17 10:17:35', '2020-04-17 10:17:36', 124, 'App\\Invoice'),
(409, 12000, 2, 'item', 24000, '2020-04-17 10:17:55', '2020-04-17 10:17:55', 125, 'App\\Invoice'),
(410, 12000, 2, 'item', 24000, '2020-04-17 10:18:03', '2020-04-17 10:18:03', 126, 'App\\Invoice'),
(411, 12000, 2, 'item', 24000, '2020-04-17 10:18:13', '2020-04-17 10:18:13', 127, 'App\\Invoice'),
(412, 12000, 2, 'item', 24000, '2020-04-17 10:18:22', '2020-04-17 10:18:22', 128, 'App\\Invoice'),
(413, 12000, 2, 'item', 24000, '2020-04-17 10:18:32', '2020-04-17 10:18:32', 129, 'App\\Invoice'),
(414, 12000, 2, 'item', 24000, '2020-04-17 10:18:40', '2020-04-17 10:18:40', 130, 'App\\Invoice'),
(415, 12000, 2, 'item', 24000, '2020-04-17 10:18:48', '2020-04-17 10:18:48', 131, 'App\\Invoice'),
(416, 12000, 2, 'item', 24000, '2020-04-17 10:18:59', '2020-04-17 10:18:59', 132, 'App\\Invoice'),
(417, 12000, 2, 'item', 24000, '2020-04-17 10:19:26', '2020-04-17 10:19:26', 133, 'App\\Invoice'),
(418, 12000, 2, 'item', 24000, '2020-04-17 10:19:38', '2020-04-17 10:19:38', 134, 'App\\Invoice'),
(419, 12000, 2, 'item', 24000, '2020-04-17 10:19:48', '2020-04-17 10:19:48', 135, 'App\\Invoice'),
(420, 12000, 2, 'item', 24000, '2020-04-17 10:19:59', '2020-04-17 10:20:00', 136, 'App\\Invoice'),
(421, 12000, 2, 'item', 24000, '2020-04-17 10:20:10', '2020-04-17 10:20:10', 137, 'App\\Invoice'),
(422, 12000, 2, 'item', 24000, '2020-04-17 10:20:43', '2020-04-17 10:20:43', 138, 'App\\Invoice'),
(423, 12000, 2, 'item', 24000, '2020-04-17 10:20:51', '2020-04-17 10:20:51', 139, 'App\\Invoice'),
(424, 12000, 2, 'item', 24000, '2020-04-17 10:21:00', '2020-04-17 10:21:00', 140, 'App\\Invoice'),
(425, 12000, 2, 'item', 24000, '2020-04-17 10:21:06', '2020-04-17 10:21:06', 141, 'App\\Invoice'),
(426, 12000, 2, 'item', 24000, '2020-04-17 10:21:21', '2020-04-17 10:21:21', 142, 'App\\Invoice'),
(427, 12000, 2, 'item', 24000, '2020-04-17 10:21:29', '2020-04-17 10:21:29', 143, 'App\\Invoice'),
(428, 12000, 2, 'item', 24000, '2020-04-17 10:21:36', '2020-04-17 10:21:36', 144, 'App\\Invoice'),
(429, 12000, 2, 'item', 24000, '2020-04-17 10:21:46', '2020-04-17 10:21:46', 145, 'App\\Invoice'),
(430, 12000, 2, 'item', 24000, '2020-04-17 10:21:53', '2020-04-17 10:21:53', 146, 'App\\Invoice'),
(431, 12000, 2, 'item', 24000, '2020-04-17 10:22:08', '2020-04-17 10:22:08', 147, 'App\\Invoice'),
(432, 12000, 2, 'item', 24000, '2020-04-17 10:22:16', '2020-04-17 10:22:16', 148, 'App\\Invoice'),
(433, 12000, 2, 'item', 24000, '2020-04-17 10:22:25', '2020-04-17 10:22:25', 149, 'App\\Invoice'),
(434, 12000, 2, 'item', 24000, '2020-04-17 10:22:33', '2020-04-17 10:22:33', 150, 'App\\Invoice'),
(435, 12000, 2, 'item', 24000, '2020-04-17 10:22:41', '2020-04-17 10:22:41', 151, 'App\\Invoice'),
(436, 12000, 2, 'item', 24000, '2020-04-17 10:23:03', '2020-04-17 10:23:03', 152, 'App\\Invoice'),
(437, 12000, 2, 'item', 24000, '2020-04-17 10:23:10', '2020-04-17 10:23:10', 153, 'App\\Invoice'),
(438, 12000, 2, 'item', 24000, '2020-04-17 10:23:21', '2020-04-17 10:23:21', 154, 'App\\Invoice'),
(439, 12000, 2, 'item', 24000, '2020-04-17 10:23:32', '2020-04-17 10:23:32', 155, 'App\\Invoice'),
(440, 12000, 2, 'item', 24000, '2020-04-17 10:23:42', '2020-04-17 10:23:42', 156, 'App\\Invoice'),
(441, 12000, 2, 'item', 24000, '2020-04-17 10:24:10', '2020-04-17 10:24:10', 157, 'App\\Invoice'),
(442, 12000, 2, 'item', 24000, '2020-04-17 10:24:31', '2020-04-17 10:24:31', 158, 'App\\Invoice'),
(443, 12000, 2, 'item', 24000, '2020-04-17 10:24:53', '2020-04-17 10:24:53', 159, 'App\\Invoice'),
(444, 12000, 2, 'item', 24000, '2020-04-17 10:25:01', '2020-04-17 10:25:01', 160, 'App\\Invoice'),
(445, 12000, 2, 'item', 24000, '2020-04-17 10:25:10', '2020-04-17 10:25:10', 161, 'App\\Invoice'),
(446, 12000, 2, 'item', 24000, '2020-04-17 10:25:20', '2020-04-17 10:25:20', 162, 'App\\Invoice'),
(447, 12000, 2, 'item', 24000, '2020-04-17 10:25:28', '2020-04-17 10:25:28', 163, 'App\\Invoice'),
(448, 12000, 2, 'item', 24000, '2020-04-17 10:25:38', '2020-04-17 10:25:38', 164, 'App\\Invoice'),
(449, 12000, 2, 'item', 24000, '2020-04-17 10:25:49', '2020-04-17 10:25:49', 165, 'App\\Invoice'),
(450, 12000, 2, 'item', 24000, '2020-04-17 10:25:58', '2020-04-17 10:25:58', 166, 'App\\Invoice'),
(451, 12000, 2, 'item', 24000, '2020-04-17 10:26:07', '2020-04-17 10:26:07', 167, 'App\\Invoice'),
(452, 12000, 2, 'item', 24000, '2020-04-17 10:26:16', '2020-04-17 10:26:16', 168, 'App\\Invoice'),
(453, 12000, 2, 'item', 24000, '2020-04-17 10:26:25', '2020-04-17 10:26:25', 169, 'App\\Invoice'),
(454, 12000, 2, 'item', 24000, '2020-04-17 10:26:34', '2020-04-17 10:26:34', 170, 'App\\Invoice'),
(455, 12000, 2, 'item', 24000, '2020-04-17 10:26:43', '2020-04-17 10:26:43', 171, 'App\\Invoice'),
(456, 12000, 2, 'item', 24000, '2020-04-17 10:26:51', '2020-04-17 10:26:51', 172, 'App\\Invoice'),
(457, 12000, 2, 'item', 24000, '2020-04-17 10:27:00', '2020-04-17 10:27:00', 173, 'App\\Invoice'),
(458, 12000, 2, 'item', 24000, '2020-04-17 10:27:07', '2020-04-17 10:27:07', 174, 'App\\Invoice'),
(459, 12000, 2, 'item', 24000, '2020-04-17 10:27:15', '2020-04-17 10:27:15', 175, 'App\\Invoice'),
(460, 12000, 2, 'item', 24000, '2020-04-17 10:27:32', '2020-04-17 10:27:32', 176, 'App\\Invoice'),
(461, 12000, 2, 'item', 24000, '2020-04-17 10:27:41', '2020-04-17 10:27:41', 177, 'App\\Invoice'),
(462, 12000, 2, 'item', 24000, '2020-04-17 10:27:52', '2020-04-17 10:27:52', 178, 'App\\Invoice'),
(463, 12000, 2, 'item', 24000, '2020-04-17 10:27:59', '2020-04-17 10:27:59', 179, 'App\\Invoice'),
(464, 12000, 2, 'item', 24000, '2020-04-17 10:28:06', '2020-04-17 10:28:06', 180, 'App\\Invoice'),
(465, 12000, 2, 'item', 24000, '2020-04-17 10:28:14', '2020-04-17 10:28:14', 181, 'App\\Invoice'),
(466, 12000, 2, 'item', 24000, '2020-04-17 10:28:23', '2020-04-17 10:28:23', 182, 'App\\Invoice'),
(467, 12000, 2, 'item', 24000, '2020-04-17 10:28:32', '2020-04-17 10:28:32', 183, 'App\\Invoice'),
(468, 12000, 2, 'item', 24000, '2020-04-17 10:28:42', '2020-04-17 10:28:42', 184, 'App\\Invoice'),
(469, 12000, 2, 'item', 24000, '2020-04-17 10:28:49', '2020-04-17 10:28:49', 185, 'App\\Invoice'),
(470, 12000, 2, 'item', 24000, '2020-04-17 10:28:58', '2020-04-17 10:28:59', 186, 'App\\Invoice'),
(471, 12000, 2, 'item', 24000, '2020-04-17 10:29:07', '2020-04-17 10:29:07', 187, 'App\\Invoice'),
(472, 12000, 2, 'item', 24000, '2020-04-17 10:29:16', '2020-04-17 10:29:16', 188, 'App\\Invoice'),
(473, 12000, 2, 'item', 24000, '2020-04-17 10:29:25', '2020-04-17 10:29:25', 189, 'App\\Invoice'),
(474, 12000, 2, 'item', 24000, '2020-04-17 10:29:33', '2020-04-17 10:29:33', 190, 'App\\Invoice'),
(475, 12000, 2, 'item', 24000, '2020-04-17 10:29:45', '2020-04-17 10:29:45', 191, 'App\\Invoice'),
(476, 12000, 2, 'item', 24000, '2020-04-17 10:29:54', '2020-04-17 10:29:54', 192, 'App\\Invoice'),
(477, 12000, 2, 'item', 24000, '2020-04-17 10:30:02', '2020-04-17 10:30:02', 193, 'App\\Invoice'),
(478, 12000, 2, 'item', 24000, '2020-04-17 10:30:12', '2020-04-17 10:30:12', 194, 'App\\Invoice'),
(479, 12000, 2, 'item', 24000, '2020-04-17 12:45:23', '2020-04-17 12:45:23', 195, 'App\\Invoice'),
(480, 12000, 2, 'item', 24000, '2020-04-17 12:45:31', '2020-04-17 12:45:31', 196, 'App\\Invoice'),
(481, 12000, 2, 'item', 24000, '2020-04-17 12:45:38', '2020-04-17 12:45:38', 197, 'App\\Invoice'),
(482, 12000, 2, 'item', 24000, '2020-04-17 12:45:43', '2020-04-17 12:45:43', 198, 'App\\Invoice'),
(483, 12000, 2, 'item', 24000, '2020-04-17 12:45:57', '2020-04-17 12:45:57', 199, 'App\\Invoice'),
(484, 12000, 2, 'item', 24000, '2020-04-17 12:46:08', '2020-04-17 12:46:08', 200, 'App\\Invoice'),
(485, 12000, 2, 'item', 24000, '2020-04-17 12:46:18', '2020-04-17 12:46:18', 201, 'App\\Invoice'),
(486, 12000, 2, 'item', 24000, '2020-04-17 12:46:28', '2020-04-17 12:46:28', 202, 'App\\Invoice'),
(487, 12000, 2, 'item', 24000, '2020-04-17 12:46:39', '2020-04-17 12:46:39', 203, 'App\\Invoice'),
(488, 12000, 2, 'item', 24000, '2020-04-17 12:46:49', '2020-04-17 12:46:49', 204, 'App\\Invoice'),
(489, 12000, 2, 'item', 24000, '2020-04-17 12:46:58', '2020-04-17 12:46:58', 205, 'App\\Invoice'),
(490, 12000, 2, 'item', 24000, '2020-04-17 12:47:06', '2020-04-17 12:47:06', 206, 'App\\Invoice'),
(491, 12000, 2, 'item', 24000, '2020-04-17 12:47:26', '2020-04-17 12:47:26', 207, 'App\\Invoice'),
(492, 12000, 2, 'item', 24000, '2020-04-17 12:47:35', '2020-04-17 12:47:35', 208, 'App\\Invoice'),
(493, 12000, 2, 'item', 24000, '2020-04-17 12:47:45', '2020-04-17 12:47:45', 209, 'App\\Invoice'),
(494, 12000, 2, 'item', 24000, '2020-04-17 12:48:18', '2020-04-17 12:48:18', 210, 'App\\Invoice'),
(495, 12000, 2, 'item', 24000, '2020-04-17 12:48:27', '2020-04-17 12:48:27', 211, 'App\\Invoice'),
(496, 12000, 2, 'item', 24000, '2020-04-17 12:49:08', '2020-04-17 12:49:08', 212, 'App\\Invoice'),
(497, 12000, 2, 'item', 24000, '2020-04-17 12:49:23', '2020-04-17 12:49:23', 213, 'App\\Invoice'),
(498, 12000, 2, 'item', 24000, '2020-04-17 14:21:40', '2020-04-17 14:21:40', 214, 'App\\Invoice'),
(499, 12000, 2, 'item', 24000, '2020-04-17 14:28:32', '2020-04-17 14:28:32', 215, 'App\\Invoice');

-- --------------------------------------------------------

--
-- Structure de la table `item_quote`
--

CREATE TABLE `item_quote` (
  `item_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quote_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2020_03_12_105414_add_fk_manager_id_to_customers_table', 1),
(2, '2020_03_12_111910_create_items_table', 2),
(3, '2020_03_12_114817_create_quotes_table', 3),
(5, '2020_03_13_104317_create_taxes_table', 5),
(7, '2020_03_13_151714_create_pivot_table_quote_tax', 6),
(8, '2020_03_15_153644_create_pivot_table_item_quote', 7),
(9, '2020_03_16_082632_create_information_table', 8),
(10, '2020_03_28_105618_create_pivot_table_invoice_tax', 9),
(11, '2020_03_28_105842_create_pivot_table_item_invoice', 10),
(12, '2020_03_28_161057_create_payment_methods_table', 11),
(13, '2020_03_28_204343_create_payments_table', 12),
(14, '2020_03_29_103808_create_documents_table', 13),
(15, '2020_03_29_140718_create_pivot_table_payment_document', 14),
(16, '2020_03_30_150751_add_fk_quote_to_invoices_table', 15),
(17, '2020_03_31_141624_create_credit_notes_table', 16),
(19, '2020_04_02_125514_create_invoice_recurrences_table', 17),
(20, '2020_04_02_141127_create_invoice_recurrence_dates_table', 18),
(23, '2020_04_08_082125_create_delivery_orders_table', 20),
(24, '2020_04_13_223053_create_purchase_orders_table', 21),
(25, '2020_04_14_015434_create_pivot_table_purchase_order_taxe', 22),
(26, '2020_04_16_121821_add_foreign_key_payment_method_to_invoices_table', 23),
(27, '2020_04_16_153511_add_foreign_key_parent_id_to_invoices_table', 24);

-- --------------------------------------------------------

--
-- Structure de la table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `invoice_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_method_id` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `payments`
--

INSERT INTO `payments` (`id`, `user_id`, `invoice_id`, `payment_method_id`, `amount`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, 62, 1, 26520, 'decima', '2020-04-16 15:14:10', '2020-04-16 15:14:10'),
(2, 1, 64, 2, 20000, NULL, '2020-04-16 15:24:43', '2020-04-16 15:24:43'),
(3, 1, 61, 4, 23000, NULL, '2020-04-16 15:27:32', '2020-04-16 15:27:32');

-- --------------------------------------------------------

--
-- Structure de la table `payment_methods`
--

CREATE TABLE `payment_methods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `payment_methods`
--

INSERT INTO `payment_methods` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Virement Bancaire', '2020-03-27 23:00:00', '2020-03-28 19:51:28'),
(2, 'Espèce', '2020-03-27 23:00:00', '2020-03-27 23:00:00'),
(3, 'Chèques', '2020-03-28 18:21:50', '2020-03-28 18:48:56'),
(4, 'Airtel Money', '2020-03-28 18:22:46', '2020-03-28 18:22:46'),
(5, 'Mobicash', '2020-03-28 18:22:59', '2020-03-28 18:22:59');

-- --------------------------------------------------------

--
-- Structure de la table `purchase_orders`
--

CREATE TABLE `purchase_orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `purchase_order_number` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `amount_et` double DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `amount_discount` double DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `amount_taxes` double DEFAULT NULL,
  `expire_at` date DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'draft',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `purchase_orders`
--

INSERT INTO `purchase_orders` (`id`, `user_id`, `customer_id`, `purchase_order_number`, `title`, `amount_et`, `discount`, `amount_discount`, `amount`, `amount_taxes`, `expire_at`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 17, 'BC00001', 'BC1', 205000, 0, 205000, 226525, 21525, '2020-04-14', 'rejected', '2020-04-14 02:03:34', '2020-04-14 13:10:19'),
(3, 1, 7, 'BC00003', 'BC3', 1525000, 0, 1525000, 1685125, 160125, '2020-04-14', 'canceled', '2020-04-14 02:10:33', '2020-04-14 13:03:24'),
(4, 1, 16, 'BC00004', 'Projet3', 2530000, 0, 2530000, 3251050, 721050, '2020-04-14', 'rejected', '2020-04-14 07:50:04', '2020-04-14 13:03:11'),
(5, 1, 15, 'BC00005', 'Projet4', 250000, 0, 250000, 276250, 26250, '2020-04-14', 'canceled', '2020-04-14 08:19:24', '2020-04-14 18:59:28'),
(8, 1, 11, 'BC00006', 'projet2', 1650000, 10, 1485000, 1640925, 155925, '2020-04-14', 'draft', '2020-04-14 17:22:32', '2020-04-14 17:22:32'),
(9, 1, 12, 'BC00007', 'projet2', 1650000, 10, 1485000, 1640925, 155925, '2020-04-14', 'draft', '2020-04-14 17:33:19', '2020-04-14 17:33:19'),
(10, 1, 10, 'BC00008', 'projet2', 2000000, 10, 1800000, 1989000, 189000, '2020-04-14', 'draft', '2020-04-14 17:35:41', '2020-04-14 17:35:41'),
(11, 1, 17, 'BC00009', 'Projet4', 250000, 0, 250000, 276250, 26250, '2020-04-14', 'draft', '2020-04-14 17:37:10', '2020-04-14 17:37:10'),
(12, 1, 11, 'BC00010', 'Projet4', 250000, 5, 237500, 262437.5, 24937.5, '2020-04-14', 'canceled', '2020-04-14 17:37:48', '2020-04-14 18:03:50'),
(13, 1, 11, 'BC00011', 'BC3', 1525000, 0, 1525000, 1685125, 160125, '2020-04-14', 'rejected', '2020-04-14 17:38:33', '2020-04-14 18:03:18'),
(14, 1, 16, 'BC00012', 'BC3', 1525000, 0, 1525000, 1685125, 160125, '2020-04-14', 'canceled', '2020-04-14 17:39:51', '2020-04-14 18:16:23'),
(16, 1, 7, 'BC00013', 'BC3', 1525000, 0, 1525000, 1685125, 160125, '2020-05-14', 'draft', '2020-04-14 19:03:32', '2020-04-14 19:03:32');

-- --------------------------------------------------------

--
-- Structure de la table `purchase_order_tax`
--

CREATE TABLE `purchase_order_tax` (
  `purchase_order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tax_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `purchase_order_tax`
--

INSERT INTO `purchase_order_tax` (`purchase_order_id`, `tax_id`) VALUES
(1, 3),
(1, 2),
(3, 3),
(3, 2),
(4, 1),
(4, 2),
(4, 3),
(5, 2),
(5, 3),
(8, 3),
(8, 2),
(9, 3),
(9, 2),
(10, 3),
(10, 2),
(11, 3),
(11, 2),
(12, 3),
(12, 2),
(13, 3),
(13, 2),
(14, 3),
(14, 2),
(16, 3),
(16, 2);

-- --------------------------------------------------------

--
-- Structure de la table `quotes`
--

CREATE TABLE `quotes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quote_number` varchar(50) DEFAULT NULL,
  `title` text,
  `amount_et` double DEFAULT NULL,
  `discount` float NOT NULL,
  `amount_discount` double NOT NULL,
  `amount_taxes` double DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expire_at` date DEFAULT NULL,
  `expired` tinyint(1) NOT NULL,
  `is_billed` tinyint(1) DEFAULT '0',
  `status` varchar(50) NOT NULL DEFAULT 'in_progress' COMMENT '- billed, purchased, canceled, in_progress'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `quotes`
--

INSERT INTO `quotes` (`id`, `customer_id`, `user_id`, `quote_number`, `title`, `amount_et`, `discount`, `amount_discount`, `amount_taxes`, `amount`, `created_at`, `updated_at`, `expire_at`, `expired`, `is_billed`, `status`) VALUES
(77, 17, 1, 'D000001', 'proje1', 3000, 0, 3000, 315, 3315, '2020-04-14 17:13:44', '2020-04-14 17:13:44', '2020-04-24', 0, 0, 'in_progress'),
(79, 11, 1, 'D000002', 'proje1', 32900, 0, 32900, 3454.5, 36354.5, '2020-04-14 17:20:31', '2020-04-14 17:21:01', '2020-04-24', 0, 0, 'in_progress'),
(80, 15, 1, 'D000003', 'proje1', 32900, 0, 32900, 3454.5, 36354.5, '2020-04-14 18:28:15', '2020-04-14 18:28:15', '2020-04-24', 0, 0, 'in_progress');

-- --------------------------------------------------------

--
-- Structure de la table `quote_tax`
--

CREATE TABLE `quote_tax` (
  `quote_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tax_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `quote_tax`
--

INSERT INTO `quote_tax` (`quote_id`, `tax_id`) VALUES
(77, 3),
(77, 2),
(79, 2),
(79, 3),
(80, 3),
(80, 2);

-- --------------------------------------------------------

--
-- Structure de la table `taxes`
--

CREATE TABLE `taxes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `value` double(8,2) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `enabled` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `taxes`
--

INSERT INTO `taxes` (`id`, `value`, `name`, `description`, `enabled`, `created_at`, `updated_at`) VALUES
(1, 18.00, 'TVA', 'Taxe sur la valeur ajoutee', 0, NULL, '2020-03-14 16:20:15'),
(2, 9.50, 'TPS', 'Taxe sur la prestation de service', 1, NULL, NULL),
(3, 1.00, 'CSS', 'Contribution sociale', 1, NULL, '2020-03-14 16:20:40');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `api_token` varchar(80) DEFAULT NULL,
  `phonenumber` varchar(255) DEFAULT NULL,
  `fonction` varchar(100) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `name`, `firstname`, `email`, `email_verified_at`, `status`, `api_token`, `phonenumber`, `fonction`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin', '$2y$10$HldFclaC8sYLuWc3ivXzhON3r3gomEr0lsH68RXgXR57TZbbpF.Kq', 'admin', 'ndong otogue', 'yvon paul brice', 'yvon.ndong@neosystechnologie.ga', NULL, 1, 'YohhwmRBDFpH0tkE9J6WN0Xt3ublYMPm3yLpe6HVfzj2qodPqc2s5Y5CFez9pHnIx4UtkPkQkSAMQxOo', NULL, 'Directeur Technique', 'n6BQccBDbQ6dCC4vPkWrsgntdoj33n6dtTxMZcVQgsGkM06ek2O6Ob1eEmEt', '2019-11-25 17:08:52', '2020-04-17 10:03:58'),
(25, 'donald.kombila', '$2y$10$BLIM5l7xorL1YseDT8G4IO0R/ZAxQcuOwjfEeGIANZJ8jz.sVbGrm', 'manager', 'kombila ekang', 'donald', 'donald.kombila@aninf.ga', NULL, 1, 'VIr6jjT5nkTYdt8akqL6CjjMoj0Z7VLL1hF3cgbrgOVLxu6Xqm3D5tNkmGTKD84WdNARqeyc2KZelhSK', NULL, NULL, NULL, '2020-03-11 11:36:34', '2020-04-16 23:33:15'),
(27, 'aude.missevou', '$2y$10$khqb5RaUp.wAejYgspCOnegyhHh9THIzma3egsqFFLkOS6xVX3iGW', 'manager', 'missevou', 'aude cheryle', 'aude.missevou@neosystechnologie.ga', NULL, 1, '09Uo4A6hDtueB5pr8muT6mWs2I7zrc3zcRuqfWw229eOpivbpcigvFeAJARHCar4v43gjQQzpQKa5BA0', NULL, NULL, NULL, '2020-03-12 07:59:38', '2020-03-12 07:59:38'),
(28, 'angela.omvogh', '$2y$10$oyVX8xGXT46J6rz8N5MfAOD6sDosoIARjdUKp80nLVuyxWjFZbrmC', 'manager', 'OMVOGHE ALLOGHO', 'Angela', 'angela.omvoghe@neosystechnologie.ga', NULL, 1, 'rWM8TQkP4mdbdvfcbvK4LSXON8ys9g1IuKegJ8jxrv7sIfqgPBjmDFrPAOba72R3TxXcIsRGGkgJvMxn', '+24162227975', 'Secrétaire de Direction', NULL, '2020-03-30 22:47:12', '2020-03-30 22:47:12');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `credit_notes`
--
ALTER TABLE `credit_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `credit_notes_invoice_id_index` (`invoice_id`),
  ADD KEY `credit_notes_user_id_index` (`user_id`);

--
-- Index pour la table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customers_manager_id_index` (`manager_id`);

--
-- Index pour la table `delivery_orders`
--
ALTER TABLE `delivery_orders`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `document_payment`
--
ALTER TABLE `document_payment`
  ADD KEY `payment_document_payment_id_index` (`payment_id`),
  ADD KEY `payment_document_document_id_index` (`document_id`);

--
-- Index pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `information`
--
ALTER TABLE `information`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `invoices_parent_id_unique` (`parent_id`),
  ADD KEY `invoices_user_id_index` (`user_id`),
  ADD KEY `invoices_customer_id_index` (`customer_id`),
  ADD KEY `invoices_payment_method_id_index` (`payment_method_id`),
  ADD KEY `invoices_parent_id_index` (`parent_id`);

--
-- Index pour la table `invoice_item`
--
ALTER TABLE `invoice_item`
  ADD KEY `item_invoice_item_id_index` (`item_id`),
  ADD KEY `item_invoice_invoice_id_index` (`invoice_id`);

--
-- Index pour la table `invoice_recurrences`
--
ALTER TABLE `invoice_recurrences`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_recurrence_invoice_id_index` (`invoice_id`),
  ADD KEY `invoice_recurrence_user_id_index` (`user_id`);

--
-- Index pour la table `invoice_recurrence_dates`
--
ALTER TABLE `invoice_recurrence_dates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_recurrence_date_invoice_recurrence_id_index` (`invoice_recurrence_id`);

--
-- Index pour la table `invoice_tax`
--
ALTER TABLE `invoice_tax`
  ADD KEY `invoice_tax_invoice_id_index` (`invoice_id`),
  ADD KEY `invoice_tax_tax_id_index` (`tax_id`);

--
-- Index pour la table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `item_quote`
--
ALTER TABLE `item_quote`
  ADD KEY `item_quote_item_id_index` (`item_id`),
  ADD KEY `item_quote_quote_id_index` (`quote_id`);

--
-- Index pour la table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Index pour la table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_user_id_index` (`user_id`),
  ADD KEY `payments_invoice_id_index` (`invoice_id`),
  ADD KEY `payments_payment_method_id_index` (`payment_method_id`);

--
-- Index pour la table `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `payment_methods_name_unique` (`name`);

--
-- Index pour la table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `purchase_orders_purchase_order_number_unique` (`purchase_order_number`),
  ADD KEY `purchase_orders_user_id_index` (`user_id`),
  ADD KEY `purchase_orders_customer_id_index` (`customer_id`);

--
-- Index pour la table `purchase_order_tax`
--
ALTER TABLE `purchase_order_tax`
  ADD KEY `purchase_order_tax_purchase_order_id_index` (`purchase_order_id`),
  ADD KEY `purchase_order_tax_tax_id_index` (`tax_id`);

--
-- Index pour la table `quotes`
--
ALTER TABLE `quotes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `quote_number` (`quote_number`),
  ADD KEY `quotes_user_id_index` (`user_id`),
  ADD KEY `quotes_customer_id_index` (`customer_id`);

--
-- Index pour la table `quote_tax`
--
ALTER TABLE `quote_tax`
  ADD KEY `quote_tax_quote_id_index` (`quote_id`),
  ADD KEY `quote_tax_tax_id_index` (`tax_id`);

--
-- Index pour la table `taxes`
--
ALTER TABLE `taxes`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_api_token_unique` (`api_token`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `credit_notes`
--
ALTER TABLE `credit_notes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT pour la table `delivery_orders`
--
ALTER TABLE `delivery_orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `information`
--
ALTER TABLE `information`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=216;

--
-- AUTO_INCREMENT pour la table `invoice_recurrences`
--
ALTER TABLE `invoice_recurrences`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `invoice_recurrence_dates`
--
ALTER TABLE `invoice_recurrence_dates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `items`
--
ALTER TABLE `items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=500;

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT pour la table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `quotes`
--
ALTER TABLE `quotes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT pour la table `taxes`
--
ALTER TABLE `taxes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `credit_notes`
--
ALTER TABLE `credit_notes`
  ADD CONSTRAINT `credit_notes_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `credit_notes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_manager_id_foreign` FOREIGN KEY (`manager_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Contraintes pour la table `document_payment`
--
ALTER TABLE `document_payment`
  ADD CONSTRAINT `payment_document_document_id_foreign` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payment_document_payment_id_foreign` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `invoices_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `invoices_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `invoices` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `invoices_payment_method_id_foreign` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `invoices_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Contraintes pour la table `invoice_item`
--
ALTER TABLE `invoice_item`
  ADD CONSTRAINT `item_invoice_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `item_invoice_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `invoice_recurrences`
--
ALTER TABLE `invoice_recurrences`
  ADD CONSTRAINT `invoice_recurrence_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoice_recurrence_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `invoice_recurrence_dates`
--
ALTER TABLE `invoice_recurrence_dates`
  ADD CONSTRAINT `invoice_recurrence_date_invoice_recurrence_id_foreign` FOREIGN KEY (`invoice_recurrence_id`) REFERENCES `invoice_recurrences` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `invoice_tax`
--
ALTER TABLE `invoice_tax`
  ADD CONSTRAINT `invoice_tax_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoice_tax_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `item_quote`
--
ALTER TABLE `item_quote`
  ADD CONSTRAINT `item_quote_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `item_quote_quote_id_foreign` FOREIGN KEY (`quote_id`) REFERENCES `quotes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_payment_method_id_foreign` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD CONSTRAINT `purchase_orders_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `purchase_orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `purchase_order_tax`
--
ALTER TABLE `purchase_order_tax`
  ADD CONSTRAINT `purchase_order_tax_purchase_order_id_foreign` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `purchase_order_tax_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `quotes`
--
ALTER TABLE `quotes`
  ADD CONSTRAINT `quotes_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `quotes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Contraintes pour la table `quote_tax`
--
ALTER TABLE `quote_tax`
  ADD CONSTRAINT `quote_tax_quote_id_foreign` FOREIGN KEY (`quote_id`) REFERENCES `quotes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `quote_tax_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

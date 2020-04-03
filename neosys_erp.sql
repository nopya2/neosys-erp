-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  ven. 03 avr. 2020 à 02:08
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

--
-- Déchargement des données de la table `credit_notes`
--

INSERT INTO `credit_notes` (`id`, `invoice_id`, `user_id`, `credit_note_number`, `type`, `amount`, `percent_discount`, `amount_discount`, `created_at`, `updated_at`) VALUES
(8, 34, 1, '000006', 3, 50000, 0, 0, '2020-04-02 09:47:04', '2020-04-02 09:47:04'),
(9, 32, 1, '000007', 1, 1900600, 20, 0, '2020-04-02 11:41:03', '2020-04-02 11:41:03'),
(10, 32, 1, '000008', 2, 2375750, 0, 0, '2020-04-02 11:43:09', '2020-04-02 11:43:09');

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
(13, 'Autre', '+24100000000', 'other@other.other', 'Autre', 'Gabon', 'Libreville', 'Everywhere', NULL, NULL, '2020-04-02 08:44:02', '2020-04-02 08:44:02', 1);

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `information`
--

INSERT INTO `information` (`id`, `social_reason`, `logo`, `address`, `phone1`, `phone2`, `email`, `country`, `city`, `bp`, `website`, `check_payable_to`, `transfer_to_account`, `code_bank`, `counter_code`, `account_number`, `rib_key`, `footer`, `header`, `quote_delay`, `invoice_delay`, `created_at`, `updated_at`) VALUES
(1, 'Neosys Technologie S.A.R.L', 'logo.png', 'Ancienne SOBRAGA, en face de Multipresse/L\'UNION', '+241077454754', '+24166215333', 'infos@neosystechnologie.ga', 'Gabon', 'Libreville', NULL, 'https://neosystechnologie.ga', 'NEOSYS TECHNOLOGIE', 'BGFI  LOXIA N° 00165258211', '4003', '04100', '71008865012', '88', '<p><strong>NeoSys Technologies SARL</strong></p><p>Intégrateur des solutions informatiques</p><p>Audits - Conseils -Formations - Infogérance - Sécurité - Système et Réseaux</p><p>RCCM : 2014B18489 - NIF : 037719G – STAT. : 086847A</p><p>Tel : (+241) 07454754 - Email : infos@neosystechologie.ga</p>', NULL, 30, 15, '2020-03-16 08:45:00', '2020-03-29 18:49:26');

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
  `expired` tinyint(1) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `quote_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `invoices`
--

INSERT INTO `invoices` (`id`, `customer_id`, `user_id`, `invoice_number`, `title`, `amount_et`, `discount`, `amount_discount`, `amount_taxes`, `amount`, `created_at`, `updated_at`, `expire_at`, `expired`, `status`, `quote_id`) VALUES
(31, 9, 1, '000001', 'Mise en oeuvre site institutionnel', 1650000, 5, 1567500, 164587.5, 1732087.5, '2020-03-31 23:00:00', '2020-04-01 20:52:21', NULL, 0, 0, 21),
(32, 1, 1, '000002', 'Mise a jour ERP', 2150000, 0, 2150000, 225750, 2375750, '2020-04-01 23:00:00', '2020-04-02 08:25:45', NULL, 0, 1, 26),
(33, 7, 1, '000003', 'EDAN', 10000, 0, 10000, 1050, 11050, '2020-04-01 23:00:00', '2020-04-02 08:27:37', NULL, 0, 1, NULL),
(34, 2, 1, '000004', 'Contrat de Maintenance Application de GES COWORKING', 50000, 0, 50000, 0, 50000, '2020-03-01 23:00:00', '2020-03-02 08:30:59', NULL, 0, 1, NULL),
(35, 13, 1, '000005', 'Airtel Money', 10000, 0, 10000, 0, 10000, '2020-03-01 23:00:00', '2020-03-02 08:48:00', NULL, 0, 1, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `invoice_item`
--

CREATE TABLE `invoice_item` (
  `item_id` bigint(20) UNSIGNED DEFAULT NULL,
  `invoice_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `invoice_item`
--

INSERT INTO `invoice_item` (`item_id`, `invoice_id`) VALUES
(162, 31),
(163, 31),
(164, 31),
(165, 31),
(169, 32),
(170, 32),
(171, 33),
(172, 34),
(173, 35);

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

--
-- Déchargement des données de la table `invoice_recurrences`
--

INSERT INTO `invoice_recurrences` (`id`, `user_id`, `invoice_id`, `start_date`, `end_date`, `period`, `occurence`, `created_at`, `updated_at`) VALUES
(8, 1, 34, '2021-01-18 00:42:00', '2023-01-18 00:42:00', '12', 3, '2020-04-02 23:42:55', '2020-04-02 23:42:55');

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

--
-- Déchargement des données de la table `invoice_recurrence_dates`
--

INSERT INTO `invoice_recurrence_dates` (`id`, `invoice_recurrence_id`, `date`, `created_at`, `updated_at`) VALUES
(10, 8, '2021-01-18 00:42:00', '2020-04-02 23:42:55', '2020-04-02 23:42:55'),
(11, 8, '2022-01-18 00:42:00', '2020-04-02 23:42:55', '2020-04-02 23:42:55'),
(12, 8, '2023-01-18 00:42:00', '2020-04-02 23:42:55', '2020-04-02 23:42:55');

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
(31, 2),
(31, 3),
(32, 2),
(32, 3),
(33, 2),
(33, 3);

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
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `items`
--

INSERT INTO `items` (`id`, `pu`, `qty`, `label`, `amount`, `created_at`, `updated_at`) VALUES
(95, 1000000, 1, 'Developpement et mise en production du site web', 1000000, '2020-04-01 16:02:22', '2020-04-01 16:02:22'),
(96, 200000, 1, 'Hébergement du site web (Serveur dedié VPS / 1 AN)', 200000, '2020-04-01 16:02:23', '2020-04-01 16:02:23'),
(97, 100000, 3, 'Formation de l\'administrateur', 300000, '2020-04-01 16:02:23', '2020-04-01 16:02:23'),
(98, 150000, 1, 'Maintenance 1 AN', 150000, '2020-04-01 16:02:23', '2020-04-01 16:02:23'),
(99, 2500000, 1, 'Developpement et mise en production de l\'application', 2500000, '2020-04-01 16:15:55', '2020-04-01 16:15:55'),
(100, 150000, 1, 'Hébergement du site web (Serveur dedié VPS / 1 AN)\n- Nom de domaine\n- Adresses mails personnalises', 150000, '2020-04-01 16:15:55', '2020-04-01 16:15:55'),
(101, 150000, 3, 'Formation de l\'administrateur', 450000, '2020-04-01 16:15:55', '2020-04-01 16:15:55'),
(102, 100000, 1, 'Maintenance 1 AN', 100000, '2020-04-01 16:15:55', '2020-04-01 16:15:55'),
(103, 3000000, 1, 'Developpement et mise en production du site web', 3000000, '2020-04-01 16:30:07', '2020-04-01 16:30:07'),
(104, 500000, 1, 'Hébergement du site web (Serveur dedié VPS / 1 AN)', 500000, '2020-04-01 16:30:07', '2020-04-01 16:30:07'),
(105, 150000, 3, 'Formation de l\'administrateur', 450000, '2020-04-01 16:30:07', '2020-04-01 16:30:07'),
(106, 250000, 1, 'Maintenance 1 AN', 250000, '2020-04-01 16:30:07', '2020-04-01 16:30:07'),
(107, 4500, 20, 'Rames de papier A4', 90000, '2020-04-01 16:46:35', '2020-04-01 16:46:35'),
(108, 11000, 15, 'Rame filigrane Clairefontaine', 165000, '2020-04-01 16:46:35', '2020-04-01 16:46:35'),
(109, 1500, 15, 'Bloc Note A4', 22500, '2020-04-01 16:46:35', '2020-04-01 16:46:35'),
(110, 1000, 24, 'Blancos (2 paquets de 12)', 24000, '2020-04-01 16:46:36', '2020-04-01 16:46:36'),
(111, 500, 20, 'Taille crayon (2 paquets de 12)', 10000, '2020-04-01 16:46:36', '2020-04-01 16:46:36'),
(112, 500, 28, 'Post-it', 14000, '2020-04-01 16:46:36', '2020-04-01 16:46:36'),
(113, 200, 180, 'Style INKJOY', 36000, '2020-04-01 16:46:36', '2020-04-01 16:46:36'),
(114, 150, 500, 'Sous chemise (2 paquets de 250)', 75000, '2020-04-01 16:46:36', '2020-04-01 16:46:36'),
(115, 300, 100, 'Enveloppe Kaki A4 (2 paquets de 50)', 30000, '2020-04-01 16:46:36', '2020-04-01 16:46:36'),
(116, 500, 100, 'Enveloppe Kaki A3 (2 paquets de 50)', 50000, '2020-04-01 16:46:36', '2020-04-01 16:46:36'),
(117, 1000, 40, 'Chemise cartonnée avec élastique', 40000, '2020-04-01 16:46:36', '2020-04-01 16:46:36'),
(118, 1000, 10, 'Bloc Note A5', 10000, '2020-04-01 16:46:36', '2020-04-01 16:46:36'),
(119, 1000, 30, 'Classeurs de rangement', 30000, '2020-04-01 16:46:36', '2020-04-01 16:46:36'),
(120, 125, 72, 'Crayon ordinaire(6 paquets de 12)', 9000, '2020-04-01 16:46:36', '2020-04-01 16:46:36'),
(121, 1000, 72, 'Colle 5020 (2 paquets de 36)', 72000, '2020-04-01 16:46:37', '2020-04-01 16:46:37'),
(122, 1200, 6, 'Règles', 7200, '2020-04-01 16:46:37', '2020-04-01 16:46:37'),
(123, 200, 200, 'Chemise cartonnée(2 paquets de 100)', 40000, '2020-04-01 16:46:37', '2020-04-01 16:46:37'),
(124, 4500, 20, 'Rames de papier A4', 90000, '2020-04-01 18:58:53', '2020-04-01 18:58:53'),
(125, 11000, 15, 'Rame filigrane Clairefontaine', 165000, '2020-04-01 18:58:53', '2020-04-01 18:58:53'),
(126, 1500, 15, 'Bloc Note A4', 22500, '2020-04-01 18:58:53', '2020-04-01 18:58:53'),
(127, 1000, 24, 'Blancos (2 paquets de 12)', 24000, '2020-04-01 18:58:53', '2020-04-01 18:58:53'),
(128, 500, 20, 'Taille crayon (2 paquets de 12)', 10000, '2020-04-01 18:58:53', '2020-04-01 18:58:53'),
(129, 500, 28, 'Post-it', 14000, '2020-04-01 18:58:53', '2020-04-01 18:58:53'),
(130, 200, 180, 'Style INKJOY', 36000, '2020-04-01 18:58:53', '2020-04-01 18:58:53'),
(131, 150, 500, 'Sous chemise (2 paquets de 250)', 75000, '2020-04-01 18:58:53', '2020-04-01 18:58:53'),
(132, 300, 100, 'Enveloppe Kaki A4 (2 paquets de 50)', 30000, '2020-04-01 18:58:53', '2020-04-01 18:58:53'),
(133, 500, 100, 'Enveloppe Kaki A3 (2 paquets de 50)', 50000, '2020-04-01 18:58:53', '2020-04-01 18:58:53'),
(134, 1000, 40, 'Chemise cartonnée avec élastique', 40000, '2020-04-01 18:58:53', '2020-04-01 18:58:53'),
(135, 1000, 10, 'Bloc Note A5', 10000, '2020-04-01 18:58:53', '2020-04-01 18:58:53'),
(136, 1000, 30, 'Classeurs de rangement', 30000, '2020-04-01 18:58:53', '2020-04-01 18:58:53'),
(137, 125, 72, 'Crayon ordinaire(6 paquets de 12)', 9000, '2020-04-01 18:58:53', '2020-04-01 18:58:53'),
(138, 1000, 72, 'Colle 5020 (2 paquets de 36)', 72000, '2020-04-01 18:58:54', '2020-04-01 18:58:54'),
(139, 1200, 6, 'Règles', 7200, '2020-04-01 18:58:54', '2020-04-01 18:58:54'),
(140, 200, 200, 'Chemise cartonnée(2 paquets de 100)', 40000, '2020-04-01 18:58:54', '2020-04-01 18:58:54'),
(141, 2500000, 1, 'Developpement et mise en production de l\'application', 2500000, '2020-04-01 19:14:04', '2020-04-01 19:14:04'),
(142, 150000, 1, 'Hébergement du site web (Serveur dedié VPS / 1 AN)\n- Nom de domaine\n- Adresses mails personnalises', 150000, '2020-04-01 19:14:05', '2020-04-01 19:14:05'),
(143, 150000, 3, 'Formation de l\'administrateur', 450000, '2020-04-01 19:14:05', '2020-04-01 19:14:05'),
(144, 100000, 1, 'Maintenance 1 AN', 100000, '2020-04-01 19:14:05', '2020-04-01 19:14:05'),
(145, 4500, 20, 'Rames de papier A4', 90000, '2020-04-01 19:33:01', '2020-04-01 19:33:01'),
(146, 11000, 15, 'Rame filigrane Clairefontaine', 165000, '2020-04-01 19:33:01', '2020-04-01 19:33:01'),
(147, 1500, 15, 'Bloc Note A4', 22500, '2020-04-01 19:33:01', '2020-04-01 19:33:01'),
(148, 1000, 24, 'Blancos (2 paquets de 12)', 24000, '2020-04-01 19:33:01', '2020-04-01 19:33:01'),
(149, 500, 20, 'Taille crayon (2 paquets de 12)', 10000, '2020-04-01 19:33:01', '2020-04-01 19:33:01'),
(150, 500, 28, 'Post-it', 14000, '2020-04-01 19:33:01', '2020-04-01 19:33:01'),
(151, 200, 180, 'Style INKJOY', 36000, '2020-04-01 19:33:01', '2020-04-01 19:33:01'),
(152, 150, 500, 'Sous chemise (2 paquets de 250)', 75000, '2020-04-01 19:33:02', '2020-04-01 19:33:02'),
(153, 300, 100, 'Enveloppe Kaki A4 (2 paquets de 50)', 30000, '2020-04-01 19:33:02', '2020-04-01 19:33:02'),
(154, 500, 100, 'Enveloppe Kaki A3 (2 paquets de 50)', 50000, '2020-04-01 19:33:02', '2020-04-01 19:33:02'),
(155, 1000, 40, 'Chemise cartonnée avec élastique', 40000, '2020-04-01 19:33:02', '2020-04-01 19:33:02'),
(156, 1000, 10, 'Bloc Note A5', 10000, '2020-04-01 19:33:02', '2020-04-01 19:33:02'),
(157, 1000, 30, 'Classeurs de rangement', 30000, '2020-04-01 19:33:02', '2020-04-01 19:33:02'),
(158, 125, 72, 'Crayon ordinaire(6 paquets de 12)', 9000, '2020-04-01 19:33:02', '2020-04-01 19:33:02'),
(159, 1000, 72, 'Colle 5020 (2 paquets de 36)', 72000, '2020-04-01 19:33:02', '2020-04-01 19:33:02'),
(160, 1200, 6, 'Règles', 7200, '2020-04-01 19:33:02', '2020-04-01 19:33:02'),
(161, 200, 200, 'Chemise cartonnée(2 paquets de 100)', 40000, '2020-04-01 19:33:02', '2020-04-01 19:33:02'),
(162, 1000000, 1, 'Developpement et mise en production du site web', 1000000, '2020-04-01 20:52:06', '2020-04-01 20:52:06'),
(163, 200000, 1, 'Hébergement du site web (Serveur dedié VPS / 1 AN)', 200000, '2020-04-01 20:52:06', '2020-04-01 20:52:06'),
(164, 100000, 3, 'Formation de l\'administrateur', 300000, '2020-04-01 20:52:06', '2020-04-01 20:52:06'),
(165, 150000, 1, 'Maintenance 1 AN', 150000, '2020-04-01 20:52:06', '2020-04-01 20:52:06'),
(166, 500000, 1, 'Item1', 500000, '2020-04-02 08:07:11', '2020-04-02 08:07:11'),
(167, 2000000, 1, 'Item1', 2000000, '2020-04-02 08:12:39', '2020-04-02 08:12:39'),
(168, 150000, 1, 'Item2', 150000, '2020-04-02 08:12:39', '2020-04-02 08:12:39'),
(169, 2000000, 1, 'Item1', 2000000, '2020-04-02 08:25:31', '2020-04-02 08:25:31'),
(170, 150000, 1, 'Item2', 150000, '2020-04-02 08:25:31', '2020-04-02 08:25:31'),
(171, 10000, 1, 'Paiment Ticket EDAN', 10000, '2020-04-02 08:27:24', '2020-04-02 08:27:24'),
(172, 50000, 1, 'Hébergement mensuel Application', 50000, '2020-04-02 08:30:27', '2020-04-02 08:30:27'),
(173, 10000, 1, 'Depot', 10000, '2020-04-02 08:47:43', '2020-04-02 08:47:43');

-- --------------------------------------------------------

--
-- Structure de la table `item_quote`
--

CREATE TABLE `item_quote` (
  `item_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quote_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `item_quote`
--

INSERT INTO `item_quote` (`item_id`, `quote_id`) VALUES
(99, 22),
(100, 22),
(101, 22),
(102, 22),
(95, 21),
(96, 21),
(97, 21),
(98, 21),
(103, 23),
(104, 23),
(105, 23),
(106, 23),
(107, 24),
(108, 24),
(109, 24),
(110, 24),
(111, 24),
(112, 24),
(113, 24),
(114, 24),
(115, 24),
(116, 24),
(117, 24),
(118, 24),
(119, 24),
(120, 24),
(121, 24),
(122, 24),
(123, 24),
(166, 25),
(167, 26),
(168, 26);

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
(18, '2020_04_01_164554_create_purchase_orders_table', 17),
(19, '2020_04_02_125514_create_invoice_recurrences_table', 17),
(20, '2020_04_02_141127_create_invoice_recurrence_dates_table', 18);

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
(15, 1, 33, 2, 11050, NULL, '2020-04-02 08:28:37', '2020-04-02 08:28:37'),
(16, 1, 35, 2, 10000, NULL, '2020-04-02 08:48:26', '2020-04-02 08:48:26'),
(17, 1, 34, 2, 50000, NULL, '2020-04-02 21:05:07', '2020-04-02 21:05:07');

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `is_billed` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `quotes`
--

INSERT INTO `quotes` (`id`, `customer_id`, `user_id`, `quote_number`, `title`, `amount_et`, `discount`, `amount_discount`, `amount_taxes`, `amount`, `created_at`, `updated_at`, `expire_at`, `expired`, `is_billed`) VALUES
(21, 9, 1, '000001', 'Mise en oeuvre site institutionnel', 1650000, 5, 1567500, 164587.5, 1732087.5, '2020-04-30 23:00:00', '2020-04-01 20:52:06', '2020-05-01', 0, 1),
(22, 10, 1, '000002', 'Logiciel de gestion scolaire', 3200000, 5, 3040000, 319200, 3359200, '2019-09-21 23:00:00', '2019-09-22 19:14:05', '2020-05-01', 0, 0),
(23, 11, 1, '000003', 'Site web institutionnel', 4200000, 5, 3990000, 418950, 4408950, '2019-03-27 23:00:00', '2019-03-28 16:30:07', '2020-05-01', 0, 0),
(24, 12, 1, '000004', 'Fourniture de bureau', 724700, 0, 724700, 76093.5, 800793.5, '2019-09-23 23:00:00', '2019-09-24 18:58:54', '2020-05-01', 0, 0),
(25, 11, 1, '000005', 'Audit site web', 500000, 0, 500000, 52500, 552500, '2020-04-01 23:00:00', '2020-04-02 08:07:11', '2020-05-02', 0, 0),
(26, 1, 1, '000006', 'Mise a jour ERP', 2150000, 0, 2150000, 225750, 2375750, '2020-04-02 08:12:39', '2020-04-02 08:25:32', '2020-05-02', 0, 1);

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
(22, 3),
(22, 2),
(21, 2),
(21, 3),
(23, 3),
(23, 2),
(24, 3),
(24, 2),
(25, 3),
(25, 2),
(26, 3),
(26, 2);

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
(1, 'admin', '$2y$10$HldFclaC8sYLuWc3ivXzhON3r3gomEr0lsH68RXgXR57TZbbpF.Kq', 'admin', 'ndong otogue', 'yvon paul brice', 'yvon.ndong@neosystechnologie.ga', NULL, 1, 'MM374gMYF0j8vOv1WCcDX72G5F71XWrsd39zsmXwgfekXR60DToIjR346CTeHJLug9XfVuGJvM12naIJ', NULL, 'Directeur Technique', 'RRQcO2Q07ATMwRWNdGrR5cTsEYTOC0ZMqVtZ7vAQcNoizCwldS2w1kc0WVfh', '2019-11-25 17:08:52', '2020-03-30 22:51:35'),
(25, 'donald.kombila', '$2y$10$w8E.0t/zRYJ7a12LV0gGe.8Tp1All9voVrmRtAmaIpWX0kJsqVyLu', 'manager', 'kombila ekang', 'donald', 'donald.kombila@aninf.ga', NULL, 1, 'Fjnm7UvxpyZo4lBHLYARnTWefNn8ZuNNZ1jwcofWkLuVwW4BOyL1LGvpo9VhL4LH5Tju8U44bK0BhMCN', NULL, NULL, NULL, '2020-03-11 11:36:34', '2020-03-30 22:47:56'),
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
  ADD KEY `invoices_user_id_index` (`user_id`),
  ADD KEY `invoices_customer_id_index` (`customer_id`),
  ADD KEY `invoices_quote_id_index` (`quote_id`);

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
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `quotes`
--
ALTER TABLE `quotes`
  ADD PRIMARY KEY (`id`),
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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT pour la table `invoice_recurrences`
--
ALTER TABLE `invoice_recurrences`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `invoice_recurrence_dates`
--
ALTER TABLE `invoice_recurrence_dates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `items`
--
ALTER TABLE `items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=174;

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT pour la table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT pour la table `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `quotes`
--
ALTER TABLE `quotes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

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
  ADD CONSTRAINT `invoices_quote_id_foreign` FOREIGN KEY (`quote_id`) REFERENCES `quotes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
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

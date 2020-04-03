-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  mer. 05 fév. 2020 à 16:00
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

-- --------------------------------------------------------

--
-- Structure de la table `accounts`
--

CREATE TABLE `accounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `account_number` int(11) DEFAULT NULL,
  `expired_at` datetime DEFAULT NULL,
  `remaining_storage` float DEFAULT NULL,
  `max_users` int(11) DEFAULT NULL,
  `max_folders` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `accounts`
--

INSERT INTO `accounts` (`id`, `customer_id`, `account_number`, `expired_at`, `remaining_storage`, `max_users`, `max_folders`, `created_at`, `updated_at`) VALUES
(1, 5, 2015915939, NULL, 0, NULL, NULL, '2020-01-13 10:36:27', '2020-01-13 10:36:27'),
(2, 6, 2015915936, NULL, 0, NULL, NULL, '2020-01-13 10:45:36', '2020-01-13 10:45:36'),
(7, 3, 2015915938, NULL, 0, NULL, NULL, '2020-01-13 10:36:27', '2020-01-13 10:36:27'),
(8, 1, 2015915937, NULL, -1, NULL, NULL, '2020-01-13 10:45:36', '2020-01-13 10:45:36'),
(9, 2, 2015915940, NULL, 0, NULL, NULL, '2020-01-13 10:36:27', '2020-01-13 10:36:27');

-- --------------------------------------------------------

--
-- Structure de la table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `manager_id` bigint(20) UNSIGNED DEFAULT NULL,
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
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `customers`
--

INSERT INTO `customers` (`id`, `manager_id`, `company_name`, `phonenumber`, `email`, `activity`, `country`, `city`, `address`, `website`, `bp`, `created_at`, `updated_at`) VALUES
(1, 1, 'Neosys Technologie SARL', '+24177454754', 'yvon.ndong@neosystechnologie.ga', 'Informatique / Télécoms', 'Gabon', 'Oyem', 'Ancienne SOBRAGE', NULL, '0000', '2019-12-23 23:00:00', '2020-01-14 10:41:26'),
(2, 14, 'Workin Art', '066856011', 'infos@workinart.ga', 'Art & Culture', 'Gabon', 'Nkan', 'Ancienne SOBRAGA', NULL, NULL, NULL, '2020-01-14 10:43:54'),
(3, 1, 'ANINF', '+241056985', 'nopya2@gmail.com', '', 'Gabon', 'Libreville', '798', NULL, NULL, '2020-01-12 14:39:43', '2020-01-12 14:39:43'),
(5, 1, 'Entreprise 1', '+24156987458', 'entreprise1@yahoo.fr', 'Études & conseils', 'Gabon', 'Franceville', 'Potos', NULL, NULL, '2020-01-13 10:36:27', '2020-01-13 10:36:27'),
(6, 15, 'Entreprise 2', '+24100589875', 'entreprise2@yahoo.fr', 'Électronique / Électricité', 'Gabon', 'Moanda', 'Place de l\'independance', NULL, NULL, '2020-01-13 10:45:36', '2020-01-13 10:45:36');

-- --------------------------------------------------------

--
-- Structure de la table `departements`
--

CREATE TABLE `departements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nom` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `entreprise_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `departements`
--

INSERT INTO `departements` (`id`, `nom`, `created_at`, `updated_at`, `entreprise_id`) VALUES
(1, 'Ressources Humaines', '2019-11-24 23:00:00', '2019-11-24 23:00:00', 1),
(2, 'Direction Generale', '2019-11-24 23:00:00', '2019-11-24 23:00:00', 1),
(3, 'Direction Technique', '2019-11-24 23:00:00', '2019-11-24 23:00:00', 1);

-- --------------------------------------------------------

--
-- Structure de la table `entreprises`
--

CREATE TABLE `entreprises` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `nom` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `entreprises`
--

INSERT INTO `entreprises` (`id`, `created_at`, `updated_at`, `nom`) VALUES
(1, '2019-11-24 23:00:00', '2019-11-24 23:00:00', 'Neosys Technologie');

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
-- Structure de la table `folders`
--

CREATE TABLE `folders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `color` varchar(255) NOT NULL DEFAULT '5F6368',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `folders`
--

INSERT INTO `folders` (`id`, `customer_id`, `created_by`, `updated_by`, `name`, `slug`, `color`, `created_at`, `updated_at`) VALUES
(26, 1, 1, NULL, 'NEOSYS', 'neosys', '#0000ff', '2020-01-17 10:38:43', '2020-01-17 10:38:43'),
(27, 1, 1, NULL, 'EGABON', 'egabon', '#ff0000', '2020-01-26 11:03:28', '2020-01-26 11:03:28'),
(28, 1, 1, NULL, 'TESTS', 'tests', '#ffff00', '2020-01-26 11:21:02', '2020-01-26 12:35:33');

-- --------------------------------------------------------

--
-- Structure de la table `folder_events`
--

CREATE TABLE `folder_events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `folder_id` bigint(20) UNSIGNED DEFAULT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `folder_events`
--

INSERT INTO `folder_events` (`id`, `user_id`, `folder_id`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 'Création du dossier', '2020-01-17 08:33:13', '2020-01-17 08:33:13'),
(2, 1, NULL, 'Modification du dossier', '2020-01-17 08:35:08', '2020-01-17 08:35:08'),
(3, 1, NULL, 'Création du dossier', '2020-01-17 09:06:57', '2020-01-17 09:06:57'),
(4, 1, NULL, 'Création du dossier', '2020-01-17 09:07:34', '2020-01-17 09:07:34'),
(5, 1, NULL, 'Modification du dossier', '2020-01-17 09:07:59', '2020-01-17 09:07:59'),
(6, 1, NULL, 'Création du dossier', '2020-01-17 09:20:39', '2020-01-17 09:20:39'),
(7, 1, NULL, 'Création du dossier', '2020-01-17 10:07:27', '2020-01-17 10:07:27'),
(8, 1, NULL, 'Création du dossier', '2020-01-17 10:19:26', '2020-01-17 10:19:26'),
(9, 1, NULL, 'Création du dossier', '2020-01-17 10:20:10', '2020-01-17 10:20:10'),
(10, 1, NULL, 'Création du dossier', '2020-01-17 10:21:06', '2020-01-17 10:21:06'),
(11, 1, NULL, 'Création du dossier', '2020-01-17 10:21:56', '2020-01-17 10:21:56'),
(12, 1, NULL, 'Création du dossier', '2020-01-17 10:26:35', '2020-01-17 10:26:35'),
(13, 1, 26, 'Création du dossier', '2020-01-17 10:38:43', '2020-01-17 10:38:43'),
(14, 1, 27, 'Création du dossier', '2020-01-26 11:03:28', '2020-01-26 11:03:28'),
(15, 1, 28, 'Création du dossier', '2020-01-26 11:21:02', '2020-01-26 11:21:02'),
(16, 1, 28, 'Modification du dossier', '2020-01-26 12:35:33', '2020-01-26 12:35:33');

-- --------------------------------------------------------

--
-- Structure de la table `forms`
--

CREATE TABLE `forms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `forms`
--

INSERT INTO `forms` (`id`, `customer_id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, 'fac10', 'fac10', NULL, '2020-01-27 08:14:22'),
(2, 1, 'fac', 'fac', '2020-01-27 06:50:59', '2020-01-27 06:50:59'),
(3, 1, 'fac100', 'fac100', '2020-01-27 06:53:17', '2020-01-27 09:59:24'),
(4, 1, 'fac2', 'fac2', '2020-01-27 06:56:31', '2020-01-27 06:56:31'),
(5, 1, 'fac3', 'fac3', '2020-01-27 06:57:32', '2020-01-27 06:57:32'),
(6, 1, 'fac44', 'fac44', '2020-01-27 06:59:54', '2020-01-27 08:10:00'),
(7, 1, 'fac5', 'fac5', '2020-01-27 07:00:34', '2020-01-27 07:00:34'),
(8, 1, 'fac7', 'fac7', '2020-01-27 07:01:44', '2020-01-27 08:01:02'),
(9, 1, 'fac8', 'fac8', '2020-01-27 08:02:24', '2020-01-27 08:02:24'),
(10, 1, 'fac9', 'fac9', '2020-01-27 08:02:43', '2020-01-27 08:02:43'),
(11, 1, 'fac11', 'fac11', '2020-01-27 08:17:04', '2020-01-27 08:17:04'),
(12, 1, 'fac12', 'fac12', '2020-01-27 08:17:57', '2020-01-27 08:17:57'),
(13, 1, 'fac13', 'fac13', '2020-01-27 08:20:01', '2020-01-27 08:20:01'),
(14, 1, 'fac14', 'fac14', '2020-01-27 08:20:39', '2020-01-27 08:20:39'),
(15, 1, 'fac15', 'fac15', '2020-01-27 08:21:14', '2020-01-27 08:21:14'),
(16, 1, 'fac16', 'fac16', '2020-01-27 08:22:39', '2020-01-27 08:22:39'),
(19, 1, 'fac19', 'fac19', '2020-01-27 09:52:48', '2020-01-27 09:52:48'),
(20, 1, 'fac20', 'fac20', '2020-01-27 09:53:29', '2020-01-27 09:53:29'),
(21, 1, 'fac21', 'fac21', '2020-01-27 09:55:11', '2020-01-27 09:55:11'),
(22, 1, 'devis', 'test', '2020-01-30 18:36:22', '2020-01-30 18:36:22'),
(23, 1, 'Support', 'support', '2020-01-30 18:37:10', '2020-01-30 18:37:10'),
(24, 1, 'TEST200', 'TEST200', '2020-01-30 18:39:34', '2020-01-30 18:39:34');

-- --------------------------------------------------------

--
-- Structure de la table `form_fields`
--

CREATE TABLE `form_fields` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `form_id` bigint(20) UNSIGNED NOT NULL,
  `label` text NOT NULL,
  `type` text NOT NULL,
  `name` text NOT NULL,
  `default_values` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `form_fields`
--

INSERT INTO `form_fields` (`id`, `form_id`, `label`, `type`, `name`, `default_values`, `created_at`, `updated_at`) VALUES
(1, 11, 'Numero de facture', 'input', 'facture_number', '', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `groups`
--

CREATE TABLE `groups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `groups`
--

INSERT INTO `groups` (`id`, `name`, `slug`, `description`, `created_at`, `updated_at`, `customer_id`) VALUES
(1, 'Super Administrateur', 'superadmin', 'L\'utilisateur qui a tous les roles et toutes les permissions', '2019-12-23 23:00:00', '2019-12-23 23:00:00', 1),
(2, 'Commercial', 'commercial', 'Les utilisateurs qui ont droit aux dossiers des clients', '2020-01-09 15:27:53', '2020-01-09 15:27:53', 1),
(10, 'Direction Generale', 'direction-generale', 'Le groupe des directeurs generaux', '2020-01-14 16:53:08', '2020-01-14 16:53:08', 2);

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
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_11_25_172216_add_fields_to_users_table', 1),
(5, '2019_11_25_182037_create_departements_table', 2),
(6, '2019_11_25_184011_create_entreprises_table', 2),
(7, '2019_11_25_184301_add_entreprise_id_to_departements_table', 3),
(8, '2019_11_25_184530_add_foreign_key_entreprise_id_to_departements_table', 4),
(9, '2019_11_25_184836_add_nom_to_entreprises_table', 5),
(10, '2019_12_24_205613_create_customers_table', 6),
(11, '2019_12_24_211156_create_groups_table', 6),
(12, '2019_12_24_212450_add_foreign_keys_customer_group_to_users_table', 7),
(13, '2019_12_24_213827_add_fields_slug_to_groups_table', 8),
(14, '2019_12_24_215021_add_fields_user_id_to_customers_table', 9),
(15, '2019_12_24_220144_add_fields_phonenumber_to_users_table', 10),
(16, '2019_12_24_220352_add_fields_phonenumber_to_users_table_1', 11),
(17, '2019_12_24_223203_add_field_enable_to_users_table', 12),
(18, '2019_12_24_223443_add_field_status_to_users_table', 13),
(19, '2020_01_06_171317_create_roles_table', 14),
(20, '2020_01_06_172618_add_fields_name_slug_to_roles_table', 15),
(21, '2020_01_06_174055_add_foreign_key_customer_to_groups_table', 16),
(22, '2020_01_08_111407_add_field_customer_id_to_groups_table', 16),
(23, '2020_01_08_114953_add_field_api_token_to_users_table', 17),
(24, '2020_01_09_150255_add_forey_key_role_id_to_users_table', 18),
(25, '2020_01_11_200359_add_fields_website_to_customers_table', 19),
(26, '2020_01_11_205254_add_foreign_key_manager_id_to_customers_table', 20),
(27, '2020_01_11_210341_add_foreign_key_manager_id_to_customers_table', 21),
(28, '2020_01_12_114742_add_fields_country_city_activiy_to_customers_table', 22),
(29, '2020_01_13_080031_create_accounts_table', 23),
(30, '2020_01_15_123114_create_folders_table', 24),
(31, '2020_01_17_090410_create_folder_events_table', 25),
(32, '2020_01_17_113209_create_forms_table', 26),
(33, '2020_01_17_120227_add_foreign_key_forms_table', 27),
(34, '2020_01_26_124903_create_form_fields_table', 28);

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
-- Structure de la table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `roles`
--

INSERT INTO `roles` (`id`, `name`, `slug`, `created_at`, `updated_at`) VALUES
(1, 'Super Administrateur', 'super-admin', NULL, NULL),
(2, 'Administrateur', 'admin', NULL, NULL),
(3, 'Responsable', 'manager', NULL, NULL),
(4, 'Commercial', 'commercial', NULL, NULL),
(5, 'Administrateur client', 'customer-admin', NULL, NULL),
(6, 'Utilisateur', 'customer-user', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `api_token` varchar(80) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `firstname` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `group_id` bigint(20) UNSIGNED DEFAULT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `phonenumber` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `role_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `api_token`, `remember_token`, `created_at`, `updated_at`, `firstname`, `username`, `group_id`, `customer_id`, `phonenumber`, `status`, `role_id`) VALUES
(1, 'ndong otogue', 'yvon.ndong@neosystechnologie.ga', NULL, '$2y$10$HldFclaC8sYLuWc3ivXzhON3r3gomEr0lsH68RXgXR57TZbbpF.Kq', 'MM374gMYF0j8vOv1WCcDX72G5F71XWrsd39zsmXwgfekXR60DToIjR346CTeHJLug9XfVuGJvM12naIJ', 'nKYMaSpQsKazLN7G4DTRrFGJPwM7lkCmq27qqttdweSQNhvjoIeLObMcgiVD', '2019-11-25 17:08:52', '2020-01-08 11:11:57', 'yvon paul brice', 'admin', 1, 1, NULL, 1, 1),
(14, 'kombila ekang', 'donal.kombila@neosystechnologie.ga', NULL, '$2y$10$CcJfnrFZXp7bFwv/DEGgNeF3ChGpJWrwNHL.65LauExSmHgAA6aVW', 'Hnq8OTXqm69kgLWfGA2zlxxTmwvZ3Cikz2sxIkfZ4wPRp1gXmR8loUBdJ8pA507yKpzCSXVaoubwcvyP', NULL, '2020-01-08 11:19:18', '2020-01-09 11:57:58', 'donald', 'donald.kombila', 1, 1, NULL, 0, 2),
(15, 'missevou', 'aude.missevou@neosystechnologie.ga', NULL, '$2y$10$Rkeqvqdh6vpw4sFyQ5VvjeBpt7JghpK6amqohrttNQPV2oQJzGig.', 'QbJrHGMLtvTTCcvHxRf6JqrMvpB7Z1UeM7ut6sn4zj76nD280rUio2J1oIcpaoJwJ2DuEp6larGIyI6X', '4UuZUZ7VSiKgB7picnHd29bfDyG9tgwMp4rU9mCkCvJF5e44oh4yh7heykVl', '2020-01-09 14:30:44', '2020-01-09 14:37:42', 'aude cheryle', 'aude.missevou', 1, 1, NULL, 1, 4),
(17, 'JOCKTANE', 'c.jocktane@gmail.com', NULL, '$2y$10$dMuc8kBH7EgW.vGPvPTGc.Je.JqR6uu/ishMk3Q82DiQnmkU/JE/W', 'EdsG0E89ec1GTWG3nLCN9C4kcDEq4BpvumZePebP4dG9M5UUwzrOAV5udjgMIF4YGGIuPboo3ZyneDr7', 'm7KcQZhChd3TabZjQ8zH5z6kx4NDwn8sokk7mQJQi4Wyx0Mc0rn1qIvVo1Kb', '2020-01-14 15:42:28', '2020-01-14 15:42:28', 'Christophe', 'c.jocktane', 1, 2, NULL, 1, 5),
(18, 'DG1', 'dg1.workinart@workinart.ga', NULL, '$2y$10$g/KneBqAd64h9DCbCfxtKekHmnFQBJvhFfvyKr..YUfMgF3yr4E.u', 'XJIkd9cfXVWdStR7oq1dfTCgAToDxgpGiP1RN8yHfYCNmoaS0EXDKOjyjTiaecm4WEHsf0Zi0gD2R1ho', NULL, '2020-01-14 16:58:29', '2020-01-14 16:58:29', 'DG1', 'dg1.workinart', 10, 2, NULL, 1, 6),
(19, 'manager1', 'manager1@neoeystechnologie.ga', NULL, '$2y$10$WJ3hDPxxfiPKQPW5mbGppO6354z8j86end213mKTun17x/m1g1z8a', '8AvYBh8zUZeZXzPoc3yxySNfjuKMM7lezFvwd36PM5o9oYBMvJ004i84O5L6V59kUCCAT7EJDyJpVkJ1', NULL, '2020-01-15 11:19:12', '2020-01-15 11:19:12', 'manager1', 'manager1', NULL, 1, NULL, 1, 3),
(20, 'commercial1', 'commercial1@neosystechnologie.ga', NULL, '$2y$10$IKORG0tMFXwUlWEmbdpKJOp8s6P75YQeyn.9kYaiKl9Y2e5y0h1Ji', 'uzW8sgRAfuRRUmFxxV0wduBbWQ9Z0UQ7v6kFKbzFyFZXj0959Vw8MPGT17GE9mE4vbwWbRBPkHkNAbxT', NULL, '2020-01-15 11:30:28', '2020-01-15 11:30:28', 'commercial1', 'commercial1', NULL, 1, NULL, 1, 4);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `accounts_account_number_unique` (`account_number`),
  ADD KEY `accounts_customer_id_foreign` (`customer_id`);

--
-- Index pour la table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customers_manager_id_index` (`manager_id`);

--
-- Index pour la table `departements`
--
ALTER TABLE `departements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `departements_entreprise_id_index` (`entreprise_id`);

--
-- Index pour la table `entreprises`
--
ALTER TABLE `entreprises`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `entreprises_nom_unique` (`nom`);

--
-- Index pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `folders`
--
ALTER TABLE `folders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `folders_customer_id_index` (`customer_id`),
  ADD KEY `folders_created_by_index` (`created_by`),
  ADD KEY `folders_updated_by_index` (`updated_by`);

--
-- Index pour la table `folder_events`
--
ALTER TABLE `folder_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `folder_events_user_id_index` (`user_id`),
  ADD KEY `folder_events_folder_id_index` (`folder_id`);

--
-- Index pour la table `forms`
--
ALTER TABLE `forms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `forms_customer_id_index` (`customer_id`);

--
-- Index pour la table `form_fields`
--
ALTER TABLE `form_fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `form_fields_form_id_index` (`form_id`);

--
-- Index pour la table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `groups_name_unique` (`name`),
  ADD UNIQUE KEY `groups_slug_unique` (`slug`),
  ADD KEY `groups_customer_id_index` (`customer_id`);

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
-- Index pour la table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_api_token_unique` (`api_token`),
  ADD KEY `users_group_id_index` (`group_id`),
  ADD KEY `users_customer_id_index` (`customer_id`),
  ADD KEY `users_role_id_index` (`role_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `departements`
--
ALTER TABLE `departements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `entreprises`
--
ALTER TABLE `entreprises`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `folders`
--
ALTER TABLE `folders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT pour la table `folder_events`
--
ALTER TABLE `folder_events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `forms`
--
ALTER TABLE `forms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT pour la table `form_fields`
--
ALTER TABLE `form_fields`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT pour la table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `accounts`
--
ALTER TABLE `accounts`
  ADD CONSTRAINT `accounts_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_manager_id_foreign` FOREIGN KEY (`manager_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `departements`
--
ALTER TABLE `departements`
  ADD CONSTRAINT `departements_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`);

--
-- Contraintes pour la table `folders`
--
ALTER TABLE `folders`
  ADD CONSTRAINT `folders_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `folders_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `folders_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `folder_events`
--
ALTER TABLE `folder_events`
  ADD CONSTRAINT `folder_events_folder_id_foreign` FOREIGN KEY (`folder_id`) REFERENCES `folders` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `folder_events_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `forms`
--
ALTER TABLE `forms`
  ADD CONSTRAINT `forms_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `form_fields`
--
ALTER TABLE `form_fields`
  ADD CONSTRAINT `form_fields_form_id_foreign` FOREIGN KEY (`form_id`) REFERENCES `forms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `groups_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

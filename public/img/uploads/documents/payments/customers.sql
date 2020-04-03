-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  mer. 11 mars 2020 à 13:51
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

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customers_manager_id_index` (`manager_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_manager_id_foreign` FOREIGN KEY (`manager_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

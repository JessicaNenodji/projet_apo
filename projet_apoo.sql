-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 29 oct. 2024 à 12:19
-- Version du serveur : 5.7.36
-- Version de PHP : 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `projet_apoo`
--

-- --------------------------------------------------------

--
-- Structure de la table `stock`
--

DROP TABLE IF EXISTS `stock`;
CREATE TABLE IF NOT EXISTS `stock` (
  `Id produit` varchar(10) NOT NULL,
  `Nom produit` varchar(50) NOT NULL,
  `Quantité` int(20) NOT NULL,
  `Coût` decimal(10,2) NOT NULL,
  PRIMARY KEY (`Id produit`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `Id_utilisateur` int(11) NOT NULL,
  `nom` varchar(50) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `identifiant` varchar(50) DEFAULT NULL,
  `mot_de_passe` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Id_utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `ventes`
--

DROP TABLE IF EXISTS `ventes`;
CREATE TABLE IF NOT EXISTS `ventes` (
  `Nom produit` varchar(50) NOT NULL,
  `Id produit` varchar(10) NOT NULL,
  `Nom client` varchar(50) NOT NULL,
  `Id_vente` int(50) NOT NULL,
  `Prix unitaire` int(20) NOT NULL,
  `Prix total` int(20) NOT NULL,
  `Prix definitif` int(10) NOT NULL,
  `Date` date NOT NULL,
  `Id_utilisateur` int(50) NOT NULL,
  PRIMARY KEY (`Id_vente`),
  KEY `Ventes` (`Id produit`),
  KEY `fk_ventes` (`Id_utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `ventes`
--
ALTER TABLE `ventes`
  ADD CONSTRAINT `fk_ventes` FOREIGN KEY (`Id_utilisateur`) REFERENCES `utilisateurs` (`Id_utilisateur`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 06 nov. 2024 à 11:05
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
-- Structure de la table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `ID_Clients` int(20) NOT NULL,
  `Nom_Client` varchar(50) NOT NULL,
  `Adresse` varchar(20) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Telephone` int(15) NOT NULL,
  PRIMARY KEY (`ID_Clients`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `commandes`
--

DROP TABLE IF EXISTS `commandes`;
CREATE TABLE IF NOT EXISTS `commandes` (
  `ID_Commande` int(20) NOT NULL,
  `Date_de_commande` date NOT NULL,
  `ID_Client` int(20) NOT NULL,
  `Montant_Total` int(50) NOT NULL,
  PRIMARY KEY (`ID_Commande`),
  KEY `Commandes` (`ID_Client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `details_commandes`
--

DROP TABLE IF EXISTS `details_commandes`;
CREATE TABLE IF NOT EXISTS `details_commandes` (
  `ID_Commande` int(20) NOT NULL,
  `Quantité` int(11) NOT NULL,
  `ID_Produit` varchar(40) NOT NULL,
  `Prix unitaire` int(50) NOT NULL,
  PRIMARY KEY (`ID_Commande`),
  KEY `fk_Details_Commandes` (`ID_Produit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `facture`
--

DROP TABLE IF EXISTS `facture`;
CREATE TABLE IF NOT EXISTS `facture` (
  `ID_Facture` int(20) NOT NULL,
  `ID_Commande` int(20) NOT NULL,
  `Date facture` date NOT NULL,
  `Prix total` int(25) NOT NULL,
  PRIMARY KEY (`ID_Facture`),
  KEY `Facture` (`ID_Commande`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `fournisseur`
--

DROP TABLE IF EXISTS `fournisseur`;
CREATE TABLE IF NOT EXISTS `fournisseur` (
  `ID_fournisseur` int(20) NOT NULL,
  `Nom_fournisseur` varchar(50) CHARACTER SET utf8 NOT NULL,
  `Adresse` varchar(20) CHARACTER SET utf8 NOT NULL,
  `Contact` int(20) NOT NULL,
  PRIMARY KEY (`ID_fournisseur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `paiement`
--

DROP TABLE IF EXISTS `paiement`;
CREATE TABLE IF NOT EXISTS `paiement` (
  `ID_Paiement` int(50) NOT NULL,
  `ID_Facture` int(20) NOT NULL,
  `Date de paiement` date NOT NULL,
  `Montant` int(25) NOT NULL,
  PRIMARY KEY (`ID_Paiement`),
  KEY `Paiement` (`ID_Facture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `photos_factures`
--

DROP TABLE IF EXISTS `photos_factures`;
CREATE TABLE IF NOT EXISTS `photos_factures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facture_id` int(11) DEFAULT NULL,
  `photo` longblob,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `facture_id` (`facture_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

DROP TABLE IF EXISTS `produit`;
CREATE TABLE IF NOT EXISTS `produit` (
  `ID_produit` varchar(40) CHARACTER SET utf8 NOT NULL,
  `Designation` varchar(35) CHARACTER SET utf8 NOT NULL,
  `Quantité disponible` int(30) NOT NULL,
  `Prix` int(30) NOT NULL,
  `ID_fournisseur` int(20) NOT NULL,
  PRIMARY KEY (`ID_produit`),
  KEY `Produit` (`ID_fournisseur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `stock`
--

DROP TABLE IF EXISTS `stock`;
CREATE TABLE IF NOT EXISTS `stock` (
  `ID_stock` int(40) NOT NULL,
  `Date d'entrée` date NOT NULL,
  `Date de sorti` date NOT NULL,
  `Quantité stockée` int(30) NOT NULL,
  `ID_produit` varchar(40) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`ID_stock`),
  KEY `Stock` (`ID_produit`)
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

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commandes`
--
ALTER TABLE `commandes`
  ADD CONSTRAINT `Commandes` FOREIGN KEY (`ID_Client`) REFERENCES `clients` (`ID_Clients`);

--
-- Contraintes pour la table `details_commandes`
--
ALTER TABLE `details_commandes`
  ADD CONSTRAINT `Details_Commandes` FOREIGN KEY (`ID_Commande`) REFERENCES `commandes` (`ID_Commande`),
  ADD CONSTRAINT `fk_Details_Commandes` FOREIGN KEY (`ID_Produit`) REFERENCES `produit` (`ID_produit`);

--
-- Contraintes pour la table `facture`
--
ALTER TABLE `facture`
  ADD CONSTRAINT `Facture` FOREIGN KEY (`ID_Commande`) REFERENCES `commandes` (`ID_Commande`);

--
-- Contraintes pour la table `paiement`
--
ALTER TABLE `paiement`
  ADD CONSTRAINT `Paiement` FOREIGN KEY (`ID_Facture`) REFERENCES `facture` (`ID_Facture`);

--
-- Contraintes pour la table `produit`
--
ALTER TABLE `produit`
  ADD CONSTRAINT `Produit` FOREIGN KEY (`ID_fournisseur`) REFERENCES `fournisseur` (`ID_fournisseur`);

--
-- Contraintes pour la table `stock`
--
ALTER TABLE `stock`
  ADD CONSTRAINT `Stock` FOREIGN KEY (`ID_produit`) REFERENCES `produit` (`ID_produit`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

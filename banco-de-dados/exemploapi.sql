-- phpMyAdmin SQL Dump
-- version 4.0.4.2
-- http://www.phpmyadmin.net
--
-- Máquina: localhost
-- Data de Criação: 03-Jun-2022 às 18:40
-- Versão do servidor: 5.6.13
-- versão do PHP: 5.4.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de Dados: `exemploapi`
--
CREATE DATABASE IF NOT EXISTS `exemploapi` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `exemploapi`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `categoriaproduto`
--

CREATE TABLE IF NOT EXISTS `categoriaproduto` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Extraindo dados da tabela `categoriaproduto`
--

INSERT INTO `categoriaproduto` (`ID`, `descricao`) VALUES
(1, 'Roupas'),
(2, 'Satapos');

-- --------------------------------------------------------

--
-- Estrutura da tabela `produto`
--

CREATE TABLE IF NOT EXISTS `produto` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DESCRICAO` varchar(255) DEFAULT NULL,
  `QUANTIDADE` int(11) DEFAULT NULL,
  `VALORUNITATIO` double DEFAULT NULL,
  `categoriaProduto_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_PRODUTO_categoriaProduto_id` (`categoriaProduto_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Extraindo dados da tabela `produto`
--

INSERT INTO `produto` (`ID`, `DESCRICAO`, `QUANTIDADE`, `VALORUNITATIO`, `categoriaProduto_id`) VALUES
(1, 'Camisa X', 1, 10, 1),
(4, 'Camisa Y (FRC)', 11, 101, 2),
(5, 'Bermuda (FRC)', 10, 111, 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `senha` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Extraindo dados da tabela `usuario`
--

INSERT INTO `usuario` (`codigo`, `senha`, `username`) VALUES
(1, '123', 'FRC'),
(2, '123', 'aula');

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `produto`
--
ALTER TABLE `produto`
  ADD CONSTRAINT `FK_PRODUTO_categoriaProduto_id` FOREIGN KEY (`categoriaProduto_id`) REFERENCES `categoriaproduto` (`ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

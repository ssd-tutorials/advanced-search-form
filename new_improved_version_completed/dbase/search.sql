-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Jul 04, 2014 at 06:25 PM
-- Server version: 5.5.34
-- PHP Version: 5.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `search`
--

-- --------------------------------------------------------

--
-- Table structure for table `authors`
--

CREATE TABLE `authors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `authors`
--

INSERT INTO `authors` (`id`, `name`) VALUES
(1, 'Darren Shan'),
(2, 'M.R. James'),
(3, 'Stephenie Meyer'),
(4, 'Nora Roberts');

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `isbn` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `category` int(11) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `date_released` date NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_CATEGORY` (`category`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `isbn`, `title`, `description`, `category`, `price`, `date_released`, `date_added`) VALUES
(1, '2354657690', 'Ghost Stories', 'This is ', 1, 6.99, '2014-06-03', '2014-06-12 12:12:12'),
(2, '68974848733', 'Hell''s Heroes', 'The final dramatic conclusion ', 2, 6.49, '2014-03-03', '2014-06-03 00:00:00'),
(3, '76848437646464', 'Twilight', 'When 17 years old Isabella Swan was ', 3, 3.49, '2013-04-09', '2014-06-06 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `books_authors`
--

CREATE TABLE `books_authors` (
  `book_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`book_id`,`author_id`),
  KEY `FK_BOOK` (`book_id`),
  KEY `FK_AUTHOR` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `books_authors`
--

INSERT INTO `books_authors` (`book_id`, `author_id`) VALUES
(1, 1),
(2, 2),
(2, 3),
(3, 1),
(3, 3),
(3, 4);

-- --------------------------------------------------------

--
-- Table structure for table `books_covers`
--

CREATE TABLE `books_covers` (
  `book_id` int(11) NOT NULL,
  `cover_id` tinyint(1) NOT NULL,
  PRIMARY KEY (`book_id`,`cover_id`),
  KEY `FK_BOOK` (`book_id`),
  KEY `FK_COVER` (`cover_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `books_covers`
--

INSERT INTO `books_covers` (`book_id`, `cover_id`) VALUES
(1, 1),
(3, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `books_languages`
--

CREATE TABLE `books_languages` (
  `book_id` int(11) NOT NULL,
  `lang_id` int(11) NOT NULL,
  PRIMARY KEY (`book_id`,`lang_id`),
  KEY `FK_BOOK` (`book_id`),
  KEY `FK_LANGUAGE` (`lang_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `books_languages`
--

INSERT INTO `books_languages` (`book_id`, `lang_id`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `books_locations`
--

CREATE TABLE `books_locations` (
  `book_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  PRIMARY KEY (`book_id`,`location_id`),
  KEY `FK_BOOK` (`book_id`),
  KEY `FK_LOCATION` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `books_locations`
--

INSERT INTO `books_locations` (`book_id`, `location_id`) VALUES
(1, 1),
(1, 3),
(2, 2),
(3, 3),
(3, 4);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Drama'),
(2, 'Comedy'),
(3, 'Travel');

-- --------------------------------------------------------

--
-- Table structure for table `covers`
--

CREATE TABLE `covers` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `covers`
--

INSERT INTO `covers` (`id`, `name`) VALUES
(1, 'Hard'),
(2, 'Soft');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`) VALUES
(1, 'English'),
(2, 'French'),
(3, 'German'),
(4, 'Spanish');

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `name`) VALUES
(1, 'Dublin'),
(2, 'London'),
(3, 'Paris'),
(4, 'Madrid');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`category`) REFERENCES `categories` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `books_authors`
--
ALTER TABLE `books_authors`
  ADD CONSTRAINT `books_authors_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `books_authors_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `books_covers`
--
ALTER TABLE `books_covers`
  ADD CONSTRAINT `books_covers_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `books_covers_ibfk_2` FOREIGN KEY (`cover_id`) REFERENCES `covers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `books_languages`
--
ALTER TABLE `books_languages`
  ADD CONSTRAINT `books_languages_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `books_languages_ibfk_2` FOREIGN KEY (`lang_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `books_locations`
--
ALTER TABLE `books_locations`
  ADD CONSTRAINT `books_locations_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `books_locations_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

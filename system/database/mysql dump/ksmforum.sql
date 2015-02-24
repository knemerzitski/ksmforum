-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Feb 24, 2015 at 12:26 PM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ksmforum`
--

-- --------------------------------------------------------

--
-- Table structure for table `ci_sessions`
--

CREATE TABLE IF NOT EXISTS `ci_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ci_sessions`
--

INSERT INTO `ci_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('0f2c0515f5e3347f61a25d9397070803', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; WOW64; rv:35.0) Gecko/20100101 Firefox/35.0', 1424775250, ''),
('e00d6ce5cf79bff324c60c1cf66f662d', '::1', 'Mozilla/5.0 (Windows NT 6.3; WOW64; rv:35.0) Gecko/20100101 Firefox/35.0', 1424776276, 'a:1:{s:7:"user_id";s:1:"8";}');

-- --------------------------------------------------------

--
-- Table structure for table `forums`
--

CREATE TABLE IF NOT EXISTS `forums` (
`id` int(10) unsigned NOT NULL,
  `p_fid` int(10) unsigned DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `uid` int(10) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `forums`
--

INSERT INTO `forums` (`id`, `p_fid`, `name`, `uid`) VALUES
(10, 14, 'Uudised', 8),
(14, NULL, 'Pealehe foorum', 8),
(15, NULL, 'KSM Foorum', 8),
(16, NULL, 'Muu', 8),
(17, 10, 'Uudiste sub', 8),
(19, NULL, 'Täiesti uus foorum', 8),
(20, 10, 'Yipee', 8),
(21, 19, 'Alam', 8),
(22, 21, 'Epic shizz', 8);

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE IF NOT EXISTS `posts` (
`id` int(10) unsigned NOT NULL,
  `p_pid` int(10) unsigned DEFAULT NULL,
  `tid` int(10) unsigned NOT NULL DEFAULT '0',
  `content` text NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `edit_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `depth` int(10) unsigned NOT NULL DEFAULT '0',
  `pos` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9816 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `p_pid`, `tid`, `content`, `create_time`, `edit_time`, `depth`, `pos`, `uid`) VALUES
(9802, NULL, 13, 'The sisu', '2015-02-22 14:27:14', '2015-02-22 14:27:14', 0, 1, 8),
(9803, 9802, 13, 'Kirjuta kommentaar siia', '2015-02-22 17:42:11', '2015-02-22 17:42:11', 1, 2, 8),
(9804, 9802, 13, 'Yep', '2015-02-23 14:41:10', '2015-02-23 14:41:10', 1, 3, 8),
(9805, 9802, 13, 'Kirjuta kommentaar siia', '2015-02-23 16:26:42', '2015-02-23 16:26:43', 1, 4, 8),
(9806, 9802, 13, 'Kirjuta kommentaar siia', '2015-02-23 18:06:40', '2015-02-23 18:13:29', 1, 6, 8),
(9807, NULL, 14, 'The sisu', '2015-02-23 18:11:17', '2015-02-23 18:11:17', 0, 1, 8),
(9808, NULL, 15, 'The sisu', '2015-02-23 18:11:23', '2015-02-23 18:11:23', 0, 1, 8),
(9809, 9805, 13, 'Kirjuta kommentaar siia', '2015-02-23 18:13:29', '2015-02-23 18:13:29', 2, 5, 8),
(9810, NULL, 17, 'rickroll', '2015-02-23 22:55:34', '2015-02-23 22:55:34', 0, 1, 8),
(9811, 9810, 17, 'fun', '2015-02-23 23:01:04', '2015-02-23 23:01:04', 1, 2, 3),
(9812, 9810, 17, 'epic', '2015-02-23 23:01:09', '2015-02-23 23:01:43', 1, 5, 3),
(9813, 9811, 17, '???', '2015-02-23 23:01:14', '2015-02-23 23:01:14', 2, 3, 3),
(9814, 9813, 17, 'veel', '2015-02-23 23:01:43', '2015-02-23 23:01:43', 3, 4, 3),
(9815, 9810, 17, 'Kirjuta kommentaar siia', '2015-02-23 23:54:55', '2015-02-23 23:54:55', 1, 6, 8);

--
-- Triggers `posts`
--
DELIMITER //
CREATE TRIGGER `tr_post_before_insert_rules` BEFORE INSERT ON `posts`
 FOR EACH ROW BEGIN
    IF NEW.p_pid IS NOT NULL THEN
        SET NEW.depth = 1+(SELECT depth from posts WHERE id=NEW.p_pid);
    END IF;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `topics`
--

CREATE TABLE IF NOT EXISTS `topics` (
`id` int(10) unsigned NOT NULL,
  `fid` int(10) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `edit_time` timestamp NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `uid` int(10) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `topics`
--

INSERT INTO `topics` (`id`, `fid`, `name`, `content`, `create_time`, `edit_time`, `uid`) VALUES
(13, 10, 'Olulised uudised', '', '2015-02-22 14:27:14', '0000-00-00 00:00:00', 8),
(14, 10, 'Pealkiri', '', '2015-02-23 18:11:17', '0000-00-00 00:00:00', 8),
(15, 10, 'Pealkiri 2', '', '2015-02-23 18:11:23', '0000-00-00 00:00:00', 8),
(17, 20, 'Väga oluline: help!', '', '2015-02-23 22:55:34', '0000-00-00 00:00:00', 8);

-- --------------------------------------------------------

--
-- Table structure for table `usergroups`
--

CREATE TABLE IF NOT EXISTS `usergroups` (
`id` int(10) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  `addforum` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usergroups`
--

INSERT INTO `usergroups` (`id`, `name`, `addforum`) VALUES
(1, 'default', 0),
(2, 'admin', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
`id` int(10) unsigned NOT NULL,
  `name` varchar(25) NOT NULL,
  `pass` varchar(50) NOT NULL,
  `email` varchar(320) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `edit_time` timestamp NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `usergroup` int(10) unsigned NOT NULL DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `pass`, `email`, `create_time`, `edit_time`, `usergroup`) VALUES
(3, 'user1', 'f0578f1e7174b1a41c4ea8c6e17f7a8a3b88c92a', 'email@meh.com', '2015-02-23 15:08:09', '2015-02-24 11:19:19', 1),
(4, 'user', '9d4e1e23bd5b727046a9e3b4b7db57bd8d6ee684', 'Email', '2015-02-23 15:20:32', '2015-02-24 11:19:20', 1),
(7, 'Kasutajanimi2', '354b7d6a59251940bd3f6b49e029f2d043cc6e77', 'Email', '2015-02-23 15:23:25', '2015-02-24 11:19:22', 1),
(8, 'Kasutajanimi', '354b7d6a59251940bd3f6b49e029f2d043cc6e77', 'Email', '2015-02-23 17:55:31', '2015-02-24 11:19:23', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ci_sessions`
--
ALTER TABLE `ci_sessions`
 ADD PRIMARY KEY (`session_id`), ADD KEY `last_activity_idx` (`last_activity`);

--
-- Indexes for table `forums`
--
ALTER TABLE `forums`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `name` (`name`), ADD KEY `p_fid` (`p_fid`), ADD KEY `uid` (`uid`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
 ADD PRIMARY KEY (`id`), ADD KEY `tid` (`tid`), ADD KEY `p_pid` (`p_pid`), ADD KEY `uid` (`uid`);

--
-- Indexes for table `topics`
--
ALTER TABLE `topics`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `fid_title` (`fid`,`name`), ADD KEY `fid` (`fid`), ADD KEY `uid` (`uid`);

--
-- Indexes for table `usergroups`
--
ALTER TABLE `usergroups`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `user` (`name`,`email`), ADD KEY `usergroup` (`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `forums`
--
ALTER TABLE `forums`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9816;
--
-- AUTO_INCREMENT for table `topics`
--
ALTER TABLE `topics`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `usergroups`
--
ALTER TABLE `usergroups`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `forums`
--
ALTER TABLE `forums`
ADD CONSTRAINT `fk_forum_2_forum` FOREIGN KEY (`p_fid`) REFERENCES `forums` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_forum_2_user` FOREIGN KEY (`uid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
ADD CONSTRAINT `fk_post_2_post` FOREIGN KEY (`p_pid`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_post_2_topic` FOREIGN KEY (`tid`) REFERENCES `topics` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_post_2_user` FOREIGN KEY (`uid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `topics`
--
ALTER TABLE `topics`
ADD CONSTRAINT `fk_topic_2_forum` FOREIGN KEY (`fid`) REFERENCES `forums` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_topic_2_user` FOREIGN KEY (`uid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
ADD CONSTRAINT `fk_user_2_usergroup` FOREIGN KEY (`usergroup`) REFERENCES `usergroups` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
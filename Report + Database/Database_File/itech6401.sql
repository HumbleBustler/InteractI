-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 28, 2018 at 10:52 AM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 7.0.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `itech6401`
--

-- --------------------------------------------------------

--
-- Table structure for table `assessment`
--

CREATE TABLE `assessment` (
  `aid` int(10) NOT NULL,
  `sid` mediumint(8) NOT NULL,
  `eid` int(8) NOT NULL,
  `A1` mediumint(5) NOT NULL,
  `A2` mediumint(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `assessment`
--

INSERT INTO `assessment` (`aid`, `sid`, `eid`, `A1`, `A2`) VALUES
(1, 56, 1, 84, 86),
(2, 55, 1, 80, 77),
(3, 56, 2, 84, 65),
(4, 55, 2, 65, 58);

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `cid` varchar(7) NOT NULL,
  `title` varchar(50) NOT NULL,
  `prerequistes` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`cid`, `title`, `prerequistes`) VALUES
('6401', 'Enterprise Programming', 'Fundamental of Programming, Database Management System'),
('6402', 'Network Adminstration', 'CCN , IAP');

-- --------------------------------------------------------

--
-- Table structure for table `course_assessment`
--

CREATE TABLE `course_assessment` (
  `caid` int(10) NOT NULL,
  `cid` mediumint(10) NOT NULL,
  `aid` int(10) NOT NULL,
  `semester` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `course_assessment`
--

INSERT INTO `course_assessment` (`caid`, `cid`, `aid`, `semester`) VALUES
(1, 6401, 1, '1'),
(2, 6401, 2, '1'),
(3, 6402, 3, '1'),
(4, 6402, 4, '1');

-- --------------------------------------------------------

--
-- Table structure for table `course_conduction`
--

CREATE TABLE `course_conduction` (
  `ccid` int(10) NOT NULL,
  `lid` mediumint(7) NOT NULL,
  `cid` mediumint(7) NOT NULL,
  `semester` varchar(12) NOT NULL,
  `capacity` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `course_conduction`
--

INSERT INTO `course_conduction` (`ccid`, `lid`, `cid`, `semester`, `capacity`) VALUES
(1, 12, 6401, '1', 20),
(2, 12, 6402, '1', 30);

-- --------------------------------------------------------

--
-- Table structure for table `enrollment`
--

CREATE TABLE `enrollment` (
  `eid` int(8) NOT NULL,
  `sid` mediumint(7) NOT NULL,
  `cid` mediumint(7) NOT NULL,
  `semester` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `enrollment`
--

INSERT INTO `enrollment` (`eid`, `sid`, `cid`, `semester`) VALUES
(1, 56, 6401, '1'),
(2, 56, 6402, '1'),
(3, 55, 6401, '1'),
(4, 55, 6402, '1');

-- --------------------------------------------------------

--
-- Table structure for table `lecturer`
--

CREATE TABLE `lecturer` (
  `LID` mediumint(7) NOT NULL,
  `gname` varchar(200) NOT NULL,
  `surname` varchar(200) NOT NULL,
  `campus` varchar(200) NOT NULL,
  `passwd` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lecturer`
--

INSERT INTO `lecturer` (`LID`, `gname`, `surname`, `campus`, `passwd`, `email`) VALUES
(12, 'Jhone', 'Michal', 'Australia', '123', 'jhone@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `sid` mediumint(8) NOT NULL,
  `fname` varchar(100) NOT NULL,
  `surname` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `major` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`sid`, `fname`, `surname`, `email`, `major`, `password`) VALUES
(55, 'Tejinder', 'Kaur', 'tejinder@gmail.com', 'Programming', '123'),
(56, 'Krishan', 'Sharma', 'sharma@gmail.com', 'Programming', '123');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`username`, `password`, `type`) VALUES
('adnan@gmail.com', '123', 'Admin'),
('jhone@gmail.com', '123', 'Teacher'),
('sharma@gmail.com', '123', 'Student'),
('tejinder@gmail.com', '123', 'Student');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assessment`
--
ALTER TABLE `assessment`
  ADD PRIMARY KEY (`aid`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`cid`);

--
-- Indexes for table `course_assessment`
--
ALTER TABLE `course_assessment`
  ADD PRIMARY KEY (`caid`);

--
-- Indexes for table `course_conduction`
--
ALTER TABLE `course_conduction`
  ADD PRIMARY KEY (`ccid`);

--
-- Indexes for table `enrollment`
--
ALTER TABLE `enrollment`
  ADD PRIMARY KEY (`eid`);

--
-- Indexes for table `lecturer`
--
ALTER TABLE `lecturer`
  ADD PRIMARY KEY (`LID`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`sid`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assessment`
--
ALTER TABLE `assessment`
  MODIFY `aid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `course_assessment`
--
ALTER TABLE `course_assessment`
  MODIFY `caid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `course_conduction`
--
ALTER TABLE `course_conduction`
  MODIFY `ccid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `enrollment`
--
ALTER TABLE `enrollment`
  MODIFY `eid` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

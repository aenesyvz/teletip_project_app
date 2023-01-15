
CREATE DATABASE IF NOT EXISTS `teletipProjectAppDb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `teletipProjectAppDb`;

CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `doctorId` int NOT NULL,
  `patientId` int NOT NULL,
  `userName` varchar(30),
  `title` varchar(30),
  `explation` varchar(200)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



CREATE TABLE `doctor` (
  `doctorId` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(15) NOT NULL,
  `email` varchar(30) NOT NULL,
  `doctorPassword` varchar(20) NOT NULL,
  `phoneNumber` varchar(15) NOT NULL,
  `gender` int NOT NULL,
  `mainScienceBranchId` int NOT NULL,
  `activityStatus` tinyint(1) NOT NULL,
  `imagePath` varchar(300) DEFAULT NULL,
  `hospital` varchar(100) DEFAULT NULL,
  `faculty` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE `mainScienceBranch` (
  `mainScienceBranchId` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `mainScienceBranchName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `mainScienceBranch` (`mainScienceBranchId`, `mainScienceBranchName`) VALUES
(1, 'Acil Tıp'),
(2, 'Adli Tıp'),
(3, 'Aile Hekimliği'),
(4, 'Anatomi'),
(5, 'Anesteziyoloji ve Reanimasyon'),
(6, 'Askeri Sahra Hekimliği'),
(7, 'Beyin ve Sinir Cerrahisi'),
(8, 'Çocuk Cerrahisi'),
(9, 'Çocuk Psikiyatrisi'),
(10, 'Çocuk Sağlığı ve Hastalıkları'),
(11, 'Dermatoloji'),
(12,'Diş'),
(13, 'Embriyoloji ve Histoloji'),
(14, 'Enfeksiyon Hastalıkları'),
(15, 'Fiziksel Tıp ve Rehabilitasyon'),
(16, 'Fizyoloji'),
(17, 'Genel Cerrahi'),
(18, 'Göğüs Cerrahisi'),
(19, 'Göğüs Hastalıkları'),
(20, 'Göz Hastalıkları'),
(21, 'Halk Sağlığı'),
(22, 'Hava ve Uzay Hekimliği'),
(23, 'İç Hastalıkları'),
(24, 'Kadın Hastalıkları ve Doğum'),
(25, 'Kalp ve Damar Cerrahisi'),
(26, 'Kardiyoloji'),
(27, 'Kulak-Burun-Boğaz Hastalıkları'),
(28, 'Nöroloji'),
(29, 'Nükleer Tıp'),
(30, 'Ortopedi ve Travmatoloji'),
(31, 'Plastik, Rekonstrüktif ve Estetik Cerrahi'),
(32, 'Psikiyatri'),
(33, 'Radyasyon Onkolojisi'),
(34, 'Radyoloji'),
(35, 'Spor Hekimliği'),
(36, 'Sualtı Hekimliği ve Hiperbarik Tıp'),
(37, 'Tıbbi Biyokimya'),
(38, 'Tıbbi Ekoloji ve Hidroklimatoloji'),
(39, 'Tıbbi Farmakoloji'),
(40, 'Tıbbi Genetik'),
(41, 'Tıbbi Mikrobiyoloji'),
(42, 'Tıbbi Patoloji'),
(43, 'Üroloji');


CREATE TABLE `doctorSpecialty` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `doctorId` int NOT NULL,
  `professionId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `profession` (
  `professionId` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `professionName` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `profession` (`professionId`, `professionName`) VALUES
(1, 'Bel fıtığı'),
(2, 'Boyun fıtğı'),
(3, 'Egzema'),
(4, 'Göz kapağı hastalıkları'),
(5, 'Gözyaşı sistemi hastalıkları'),
(6, 'Kuru göz hastalığı'),
(7, 'Omurilik felci'),
(8, 'Romatizma');

CREATE TABLE `patient` (
  `patientId` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `firstName` varchar(30) NOT NULL,
  `lastName` varchar(15) NOT NULL,
  `email` varchar(30) NOT NULL,
  `patientPassword` varchar(20) NOT NULL,
  `phoneNumber` varchar(15) NOT NULL,
  `gender` int NOT NULL,
  `activityStatus` int NOT NULL,
  `imagePath` varchar(400) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `message` (
  `messageId` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `patientId` int NOT NULL,
  `doctorId` int NOT NULL,
  `patientMessage` varchar(5000) DEFAULT NULL,
  `doctorResponse` varchar(5000) DEFAULT NULL,
  `patientAdditionPath` varchar(500) DEFAULT NULL,
  `sendDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `responseDate` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;





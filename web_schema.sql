-- --------------------------------------------------------
-- Värd:                         localhost
-- Serverversion:                10.1.37-MariaDB-0+deb9u1 - Debian 9.6
-- Server-OS:                    debian-linux-gnu
-- HeidiSQL Version:             10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumpar databasstruktur för wagger_db
DROP DATABASE IF EXISTS `wagger_db`;
CREATE DATABASE IF NOT EXISTS `wagger_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `wagger_db`;

-- Dumpar struktur för tabell wagger_db.t_acquired_data
DROP TABLE IF EXISTS `t_acquired_data`;
CREATE TABLE IF NOT EXISTS `t_acquired_data` (
  `UNIQUE_INDEX` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `CHANNEL_INDEX` smallint(5) unsigned NOT NULL,
  `ACQUIRED_TIME` int(11) unsigned NOT NULL,
  `ACQUIRED_MICROSECS` mediumint(8) unsigned DEFAULT NULL,
  `ACQUIRED_VALUE` double DEFAULT NULL,
  `ACQUIRED_SUBSAMPLES` mediumtext,
  `ACQUIRED_BASE64` mediumblob,
  `ADDED_TIMESTAMP` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `STATUS` tinyint(4) DEFAULT '-1',
  PRIMARY KEY (`UNIQUE_INDEX`),
  KEY `ACQUIRED_TIME_CHANNEL_INDEX_IDX` (`ACQUIRED_TIME`,`CHANNEL_INDEX`),
  KEY `CHANNEL_INDEX_STATUS_IDX` (`CHANNEL_INDEX`,`STATUS`),
  KEY `ADDED_TIMESTAMP_CHANNEL_INDEX_STATUS_IDX` (`ADDED_TIMESTAMP`,`CHANNEL_INDEX`,`STATUS`)
) ENGINE=InnoDB AUTO_INCREMENT=330966 DEFAULT CHARSET=utf8;

-- Dumpar struktur för tabell wagger_db.t_accumulated_data
DROP TABLE IF EXISTS `t_accumulated_data`;
CREATE TABLE IF NOT EXISTS `t_accumulated_data` (
  `CHANNEL_INDEX` smallint(5) unsigned DEFAULT NULL,
  `ACCUMULATED_BIN_END_TIME` int(11) unsigned DEFAULT NULL,
  `ACCUMULATED_BIN_SIZE` mediumint(8) unsigned DEFAULT NULL,
  `ACCUMULATED_NO_OF_SAMPLES` mediumint(8) unsigned DEFAULT NULL,
  `ACCUMULATED_VALUE` double DEFAULT NULL,
  `ACCUMULATED_TEXT` mediumtext,
  `ACCUMULATED_BINARY` mediumblob,
  UNIQUE KEY `T_DOWNSAMPLED_DATA_IDX` (`CHANNEL_INDEX`,`ACCUMULATED_BIN_END_TIME`,`ACCUMULATED_BIN_SIZE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumpar struktur för tabell wagger_db.t_channels
DROP TABLE IF EXISTS `t_channels`;
CREATE TABLE IF NOT EXISTS `t_channels` (
  `UNIQUE_INDEX` smallint(5) unsigned NOT NULL,
  `CHANNEL_SAMPLE_RATE` float unsigned DEFAULT NULL,
  `CHANNEL_MIN_VALUE` float DEFAULT NULL,
  `CHANNEL_MAX_VALUE` float DEFAULT NULL,
  `CHANNEL_FACTOR` float DEFAULT NULL,
  `CHANNEL_UNIT` varchar(50) DEFAULT NULL,
  `CHANNEL_TEXT_ID` varchar(50) DEFAULT NULL,
  `CHANNEL_DESCRIPTION` varchar(1000) DEFAULT NULL,
  `CHANNEL_FUNCTION` varchar(200) DEFAULT NULL,
  `CHANNEL_LOOKUP` varchar(2000) DEFAULT NULL,
  `OFFSET` smallint(5) unsigned DEFAULT NULL,
  `MODULE_INDEX` smallint(5) unsigned DEFAULT NULL,
  `DEVICE_INDEX` smallint(5) unsigned DEFAULT NULL,
  `HOST_INDEX` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`UNIQUE_INDEX`),
  KEY `t_channels_t_modules_FK` (`MODULE_INDEX`),
  KEY `t_channels_t_hosts_FK` (`HOST_INDEX`),
  KEY `t_channels_t_devices_FK` (`DEVICE_INDEX`),
  CONSTRAINT `t_channels_t_devices_FK` FOREIGN KEY (`DEVICE_INDEX`) REFERENCES `t_devices` (`DEVICE_UNIQUE_INDEX`),
  CONSTRAINT `t_channels_t_hosts_FK` FOREIGN KEY (`HOST_INDEX`) REFERENCES `t_host` (`HOST_UNIQUE_INDEX`),
  CONSTRAINT `t_channels_t_modules_FK` FOREIGN KEY (`MODULE_INDEX`) REFERENCES `t_modules` (`MODULE_UNIQUE_INDEX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumpar data för tabell wagger_db.t_channels: ~11 rows (ungefär)
/*!40000 ALTER TABLE `t_channels` DISABLE KEYS */;
INSERT INTO `t_channels` (`UNIQUE_INDEX`, `CHANNEL_SAMPLE_RATE`, `CHANNEL_MIN_VALUE`, `CHANNEL_MAX_VALUE`, `CHANNEL_FACTOR`, `CHANNEL_UNIT`, `CHANNEL_TEXT_ID`, `CHANNEL_DESCRIPTION`, `CHANNEL_FUNCTION`, `CHANNEL_LOOKUP`, `OFFSET`, `MODULE_INDEX`, `DEVICE_INDEX`, `HOST_INDEX`) VALUES
	(20, NULL, NULL, NULL, NULL, '\\u00B0C', NULL, 'Cooling water temperature', NULL, NULL, 20, 5, 0, 0),
	(22, NULL, NULL, NULL, NULL, NULL, NULL, 'Weather station excitatio', NULL, NULL, 22, 1, 0, 0),
	(23, NULL, NULL, NULL, NULL, NULL, NULL, 'Weather station temperature sensor voltage', NULL, NULL, 23, 1, 0, 0),
	(97, NULL, NULL, NULL, NULL, NULL, NULL, 'Makeup water conductivity', NULL, NULL, 1, 6, 0, 0),
	(140, NULL, NULL, NULL, NULL, NULL, NULL, 'RPi HETA 01 Raspicam', NULL, NULL, 0, 0, 3, 0),
	(160, NULL, NULL, NULL, NULL, NULL, NULL, 'RPi HETA 02 Raspicam', NULL, NULL, 0, 0, 4, 0),
	(162, NULL, NULL, NULL, NULL, NULL, NULL, 'Arduino AI0', NULL, NULL, 0, 0, 6, 0),
	(163, NULL, NULL, NULL, NULL, NULL, NULL, 'Arduino AI1', NULL, NULL, 0, 0, 6, 0),
	(600, NULL, NULL, NULL, NULL, NULL, NULL, 'LAN gateway host screenshot', NULL, NULL, 0, 0, 0, 4),
	(10001, NULL, NULL, NULL, NULL, '\\u00B0C', NULL, 'Weather station temperature', 'c23/c22', '336.098,314.553,294.524,275.897,258.563,242.427,227.398,213.394,200.339,188.163,176.803,166.198,156.294,147.042,138.393,130.306,122.741,115.661,109.032,102.824,97.006,91.553,86.439,81.641,77.138,72.911,68.940,65.209,61.703,58.405,55.304,52.385,49.638,47.050,44.613,42.317,40.151,38.110,36.184,34.366,32.651,31.031,29.500,28.054,26.687,25.395,24.172,23.016,21.921,20.885,19.903,18.973,18.092,17.257,16.465,15.714,15.001,14.324,13.682,13.073,12.493,11.943,11.420,10.923,10.450,10.000,9.572,9.165,8.777,8.408,8.056,7.721,7.402,7.097,6.807,6.530,6.266,6.014,5.774,5.544,5.325,5.116,4.916,4.724,4.542,4.367,4.200,4.040,3.887,3.741,3.601', 0, 0, 0, 0),
	(10002, NULL, NULL, NULL, NULL, NULL, NULL, 'Dome/feedwater level and superheat temperature camera image composite', 'c160[0 0 500 500 1000 0 720]&c180&c140', '', 0, 0, 0, 0);
/*!40000 ALTER TABLE `t_channels` ENABLE KEYS */;

-- Dumpar struktur för tabell wagger_db.t_client_servers
DROP TABLE IF EXISTS `t_client_servers`;
CREATE TABLE IF NOT EXISTS `t_client_servers` (
  `CLIENT_SERVER_UNIQUE_INDEX` smallint(5) unsigned NOT NULL,
  `CLIENT_SERVER_TEXT_ID` varchar(50) DEFAULT NULL,
  `CLIENT_SERVER_DESCRIPTION` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`CLIENT_SERVER_UNIQUE_INDEX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Dumpar data för tabell wagger_db.t_client_servers: ~2 rows (ungefär)
/*!40000 ALTER TABLE `t_client_servers` DISABLE KEYS */;
INSERT INTO `t_client_servers` (`CLIENT_SERVER_UNIQUE_INDEX`, `CLIENT_SERVER_TEXT_ID`, `CLIENT_SERVER_DESCRIPTION`) VALUES
	(1, '0.0.0.0', 'Default WAN gateway'),
	(2, '192.168.1.103', 'PC20843795 Energilabbet LAN gateway');
/*!40000 ALTER TABLE `t_client_servers` ENABLE KEYS */;

-- Dumpar struktur för tabell wagger_db.t_devices
DROP TABLE IF EXISTS `t_devices`;
CREATE TABLE IF NOT EXISTS `t_devices` (
  `DEVICE_UNIQUE_INDEX` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `DEVICE_TEXT_ID` varchar(50) DEFAULT NULL,
  `DEVICE_HARDWARE_ID` varchar(50) NOT NULL,
  `DEVICE_DESCRIPTION` varchar(200) DEFAULT NULL,
  `HOST_INDEX` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`DEVICE_HARDWARE_ID`),
  UNIQUE KEY `t_devices_UN` (`DEVICE_UNIQUE_INDEX`),
  KEY `t_devices_t_hosts_FK` (`HOST_INDEX`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Dumpar data för tabell wagger_db.t_devices: ~7 rows (ungefär)
/*!40000 ALTER TABLE `t_devices` DISABLE KEYS */;
INSERT INTO `t_devices` (`DEVICE_UNIQUE_INDEX`, `DEVICE_TEXT_ID`, `DEVICE_HARDWARE_ID`, `DEVICE_DESCRIPTION`, `HOST_INDEX`) VALUES
	(0, NULL, '0', 'No specified device', 0),
	(1, NULL, '1', 'NI cDAQ-9188 main chassis (upper floor)', 3),
	(2, NULL, '2', 'NI cDAQ-9188 aux chassis (control room)', 3),
	(3, NULL, '3', 'Raspicam on rpi_heta_01', 2),
	(4, NULL, '4', 'Raspicam on rpi_heta_02', 5),
	(5, NULL, '5', 'USB camera on LAN gateway host', 4),
	(6, NULL, '6', 'Arduino on rpi_heta_02', 5);
/*!40000 ALTER TABLE `t_devices` ENABLE KEYS */;

-- Dumpar struktur för tabell wagger_db.t_device_channels
DROP TABLE IF EXISTS `t_device_channels`;
CREATE TABLE IF NOT EXISTS `t_device_channels` (
  `CHANNEL_UNIQUE_INDEX` smallint(5) unsigned NOT NULL,
  `CHANNEL_SAMPLE_RATE` float unsigned DEFAULT NULL,
  `CHANNEL_MIN_VALUE` float unsigned DEFAULT NULL,
  `CHANNEL_MAX_VALUE` float unsigned DEFAULT NULL,
  `CHANNEL_TEXT_ID` varchar(50) DEFAULT NULL,
  `CHANNEL_DESCRIPTION` varchar(1000) DEFAULT NULL,
  `CHANNEL_FUNCTION` varchar(200) DEFAULT NULL,
  `CHANNEL_LOOKUP` varchar(2000) DEFAULT NULL,
  `CHANNEL_OFFSET` smallint(5) unsigned NOT NULL,
  `DEVICE_INDEX` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`DEVICE_INDEX`,`CHANNEL_OFFSET`),
  UNIQUE KEY `t_device_channels_UN` (`CHANNEL_UNIQUE_INDEX`),
  CONSTRAINT `t_device_channels_t_devices_FK` FOREIGN KEY (`DEVICE_INDEX`) REFERENCES `t_devices` (`DEVICE_UNIQUE_INDEX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumpar data för tabell wagger_db.t_device_channels: ~2 rows (ungefär)
/*!40000 ALTER TABLE `t_device_channels` DISABLE KEYS */;
INSERT INTO `t_device_channels` (`CHANNEL_UNIQUE_INDEX`, `CHANNEL_SAMPLE_RATE`, `CHANNEL_MIN_VALUE`, `CHANNEL_MAX_VALUE`, `CHANNEL_TEXT_ID`, `CHANNEL_DESCRIPTION`, `CHANNEL_FUNCTION`, `CHANNEL_LOOKUP`, `CHANNEL_OFFSET`, `DEVICE_INDEX`) VALUES
	(140, NULL, NULL, NULL, NULL, 'RPi HETA 01 Raspicam', NULL, NULL, 0, 3),
	(160, NULL, NULL, NULL, NULL, 'RPi HETA 02 Raspicam', NULL, NULL, 0, 4);
/*!40000 ALTER TABLE `t_device_channels` ENABLE KEYS */;

-- Dumpar struktur för tabell wagger_db.t_displays
DROP TABLE IF EXISTS `t_displays`;
CREATE TABLE IF NOT EXISTS `t_displays` (
  `DISPLAY_UNIQUE_INDEX` smallint(5) unsigned NOT NULL,
  `DISPLAY_TEXT_ID` varchar(50) DEFAULT NULL,
  `DISPLAY_DESCRIPTION` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`DISPLAY_UNIQUE_INDEX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumpar struktur för tabell wagger_db.t_host
DROP TABLE IF EXISTS `t_host`;
CREATE TABLE IF NOT EXISTS `t_host` (
  `HOST_UNIQUE_INDEX` smallint(5) unsigned NOT NULL,
  `HOST_TEXT_ID` varchar(50) DEFAULT NULL,
  `HOST_HARDWARE_ID` varchar(50) NOT NULL,
  `HOST_IP_ADDRESS` varchar(50) DEFAULT NULL,
  `HOST_PERSISTENT_DATA_PATH` varchar(200) DEFAULT NULL,
  `HOST_DATABASE_CONNECTION_STRING` varchar(200) DEFAULT NULL,
  `HOST_DESCRIPTION` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`HOST_HARDWARE_ID`),
  UNIQUE KEY `t_hosts_UN` (`HOST_UNIQUE_INDEX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Dumpar data för tabell wagger_db.t_host: ~6 rows (ungefär)
/*!40000 ALTER TABLE `t_host` DISABLE KEYS */;
INSERT INTO `t_host` (`HOST_UNIQUE_INDEX`, `HOST_TEXT_ID`, `HOST_HARDWARE_ID`, `HOST_IP_ADDRESS`, `HOST_PERSISTENT_DATA_PATH`, `HOST_DATABASE_CONNECTION_STRING`, `HOST_DESCRIPTION`) VALUES
	(0, '', '0', '', '', '', 'No specified host'),
	(1, 'dogger', '1', '192.168.1.194', '/home/heta/Z/data/files', 'server=dogger;port=3306;database=test;uid=user;password=pwd', 'LAN storage host'),
	(2, 'rpi_heta_01', '2', '192.168.1.226', '/home/pi/LS220D5EC/data/files/', NULL, 'RPi HETA 01'),
	(3, 'nidaq-daqc', '3', '192.168.1.193', 'Z:/data/files/', NULL, 'NI CompactDAQ acquisition host'),
	(5, 'rpi_heta_02', '5', '192.168.1.42', '/home/pi/LS220D5EC/data/files/', NULL, 'RPi HETA 02'),
	(4, 'PC20843795', '64-31-50-20-40-25', '192.168.1.103', NULL, '', 'LAN server host (control room)');
/*!40000 ALTER TABLE `t_host` ENABLE KEYS */;

-- Dumpar struktur för tabell wagger_db.t_modules
DROP TABLE IF EXISTS `t_modules`;
CREATE TABLE IF NOT EXISTS `t_modules` (
  `MODULE_UNIQUE_INDEX` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `MODULE_TEXT_ID` varchar(50) DEFAULT NULL,
  `MODULE_DESCRIPTION` varchar(200) DEFAULT NULL,
  `SLOT_INDEX` smallint(5) unsigned NOT NULL,
  `DEVICE_INDEX` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`SLOT_INDEX`,`DEVICE_INDEX`),
  UNIQUE KEY `t_modules_UN` (`MODULE_UNIQUE_INDEX`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Dumpar data för tabell wagger_db.t_modules: ~8 rows (ungefär)
/*!40000 ALTER TABLE `t_modules` DISABLE KEYS */;
INSERT INTO `t_modules` (`MODULE_UNIQUE_INDEX`, `MODULE_TEXT_ID`, `MODULE_DESCRIPTION`, `SLOT_INDEX`, `DEVICE_INDEX`) VALUES
	(0, NULL, 'No module specified', 0, 0),
	(1, NULL, NULL, 1, 1),
	(5, NULL, NULL, 1, 2),
	(2, NULL, NULL, 2, 1),
	(6, NULL, NULL, 2, 2),
	(3, NULL, NULL, 3, 1),
	(7, NULL, NULL, 3, 2),
	(4, NULL, NULL, 4, 1);
/*!40000 ALTER TABLE `t_modules` ENABLE KEYS */;

-- Dumpar struktur för tabell wagger_db.t_ports
DROP TABLE IF EXISTS `t_ports`;
CREATE TABLE IF NOT EXISTS `t_ports` (
  `PORT_UNIQUE_INDEX` smallint(5) unsigned NOT NULL,
  `PORT_TEXT_ID` varchar(50) DEFAULT NULL,
  `PORT_DESCRIPTION` varchar(200) DEFAULT NULL,
  `HOST_INDEX` smallint(5) unsigned DEFAULT NULL,
  `DEVICE_INDEX` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`PORT_UNIQUE_INDEX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Dumpar data för tabell wagger_db.t_ports: ~4 rows (ungefär)
/*!40000 ALTER TABLE `t_ports` DISABLE KEYS */;
INSERT INTO `t_ports` (`PORT_UNIQUE_INDEX`, `PORT_TEXT_ID`, `PORT_DESCRIPTION`, `HOST_INDEX`, `DEVICE_INDEX`) VALUES
	(1, '169.254.254.254', 'cDAQ-9188 main chassis address', 3, 1),
	(2, '169.254.254.253', 'cDAQ-9188 aux chassis addres', 3, 2),
	(3, 'video0', 'Raspicam on heta_rpi_01', 2, 3),
	(5, '0000.001a.0007.004.000.000.000.000.000', 'USB camera on WAN gateway host', 1, 10);
/*!40000 ALTER TABLE `t_ports` ENABLE KEYS */;

-- Dumpar struktur för tabell wagger_db.t_process
DROP TABLE IF EXISTS `t_process`;
CREATE TABLE IF NOT EXISTS `t_process` (
  `UPLINK_PROCESS_UNIQUE_INDEX` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `UPLINK_PROCESS_TEXT_ID` varchar(50) DEFAULT NULL,
  `UPLINK_PROCESS_DESCRIPTION` varchar(1000) DEFAULT NULL,
  `CHANNEL_INDEX` smallint(5) unsigned NOT NULL,
  `CLIENT_SERVER_INDEX` smallint(5) unsigned NOT NULL,
  `HOST_INDEX` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`CHANNEL_INDEX`,`CLIENT_SERVER_INDEX`,`HOST_INDEX`),
  UNIQUE KEY `t_uplinks_UN` (`UPLINK_PROCESS_UNIQUE_INDEX`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Dumpar data för tabell wagger_db.t_process: ~3 rows (ungefär)
/*!40000 ALTER TABLE `t_process` DISABLE KEYS */;
INSERT INTO `t_process` (`UPLINK_PROCESS_UNIQUE_INDEX`, `UPLINK_PROCESS_TEXT_ID`, `UPLINK_PROCESS_DESCRIPTION`, `CHANNEL_INDEX`, `CLIENT_SERVER_INDEX`, `HOST_INDEX`) VALUES
	(2, NULL, NULL, 160, 1, 5),
	(3, NULL, NULL, 160, 2, 5),
	(1, NULL, NULL, 10002, 2, 0);
/*!40000 ALTER TABLE `t_process` ENABLE KEYS */;

-- Dumpar struktur för tabell wagger_db.t_service
DROP TABLE IF EXISTS `t_service`;
CREATE TABLE IF NOT EXISTS `t_service` (
  `SERVICE_UNIQUE_INDEX` smallint(5) unsigned NOT NULL,
  `SERVICE_TEXT_ID` varchar(50) DEFAULT NULL,
  `SERVICE_DESCRIPTION` varchar(200) DEFAULT NULL,
  `SERVICE_REBOOT_NEXT` tinyint(4) DEFAULT NULL,
  `HOST_INDEX` smallint(5) unsigned DEFAULT NULL,
  UNIQUE KEY `t_hosts_UN` (`SERVICE_UNIQUE_INDEX`) USING BTREE,
  KEY `t_service_t_hosts_FK` (`HOST_INDEX`),
  CONSTRAINT `t_service_t_hosts_FK` FOREIGN KEY (`HOST_INDEX`) REFERENCES `t_host` (`HOST_UNIQUE_INDEX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumpar data för tabell wagger_db.t_service: ~0 rows (ungefär)
/*!40000 ALTER TABLE `t_service` DISABLE KEYS */;
INSERT INTO `t_service` (`SERVICE_UNIQUE_INDEX`, `SERVICE_TEXT_ID`, `SERVICE_DESCRIPTION`, `SERVICE_REBOOT_NEXT`, `HOST_INDEX`) VALUES
	(0, NULL, NULL, 0, 5);
/*!40000 ALTER TABLE `t_service` ENABLE KEYS */;

-- Dumpar struktur för tabell wagger_db.t_slots
DROP TABLE IF EXISTS `t_slots`;
CREATE TABLE IF NOT EXISTS `t_slots` (
  `SLOT_UNIQUE_INDEX` smallint(5) unsigned NOT NULL,
  `SLOT_DEVICE_INDEX` smallint(5) unsigned DEFAULT NULL,
  `SLOT_TEXT_ID` varchar(50) DEFAULT NULL,
  `SLOT_DESCRIPTION` varchar(200) DEFAULT NULL,
  `MODULE_INDEX` smallint(5) unsigned DEFAULT NULL,
  `DEVICE_INDEX` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`SLOT_UNIQUE_INDEX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='BehÃ¶vs denna verkligen? RÃ¤cker det inte med att ange SLOT_INDEX per modul?';

-- Dumpar data för tabell wagger_db.t_slots: ~16 rows (ungefär)
/*!40000 ALTER TABLE `t_slots` DISABLE KEYS */;
INSERT INTO `t_slots` (`SLOT_UNIQUE_INDEX`, `SLOT_DEVICE_INDEX`, `SLOT_TEXT_ID`, `SLOT_DESCRIPTION`, `MODULE_INDEX`, `DEVICE_INDEX`) VALUES
	(1, 1, 'Slot 01', NULL, 1, 1),
	(2, 2, 'Slot 02', NULL, 2, 1),
	(3, 3, 'Slot 03', NULL, 3, 1),
	(4, 4, 'Slot 04', NULL, 4, 1),
	(5, 5, 'Slot 05', NULL, 0, 1),
	(6, 6, 'Slot 06', NULL, 0, 1),
	(7, 7, 'Slot 07', NULL, 0, 1),
	(8, 8, 'Slot 08', NULL, 0, 1),
	(9, 1, 'Slot 01', NULL, 5, 2),
	(10, 2, 'Slot 02', NULL, 6, 2),
	(11, 3, 'Slot 03', NULL, 7, 2),
	(12, 4, 'Slot 04', NULL, 0, 2),
	(13, 5, 'Slot 05', NULL, 0, 2),
	(14, 6, 'Slot 06', NULL, 0, 2),
	(15, 7, 'Slot 07', NULL, 0, 2),
	(16, 8, 'Slot 08', NULL, 0, 2);
/*!40000 ALTER TABLE `t_slots` ENABLE KEYS */;

-- Dumpar struktur för tabell wagger_db.t_tasks
DROP TABLE IF EXISTS `t_tasks`;
CREATE TABLE IF NOT EXISTS `t_tasks` (
  `TASK_UNIQUE_INDEX` smallint(5) unsigned NOT NULL,
  `TASK_SAMPLE_RATE` float unsigned DEFAULT NULL,
  `TASK_TEXT_ID` varchar(50) DEFAULT NULL,
  `TASK_DESCRIPTION` varchar(200) DEFAULT NULL,
  `HOST_INDEX` smallint(5) unsigned DEFAULT NULL,
  `DEVICE_INDEX` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`TASK_UNIQUE_INDEX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

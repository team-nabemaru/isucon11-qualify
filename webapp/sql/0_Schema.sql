DROP TABLE IF EXISTS `isu_association_config`;
DROP TABLE IF EXISTS `isu_condition`;
DROP TABLE IF EXISTS `isu`;
DROP TABLE IF EXISTS `user`;

CREATE TABLE `isu` (
  `id` bigint AUTO_INCREMENT,
  `jia_isu_uuid` CHAR(36) NOT NULL UNIQUE,
  `name` VARCHAR(255) NOT NULL,
  `image` LONGBLOB,
  `character` VARCHAR(255),
  `jia_user_id` VARCHAR(255) NOT NULL,
  `created_at` DATETIME(6) DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` DATETIME(6) DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY(`id`),
  INDEX idx_character (`character`),
  INDEX idx_jiauserid (`jia_user_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

CREATE TABLE `isu_condition` (
  `id` bigint AUTO_INCREMENT,
  `jia_isu_uuid` CHAR(36) NOT NULL,
  `timestamp` DATETIME NOT NULL,
  `is_sitting` TINYINT(1) NOT NULL,
  `condition` VARCHAR(255) NOT NULL,
  `is_dirty` tinyint AS (CASE WHEN SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(`condition`, ',', 1), ',', -1), '=', -1) = 'true' THEN 1 ELSE 0 END) STORED,
  `is_overweight` tinyint AS (CASE WHEN SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(`condition`, ',', 2), ',', -1), '=', -1) = 'true' THEN 1 ELSE 0 END) STORED, 
  `is_broken` tinyint AS (CASE WHEN SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(`condition`, ',', 3), ',', -1), '=', -1) = 'true' THEN 1 ELSE 0 END) STORED,
  `score` tinyint AS (CASE is_dirty + is_overweight + is_broken WHEN 3 THEN 3 WHEN 0 THEN 0 ELSE 1 END) STORED,
  `message` VARCHAR(255) NOT NULL,
  `created_at` DATETIME(6) DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY(`id`),
  INDEX idx_jiaisuuuid_timestamp (`jia_isu_uuid`, `timestamp`),
  INDEX idx_jiaisuuuid (`jia_isu_uuid`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

CREATE TABLE `user` (
  `jia_user_id` VARCHAR(255) PRIMARY KEY,
  `created_at` DATETIME(6) DEFAULT CURRENT_TIMESTAMP(6)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

CREATE TABLE `isu_association_config` (
  `name` VARCHAR(255) PRIMARY KEY,
  `url` VARCHAR(255) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

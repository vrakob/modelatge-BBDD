-- MySQL Script generated by MySQL Workbench
-- Mon Apr  8 18:37:41 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Recomenacio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Recomenacio` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Recomenacio` (
  `idRecomenacio` INT NOT NULL AUTO_INCREMENT,
  `clientRecomana` INT NULL,
  PRIMARY KEY (`idRecomenacio`),
  UNIQUE INDEX `clientRecomana_UNIQUE` (`clientRecomana` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Clients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Clients` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Clients` (
  `idClients` INT NOT NULL AUTO_INCREMENT,
  `Recomenacio_idRecomenacio` INT NULL,
  `nomClient` VARCHAR(100) NULL,
  `carrerClient` VARCHAR(100) NULL,
  `ciutatClient` VARCHAR(45) NULL,
  `codiPostalClient` INT NULL,
  `paisClient` VARCHAR(45) NULL,
  `telefonClient` INT NULL,
  `emailClient` VARCHAR(45) NULL,
  `dateClient` DATETIME NULL,
  PRIMARY KEY (`idClients`),
  INDEX `fk_Clients_Recomenacio1_idx` (`Recomenacio_idRecomenacio` ASC),
  CONSTRAINT `fk_Clients_Recomenacio1`
    FOREIGN KEY (`Recomenacio_idRecomenacio`)
    REFERENCES `mydb`.`Recomenacio` (`idRecomenacio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Proveidor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Proveidor` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Proveidor` (
  `idProveidor` INT NOT NULL AUTO_INCREMENT,
  `nifProveidor` INT NOT NULL,
  `nomProveidor` VARCHAR(45) NULL,
  `carrerProveidor` VARCHAR(45) NULL,
  `ciutatProveidor` VARCHAR(45) NULL,
  `codiPostalProveidor` INT NULL,
  `paisProveidor` VARCHAR(45) NULL,
  `telefonProveidor` INT NULL,
  `faxProveidor` INT NULL,
  PRIMARY KEY (`idProveidor`),
  UNIQUE INDEX `nifProveidor_UNIQUE` (`nifProveidor` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Marca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Marca` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Marca` (
  `idMarca` INT NOT NULL AUTO_INCREMENT,
  `Proveidor_idProveidor` INT NOT NULL,
  `nomMarca` VARCHAR(45) NULL,
  PRIMARY KEY (`idMarca`, `Proveidor_idProveidor`),
  INDEX `fk_Marca_Proveidor1_idx` (`Proveidor_idProveidor` ASC),
  UNIQUE INDEX `nomMarca_UNIQUE` (`nomMarca` ASC),
  CONSTRAINT `fk_Marca_Proveidor1`
    FOREIGN KEY (`Proveidor_idProveidor`)
    REFERENCES `mydb`.`Proveidor` (`idProveidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ulleres`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Ulleres` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Ulleres` (
  `idUlleres` INT NOT NULL AUTO_INCREMENT,
  `Marca_idMarca` INT NOT NULL,
  `graduacioVidreDret` INT NULL,
  `graduacioVidreEsquerre` INT NULL,
  `tipusMuntura` ENUM('flotant', 'pasta', 'metàl.lica') NULL,
  `colorMuntura` VARCHAR(45) NULL,
  `colorVidreDret` VARCHAR(45) NULL,
  `colorVidreEsquerra` VARCHAR(45) NULL,
  `preu` INT NULL,
  PRIMARY KEY (`idUlleres`),
  INDEX `fk_Ulleres_Marca1_idx` (`Marca_idMarca` ASC),
  CONSTRAINT `fk_Ulleres_Marca1`
    FOREIGN KEY (`Marca_idMarca`)
    REFERENCES `mydb`.`Marca` (`idMarca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Empleat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Empleat` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Empleat` (
  `idEmpleat` INT NOT NULL AUTO_INCREMENT,
  `nomEmpleat` VARCHAR(45) NULL,
  PRIMARY KEY (`idEmpleat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Comandes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Comandes` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Comandes` (
  `idComandes` INT NOT NULL AUTO_INCREMENT,
  `Empleat_idEmpleat` INT NOT NULL,
  `Clients_idClients` INT NOT NULL,
  PRIMARY KEY (`idComandes`),
  INDEX `fk_Comandes_Empleat1_idx` (`Empleat_idEmpleat` ASC),
  INDEX `fk_Comandes_Clients1_idx` (`Clients_idClients` ASC),
  CONSTRAINT `fk_Comandes_Empleat1`
    FOREIGN KEY (`Empleat_idEmpleat`)
    REFERENCES `mydb`.`Empleat` (`idEmpleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comandes_Clients1`
    FOREIGN KEY (`Clients_idClients`)
    REFERENCES `mydb`.`Clients` (`idClients`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LlistaComandes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`LlistaComandes` ;

CREATE TABLE IF NOT EXISTS `mydb`.`LlistaComandes` (
  `idLlistaComandes` INT NOT NULL AUTO_INCREMENT,
  `Comandes_idComandes` INT NOT NULL,
  `Ulleres_idUlleres` INT NOT NULL,
  `quantitat` INT NULL,
  `preu` INT NULL,
  PRIMARY KEY (`idLlistaComandes`),
  INDEX `fk_LlistaComandes_Comandes1_idx` (`Comandes_idComandes` ASC),
  INDEX `fk_LlistaComandes_Ulleres1_idx` (`Ulleres_idUlleres` ASC),
  CONSTRAINT `fk_LlistaComandes_Comandes1`
    FOREIGN KEY (`Comandes_idComandes`)
    REFERENCES `mydb`.`Comandes` (`idComandes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LlistaComandes_Ulleres1`
    FOREIGN KEY (`Ulleres_idUlleres`)
    REFERENCES `mydb`.`Ulleres` (`idUlleres`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`Recomenacio`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Recomenacio` (`idRecomenacio`, `clientRecomana`) VALUES (1, 1);
INSERT INTO `mydb`.`Recomenacio` (`idRecomenacio`, `clientRecomana`) VALUES (2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Clients`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Clients` (`idClients`, `Recomenacio_idRecomenacio`, `nomClient`, `carrerClient`, `ciutatClient`, `codiPostalClient`, `paisClient`, `telefonClient`, `emailClient`, `dateClient`) VALUES (1, NULL, 'Client Joaquim Vinoba', 'Art, 90 atic 2', 'Barcelona', 08041, 'Espanya', 934569973, 'vrako@gmail.com', '12/02/2019');
INSERT INTO `mydb`.`Clients` (`idClients`, `Recomenacio_idRecomenacio`, `nomClient`, `carrerClient`, `ciutatClient`, `codiPostalClient`, `paisClient`, `telefonClient`, `emailClient`, `dateClient`) VALUES (2, 1, 'Client Sergi Graupera', 'Ptge Esperança,13', 'Badalaona', 08030, 'Espanya', 786786543, 'tuth@sevil.es', '30/03/2019');
INSERT INTO `mydb`.`Clients` (`idClients`, `Recomenacio_idRecomenacio`, `nomClient`, `carrerClient`, `ciutatClient`, `codiPostalClient`, `paisClient`, `telefonClient`, `emailClient`, `dateClient`) VALUES (3, 2, 'Client Marga Nunez', 'Carrer Nunez de Balboa,12', 'Lima', 067123, 'Perú', 873456231, 'marga@hotmail.com', '01/01/2019');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Proveidor`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Proveidor` (`idProveidor`, `nifProveidor`, `nomProveidor`, `carrerProveidor`, `ciutatProveidor`, `codiPostalProveidor`, `paisProveidor`, `telefonProveidor`, `faxProveidor`) VALUES (1, 43443630, 'Proveidor Badalona', 'Carrer art, 90', 'Badalona', 08023, 'Espanya', 897898765, 897898765);
INSERT INTO `mydb`.`Proveidor` (`idProveidor`, `nifProveidor`, `nomProveidor`, `carrerProveidor`, `ciutatProveidor`, `codiPostalProveidor`, `paisProveidor`, `telefonProveidor`, `faxProveidor`) VALUES (2, 65663876, 'Proveidor Argentina', 'Carrer del Moro,12', 'Buenos Aires', 12345, 'Argentina', 678909872, NULL);
INSERT INTO `mydb`.`Proveidor` (`idProveidor`, `nifProveidor`, `nomProveidor`, `carrerProveidor`, `ciutatProveidor`, `codiPostalProveidor`, `paisProveidor`, `telefonProveidor`, `faxProveidor`) VALUES (3, 23443657, 'Proveidor Bolivia', 'Carrer especial, s/n', 'Cochabamaba', 08987, 'Bolivia', 897657892, 654382912);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Marca`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Marca` (`idMarca`, `Proveidor_idProveidor`, `nomMarca`) VALUES (1, 1, 'Rayban');
INSERT INTO `mydb`.`Marca` (`idMarca`, `Proveidor_idProveidor`, `nomMarca`) VALUES (2, 2, 'Oklay');
INSERT INTO `mydb`.`Marca` (`idMarca`, `Proveidor_idProveidor`, `nomMarca`) VALUES (3, 1, 'Zara');
INSERT INTO `mydb`.`Marca` (`idMarca`, `Proveidor_idProveidor`, `nomMarca`) VALUES (4, 1, 'Desigual');
INSERT INTO `mydb`.`Marca` (`idMarca`, `Proveidor_idProveidor`, `nomMarca`) VALUES (DEFAULT, 3, 'MassimoDutti');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Ulleres`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Ulleres` (`idUlleres`, `Marca_idMarca`, `graduacioVidreDret`, `graduacioVidreEsquerre`, `tipusMuntura`, `colorMuntura`, `colorVidreDret`, `colorVidreEsquerra`, `preu`) VALUES (1, 1, 2, 3, 'flotant', 'Vermell', 'transparent', 'transparent', 10);
INSERT INTO `mydb`.`Ulleres` (`idUlleres`, `Marca_idMarca`, `graduacioVidreDret`, `graduacioVidreEsquerre`, `tipusMuntura`, `colorMuntura`, `colorVidreDret`, `colorVidreEsquerra`, `preu`) VALUES (2, 1, 0, 5, 'flotant', 'Verd', 'groc', 'groc', 25);
INSERT INTO `mydb`.`Ulleres` (`idUlleres`, `Marca_idMarca`, `graduacioVidreDret`, `graduacioVidreEsquerre`, `tipusMuntura`, `colorMuntura`, `colorVidreDret`, `colorVidreEsquerra`, `preu`) VALUES (3, 2, 0, 0, 'pasta', 'Groc', 'Groc', 'Groc', 50);
INSERT INTO `mydb`.`Ulleres` (`idUlleres`, `Marca_idMarca`, `graduacioVidreDret`, `graduacioVidreEsquerre`, `tipusMuntura`, `colorMuntura`, `colorVidreDret`, `colorVidreEsquerra`, `preu`) VALUES (4, 3, 1, 1, 'pasta', 'Gris Clar', 'transparent', 'transparent', 75);
INSERT INTO `mydb`.`Ulleres` (`idUlleres`, `Marca_idMarca`, `graduacioVidreDret`, `graduacioVidreEsquerre`, `tipusMuntura`, `colorMuntura`, `colorVidreDret`, `colorVidreEsquerra`, `preu`) VALUES (5, 3, 0, 0, 'metàl.lica', 'Perla', 'groc', 'groc', 100);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Empleat`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Empleat` (`idEmpleat`, `nomEmpleat`) VALUES (1, 'Empleat Joaquim');
INSERT INTO `mydb`.`Empleat` (`idEmpleat`, `nomEmpleat`) VALUES (2, 'Empleat Josep');
INSERT INTO `mydb`.`Empleat` (`idEmpleat`, `nomEmpleat`) VALUES (3, 'Empleat Pere');
INSERT INTO `mydb`.`Empleat` (`idEmpleat`, `nomEmpleat`) VALUES (4, 'Empleat Sergi');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Comandes`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Comandes` (`idComandes`, `Empleat_idEmpleat`, `Clients_idClients`) VALUES (1, 1, 1);
INSERT INTO `mydb`.`Comandes` (`idComandes`, `Empleat_idEmpleat`, `Clients_idClients`) VALUES (2, 1, 2);
INSERT INTO `mydb`.`Comandes` (`idComandes`, `Empleat_idEmpleat`, `Clients_idClients`) VALUES (3, 2, 1);
INSERT INTO `mydb`.`Comandes` (`idComandes`, `Empleat_idEmpleat`, `Clients_idClients`) VALUES (4, 3, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`LlistaComandes`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`LlistaComandes` (`idLlistaComandes`, `Comandes_idComandes`, `Ulleres_idUlleres`, `quantitat`, `preu`) VALUES (1, 1, 1, 2, 10);
INSERT INTO `mydb`.`LlistaComandes` (`idLlistaComandes`, `Comandes_idComandes`, `Ulleres_idUlleres`, `quantitat`, `preu`) VALUES (2, 1, 2, 4, 20);
INSERT INTO `mydb`.`LlistaComandes` (`idLlistaComandes`, `Comandes_idComandes`, `Ulleres_idUlleres`, `quantitat`, `preu`) VALUES (3, 1, 3, 1, 75);
INSERT INTO `mydb`.`LlistaComandes` (`idLlistaComandes`, `Comandes_idComandes`, `Ulleres_idUlleres`, `quantitat`, `preu`) VALUES (4, 2, 1, 1, 10);
INSERT INTO `mydb`.`LlistaComandes` (`idLlistaComandes`, `Comandes_idComandes`, `Ulleres_idUlleres`, `quantitat`, `preu`) VALUES (5, 3, 4, 5, 10);
INSERT INTO `mydb`.`LlistaComandes` (`idLlistaComandes`, `Comandes_idComandes`, `Ulleres_idUlleres`, `quantitat`, `preu`) VALUES (6, 3, 5, 2, 20);

COMMIT;

